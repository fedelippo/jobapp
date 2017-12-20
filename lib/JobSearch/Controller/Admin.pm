package JobSearch::Controller::Admin;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the admin page.

=cut

sub overview {
	my ($self) = @_;
	my $rs = $self->db->resultset('Agencies');
	$self->stash->{'agency_list'} = [ $rs->all() ];
	$rs = $self->db->resultset('Jobs');
	$self->stash->{'job_list'} = [ $rs->all() ];


	$self->render(template => 'admin');
}

1;
