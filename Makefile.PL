#
# $Id: Makefile.PL,v 1.4 2002/11/27 05:54:42 ctriv Exp $
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
