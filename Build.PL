use strict;
use warnings;
use Module::Build;


my $builder = Module::Build->new(
	module_name         => 'JobApp',
	license             => 'GNU General Public License v3.0',
	dist_author         => 'Filippo Biondi <filomail@gmail.com.com>',
	dist_abstract       => 'Job application using Mojo',
	dist_version        => '0.01',

);

$builder->create_build_script();
