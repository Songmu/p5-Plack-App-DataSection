requires 'Data::Section::Simple';
requires 'HTTP::Date';
requires 'MIME::Base64';
requires 'Plack';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.36';
};
