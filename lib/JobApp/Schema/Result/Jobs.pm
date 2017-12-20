package JobApp::Schema::Result::Jobs;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('jobs');
__PACKAGE__->add_columns(
	id => {
		data_type => 'integer',
		is_auto_increment => 1,
	},
	reference => {
		data_type => 'text',
	},
	title => {
		data_type => 'text',
	},
	description => {
		data_type => 'text',
	},
	agency_id => {
		data_type => 'text',
	},
	category => {
		data_type => 'text',
	},
	skills => {
		data_type => 'text',
	},
);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint([qw/reference/]);
__PACKAGE__->belongs_to(agencies=>'JobApp::Schema::Result::Agencies', 'agency_id');
__PACKAGE__->has_many(candidates=>'JobApp::Schema::Result::Candidates', 'job_id');
1;
