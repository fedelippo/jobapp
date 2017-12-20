package JobApp::Controller::Candidates;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the candidates page.

=cut

sub view {
	my ($self) = @_;
	my @cand = $self->db->resultset('Candidates')->search(
		{
			job_id => {'in'=>$self->every_param('jobs')}},
		{
			join => 'jobs',
			'+select' => ['jobs.title'],
			'+as' => ['job_title'],
		}
	);
	my $send=[];
	foreach my $tuple (@cand){
		my $tmp = { 'name' => $tuple->name, 'job_title' => $tuple->get_column('job_title') };
		my @others = $self->db->resultset('Candidates')->search(
			{
				name   => $tuple->name,
				job_id => {'!=' => $tuple->id}
			},
			{
				join => 'jobs',
				'+select' => ['jobs.title'],
				'+as' => ['job_title'],
			}
		);
		foreach my $i (@others){
			push @{$tmp->{jobs}}, {'job_id'=>$i->get_column('job_title')};
		}
		push @{$send}, $tmp;
	}
	$self->stash->{candijobs} = $send;
	$self->render(template => 'candidates');
}

1;
