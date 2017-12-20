#!/usr/bin/env perl

use strict;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

# Mojo home directory is one level up
# see Mojo::Home for how it detects the home directory
$ENV{MOJO_HOME} = "$FindBin::Bin/..";

use Mojolicious::Commands;
Mojolicious::Commands->start_app('JobApp');
