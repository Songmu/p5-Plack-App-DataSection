package Plack::App::DataSection;
use strict;
use warnings;
our $VERSION = '0.01';

use parent qw/Plack::Component/;
use MIME::Base64;
use Data::Section::Simple;
use Plack::MIME;

use Plack::Util::Accessor qw(encoding);

sub call {
    my $self = shift;
    my $env  = shift;

    my $path = $env->{PATH_INFO} || '';
    if ($path =~ /\0/) {
        return $self->return_400;
    }
    $path =~ s!^/!!;

    my ($data, $content_type) = $self->get_content($path);

    return $self->return_404 unless $data;

    return [ 200, [
        'Content-Type'   => $content_type,
        'Content-Length' => length($data),
    ], [ $data ] ];
}

sub return_400 {
    my $self = shift;
    return [400, ['Content-Type' => 'text/plain', 'Content-Length' => 11], ['Bad Request']];
}

sub return_404 {
    my $self = shift;
    return [404, ['Content-Type' => 'text/plain', 'Content-Length' => 9], ['not found']];
}

sub data_section {
    my $self = shift;

    $self->{_reader} ||= Data::Section::Simple->new(ref $self);
}

sub get_content {
    my ($self, $path) = @_;

    my $content = $self->data_section->get_data_section($path);
    return () unless defined $content;

    my $mime_type = Plack::MIME->mime_type($path);

    if (is_binary($mime_type)) {
        $content = decode_base64($content);
    }
    else {
        my $encoding = $self->encoding || 'UTF-8';
        $mime_type .= "; charset=$encoding;";
    }
    ($content, $mime_type);
}

sub is_binary {
    my $mime_type = shift;

    $mime_type !~ /\b(?:text|xml|javascript|json)\b/;
}

1;
__DATA__
@@ sample.txt
さんぷる

__END__

=head1 NAME

Plack::App::DataSection -

=head1 SYNOPSIS

  use Plack::App::DataSection;

=head1 DESCRIPTION

Plack::App::DataSection is

=head1 AUTHOR

Masayuki Matsuki E<lt>y.songmu@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
