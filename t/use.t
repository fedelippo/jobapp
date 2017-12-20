#!/usr/bin/env perl

use strict;
use Test::Most;

use_ok('JobApp');
use_ok('JobApp::Controller::Public');
use_ok('JobApp::Controller::Job');
use_ok('JobApp::Controller::Index');
use_ok('JobApp::Controller::Candidates');
use_ok('JobApp::Controller::Agency');
use_ok('JobApp::Controller::Admin');


use_ok('JobApp::Schema');
use_ok('JobApp::Schema::Result::Agencies');
use_ok('JobApp::Schema::Result::Candidates');
use_ok('JobApp::Schema::Result::Jobs');

done_testing;

