package JobApp::Controller::Agency;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the agency page.

=cut

sub view {
	my ($self) = @_;

	$self->render(template => 'agency');
}

sub create {
	my ($self) = @_;
	$self->db->resultset('Agencies')->create({
		name => $self->param('name'),
		id	 => $self->db->resultset('Agencies')->get_column('id')->max()+1,
		});
	$self->flash(agency_saved => 1);
	$self->redirect_to('admin');
}
1;
