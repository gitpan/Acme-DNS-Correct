#
# $Id: Makefile.PL,v 1.1 2003/09/21 17:52:15 ctriv Exp $
#
use ExtUtils::MakeMaker;


WriteMakefile(
	NAME		  => 'Acme::DNS::Correct',
	VERSION_FROM  => 'Correct.pm',
	PREREQ_PM	  => {
		'Net::DNS'   => 0,
		'Test::More' => 0,
	},	
	ABSTRACT_FROM => 'Correct.pm',
	AUTHOR        => 'Chris Reinhardt <ctriv@dyndns.org>',
);
