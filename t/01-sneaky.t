# $Id: 01-sneaky.t,v 1.1 2003/09/28 04:09:15 ctriv Exp $


use Test::More tests => 13;
use strict;

BEGIN { 
    use_ok('Acme::DNS::Correct', 'sneaky'); 
}


my $res = Net::DNS::Resolver->new;
isa_ok($res, 'Net::DNS::Resolver');

$res->nameservers('serv1.cl.msu.edu');

SKIP: {

	skip "You don't seem to have internet access.", 11 
		unless $res->query('www.google.com');  

	ok(!$res->search('lkjsdfhsdfsdlkfjsdfjh.com'));
	ok(!$res->query('lkjsdfhsdfsdlkfjsdfjh.com'));
	
	ok(my $ans = $res->send('lkjsdfhsdfsdlkfjsdfjh.com'));
	
	ok(!scalar $ans->answer);
	ok($ans->header->rcode eq 'NXDOMAIN');
	
	Acme::DNS::Correct->import('sneaky');
	
	$res = Net::DNS::Resolver->new;
	isa_ok($res, 'Net::DNS::Resolver');
	
	$res->nameservers('serv1.cl.msu.edu');
	
	ok(!$res->search('lkjsdfhsdfsdlkfjsdfjh.com'));
	ok(!$res->query('lkjsdfhsdfsdlkfjsdfjh.com'));
	
	ok($ans = $res->send('lkjsdfhsdfsdlkfjsdfjh.com'));
	
	ok(!scalar $ans->answer);
	ok($ans->header->rcode eq 'NXDOMAIN');	
}