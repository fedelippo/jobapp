package JobApp;

use Mojo::Base 'Mojolicious';
use JobApp::Schema;

=head1 DESCRIPTION

This is the base JobApp application.

It has the following routes available by default:

L<JobApp::Controller::Index>
L<JobApp::Controller::Public>
L<JobApp::Controller::Admin>
L<JobApp::Controller::Agency>
L<JobApp::Controller::Candidates>
L<JobApp::Controller::Job>

=cut

# Set up some attributes for our app, for instance a database schema
has _welcome => sub {
    my ($self) = @_;

    return {
        welcome => 'Welcome to the JobApp app',
    };
};

=func C<startup>

Called by L<Mojolicious> when the application starts

=cut

sub startup {
    my ($self) = @_;

    $self->setup_directories();
    $self->setup_plugins();
    $self->setup_helpers();
    $self->setup_routes();

    return;
}

=func C<setup_directories>

Sets up the template and static directories.

=cut

sub setup_directories {
    my ($self) = @_;

    # All templates found in $ENV{MOJO_HOME}/root/templates
    $self->renderer->paths([$self->home->rel_file('root/templates')]);
    # All static files found in $ENV{MOJO_HOME}/root/static
    $self->static->paths([$self->home->rel_file('root/static')]);

    return;
}

=func C<setup_plugins>

Sets up any plugins which are required.  If you wished to add configuration
from the configuration file for a new plugin you could do it like so.

Assuming you had the following config file.

    {
        dummy: {
            option1: "value",
            options2: "value"
        }
    }

Then you could load that configuration as follows.

    $self->plugin('Welcome', $self->config->{welcome});

=cut

sub setup_plugins {
    my ($self) = @_;

    $self->plugin('JSONConfig');
    $self->plugin('tt_renderer');

    return;
}


=func C<setup_helpers>

Set up C<Mojolicious/helper>, so we can access our attributes without using the
app object directly.  It also makes them useable directly in templates.

    # Before a helper
    $self->app->welcome
    # After a helper
    $self->welcome

=cut

sub setup_helpers {
    my ($self) = @_;

    $self->helper( welcome => sub { $self->app->_welcome; } );
	$self->helper( db => sub { return setup_db_handler()} );

    return;
}

=func C<setup_routes>

Set up our various C<Mojolicious::Routes> which actually do the grunt work for
the application.

=cut

sub setup_routes {
    my ($self) = @_;

    my $r = $self->routes->namespaces(['JobApp::Controller']);
    $r->get('/')->to('index#index');
    $r->get('/admin')->to('admin#overview')->name('admin');
    $r->get('/public')->to('public#overview')->name('public');
    $r->post('/agency/create')->to('agency#create')->name('add_agency');
    $r->post('/job/create')->to('job#create')->name('add_job');
    $r->post('/job/search')->to('job#search')->name('search_job');
    $r->post('/job/interest')->to('job#interest')->name('interest_job');
    $r->post('/job/register-interest')->to('job#register_interest')->name('register_interest_job');
    $r->post('/candidates/view')->to('candidates#view')->name('candidates_view');

    return;
}

sub setup_db_handler{ return JobApp::Schema->connect('dbi:SQLite:share/test.db','','', {sqlite_unicode=>1}) }

1;
