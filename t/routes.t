#!/usr/bin/env perl

use strict;
use Test::Most;
use Test::Mojo;

my $t = Test::Mojo->new('JobApp');

$t->get_ok('/admin')
	->status_is(200)
	->content_like(qr/Admin page/)
	->content_like(qr/Add jobs/)
	->content_like(qr/Search candidates/);

# sets max_redirects and stay set for the life of the test
# object until it's changed
$t->ua->max_redirects(1);

$t->post_ok('/agency/create' => form => {name=>'Jobbie'} )
	->status_is(200)
	->content_like(qr/Agency saved!/);

$t->post_ok('/agency/delete' => form => {name=>'Jobbie'} )
	->status_is(200)
	->content_like(qr/Agency deleted!/);

$t->post_ok('/job/create' => form =>
	{
		reference 	=> 'A123TestJob',
		title 		=> 'TestJob',
		description => 'TestJob description',
		category 	=> 'ITTEST',
		skills		=> 'multi language',
		agency_id	=> 1
	}
)
	->status_is(200)
	->content_like(qr/Job saved!/);

$t->post_ok('/job/delete' => form =>{reference=>'A123TestJob'})
	->status_is(200)
	->content_like(qr/Job deleted!/);

done_testing();
