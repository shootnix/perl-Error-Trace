use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Error::Trace',
    VERSION_FROM => 'lib/Error/Trace.pm', 
    ABSTRACT     => 'Lightweight error object with trace accumulation.',
    AUTHOR       => 'Alex Ponomarev <shootnix@gmail.com>',
    LICENSE      => 'perl',
    MIN_PERL_VERSION => '5.16',
    PREREQ_PM    => {
        
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/shootnix/perl-Error-Trace.git',
                web  => 'https://github.com/shootnix/perl-Error-Trace',
            },
            bugtracker => {
                web => 'https://github.com/shootnix/perl-Error-Trace/issues',
            },
        },
    },
);