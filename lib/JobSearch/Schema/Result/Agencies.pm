package JobSearch::Schema::Result::Agencies;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('agencies');

__PACKAGE__->add_columns(
	id => {
		data_type => 'integer',
		is_auto_increment => 1,
	},
	name => {
		data_type => 'text',
	}
);
__PACKAGE__->add_unique_constraint([qw/name/]);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many(
	jobs => 'JobSearch::Schema::Result::Jobs',
	'agency_id'
);

1;
