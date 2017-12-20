package JobApp::Controller::Job;

use Mojo::Base qw/Mojolicious::Controller/;

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the job page.

=cut

sub view {
	my ($self) = @_;

	$self->render(template => 'agency');
}

sub create {
	my ($self) = @_;
	$self->db->resultset('Jobs')->create({
		reference	=> $self->param('reference'),
		title		=> $self->param('title'),
		description => $self->param('description'),
		agency_id	=> $self->param('agency_id'),
		category	=> $self->param('category'),
		skills		=> $self->param('skills'),
		id			=> $self->db->resultset('Jobs')->get_column('id')->max()+1,
		});
	$self->flash(job_saved => 1);
	$self->redirect_to('admin');
}

sub delete {
	my ($self) = @_;
	my $job = $self->db->resultset('Jobs')->find({reference=>$self->param('reference')});
	$job->delete;
	$self->flash('job_deleted'=>1);
	$self->redirect_to('admin');
}

sub search {
	my ($self) = @_;
	my %filters = ();

	# We want to filter based on Agency, Skills and Category
	$filters{agency_id} = $self->param('agency_id')
		if $self->param('agency_id') and $self->param('agency_id') ne 'all';
	$filters{skills} = $self->param('skill_id')
		if $self->param('skill_id') and $self->param('skill_id') ne 'all';
	$filters{category} = $self->param('category_id')
		if $self->param('category_id') and $self->param('category_id') ne 'all';

	my $rs = $self->db->resultset('Jobs')->search_rs(
		{
			'title' => {like => "%".$self->param('job_title')."%"},
			%filters,
		},
		{
			join => 'agencies',
			'+select' => ['agencies.name'],
			'+as' => ['agency_name'],
		}

	);
	$self->stash->{joblist} = [$rs->all];
	$self->render(template=>'jobs');
}

sub interest {
	my ($self) = @_;
	my $rs = $self->db->resultset('Jobs')->search(
		{
			'me.id' => {'in'=>$self->every_param('jobs')}
		},
		{
			join => 'agencies',
			'+select' => ['agencies.name'],
			'+as' => ['agency_name'],
		}
	);
	$self->stash->{jobsinterested} = [$rs->all];
	$self->render(template=>'interest');
}

sub register_interest {
	my ($self) = @_;
	my $jobs = $self->every_param('jobs')//{};
	my $name = $self->param('name');

	foreach my $job (@{$jobs}){
		$self->db->resultset('Candidates')->create({
			name	  => $name,
			job_id => $job
			});
	}
	$self->flash(interest_saved => 1);
	$self->redirect_to('public');

}

1;
