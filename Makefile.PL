use inc::Module::Install 0.91;

name 'GitalistWeb';
all_from 'lib/GitalistWeb.pm';

requires 'Catalyst::Runtime' => '5.7006';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::View::TT';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
