package JobSearch::Schema::Result::Candidates;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('candidates');
__PACKAGE__->add_columns(
	name   => {
		data_type => 'text',
	},
	job_id => {
		data_type => 'integer',
	},
);

# In the database, Candidates' schema has a composite Primary Key
# made of "job_id" and "name" but for reasons I don't have time
# to investigate DBIx::Class complains having a composite PK so
# I've added a unique constraint to have eventually the same behaviour.
__PACKAGE__->set_primary_key('job_id');
__PACKAGE__->add_unique_constraint(['name', 'job_id']);
__PACKAGE__->has_many( jobs => 'JobSearch::Schema::Result::Jobs', 'id' );




1;
