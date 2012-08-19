package Plack::App::DataSection;
use strict;
use warnings;
our $VERSION = '0.01';

use MIME::Base64;
use Data::Section::Simple;
use Plack::MIME;

sub get_data {
    my $file = shift;

    my $content = get_data_section($file);
    my $mime_type = Plack::MIME->mime_type($file);

    if (is_binary($mime_type)) {
        $content = decode_base64($content);
    }
    else {
        $mime_type .= ' charset=UTF-8;';
    }
    ($content, $mime_type);
}

sub is_binary {
    my $mime_type = shift;

    $mime_type !~ /\b(?:text|xml)\b/;
}


1;
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
