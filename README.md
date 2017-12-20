JobApp: Simple Mojo application
===============================

This little web app combine job search capabilities for candidates and jobs management for recruiters.
This is *only* a proof of concept to prove how easy can be creating an entire web app using Mojolicious and SQLite.



Setting up an environment for the JobApp application
=====================================================

1. Install a recent version of perl  e.g. <http://perlbrew.pl> `perlbrew install 5.22.1`
2. Use that version of perl `perlbrew use 5.22.1`
3. Install cpanm (or something else which can install dependencies from a cpanfile, the rest of this will assume cpanm) <https://cpanmin.us>
4. Install local::lib `cpanm local::lib` (Optional, you don't have to do this inside a local lib but it does help keep things segregated)
5. Install the dependencies `cpanm -L local --installdeps .` (You can skip -L local if you're OK with just installing it in your basic perl library)
6. Set up your shell to use the local lib as default, `eval "$(perl -Mlocal::lib=local)"`, This will set up your shell to use the local lib as the current perl library, it just saves you having to run every perl command with "-Mlocal::lib=local" in the arguments
7. Run the tests `prove -l t/`
8. Start the app `morbo ./bin/app.pl` This will now run the Mojolicious app which will default to port 3000 on the local host

