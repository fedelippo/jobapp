package JobSearch::Controller::Public;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the public page.

=cut

sub overview {
	my ($self) = @_;
	my $rs=$self->db->resultset('Agencies');
	$self->stash->{agencies} = [$rs->all];
	$rs = $self->db->resultset('Jobs')->search(
		{},
		{
			columns => [qw/skills/],
			distinct => 1
		}
	);
	$self->stash->{skills} = [$rs->all];

	$rs = $self->db->resultset('Jobs')->search(
		{},
		{
			columns => [qw/category/],
			distinct => 1
		}
	);
	$self->stash->{categories} = [$rs->all];

	$self->render(template => 'public');
}

1;
