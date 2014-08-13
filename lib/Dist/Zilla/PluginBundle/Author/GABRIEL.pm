package Dist::Zilla::PluginBundle::Author::GABRIEL;

# ABSTRACT: Dist::Zilla configurantion for GABRIEL's projects
our $VERSION = '0.01';
our $AUTHORITY = 'cpan:GABRIEL';

use Moose;
use Dist::Zilla;

with 'Dist::Zilla::Role::PluginBundle::Easy';

sub configure {
	my $self = shift;
	$self->add_plugins(
		'NameFromDirectory',
		'VersionFromModule',
		[
			MetaResources => {
				'repository.type'   => 'git'
				'repository.url'    => 'git://github.com/gabrielmad/${dist}'
				'repository.web'    => 'http://github.com/gabrielmad/${dist}'
				'bugtracker.web'    => 'http://github.com/gabrielmad/${dist}/issues'
				'bugtracker.mailto' => 'bug-${dist}@rt.cpan.org'
				'homepage'          => 'http://metacpan.org/release/${dist}'
			}
		],
		[ GatherDir  => { include_dotfiles => 1     }],
		[ PruneCruft => { except => '^\.travis.yml' }],
		[
			'Git::CommitBuild' => {
				release_branch  => 'build/%b',
				release_message => 'Release build of v%v (on %b)',
			}
		],
		'ReadmeFromPod',
		[ 'ReadmeAnyFromPod', 'ReadmePodInRoot', { type => 'pod', filename => 'README.pod' } ],
		[
			ChangelogFromGit => {
				exclude_message => '(\.pod|commit|Travis|POD|forgot|typo|dist.ini|branch)'
			}
		],
		'Test::Compile',
		'MinimumPerl',
		'AutoPrereqs',
		'PodWeaver',
		'PodCoverageTests',
		'PodSyntaxTests',
		'ManifestSkip',
		'MetaYAML',
		'License',
		'Readme',
		'InstallGuide',
		'ExtraTests',
		'ExecDir',
		'ShareDir',
		'MakeMaker',
		'Manifest',
		'TestRelease',
		'ConfirmRelease',
		'UploadToCPAN',
	);

	return;
}

1;