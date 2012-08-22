use inc::Module::Install;
name 'Plack-App-DataSection';
all_from 'lib/Plack/App/DataSection.pm';

requires 'MIME::Base64';
requires 'Plack';
requires 'Data::Section::Simple';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';

install_script('bin/dir2data_section.pl');

auto_set_repository;
auto_include;
WriteAll;
