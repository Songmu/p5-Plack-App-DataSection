use inc::Module::Install;
name 'Plack-App-DataSection';
all_from 'lib/Plack/App/DataSection.pm';

requires 'MIME::Base64';
requires 'Plack';
requires 'Data::Section::Simple';
requires 'HTTP::Date';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'HTTP::Request::Common';
test_requires 'HTTP::Response';

install_script('bin/dir2data-section.pl');

auto_set_repository;
auto_include;
WriteAll;
