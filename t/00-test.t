# $Id: 00-test.t,v 1.3 2003/09/28 04:19:38 ctriv Exp $


use Test::More tests => 13;
use strict;

BEGIN { 
    use_ok('Acme::DNS::Correct'); 
}


my $res = Acme::DNS::Correct->new;
isa_ok($res, 'Acme::DNS::Correct');

$res->nameservers('serv1.cl.msu.edu');

SKIP: {

	skip "You don't seem to have internet access.", 11 
		unless $res->query('www.google.com');  

	ok(!$res->search('lkjsdfhsdfsdlkfjsdfjh.com'));
	ok(!$res->query('lkjsdfhsdfsdlkfjsdfjh.com'));
	
	ok(my $ans = $res->send('lkjsdfhsdfsdlkfjsdfjh.com'));
	
	ok(!scalar $ans->answer);
	ok($ans->header->rcode eq 'NXDOMAIN');
		
	$res = Net::DNS::Resolver->new;
	isa_ok($res, 'Net::DNS::Resolver');
	
	$res->nameservers('serv1.cl.msu.edu');
	
	ok($res->search('lkjsdfhsdfsdlkfjsdfjh.com'));
	ok($res->query('lkjsdfhsdfsdlkfjsdfjh.com'));
	
	ok($ans = $res->send('lkjsdfhsdfsdlkfjsdfjh.com'));
	
	ok(scalar $ans->answer);
	ok($ans->header->rcode eq 'NOERROR');	
}