# $Id: 00-test.t,v 1.1 2003/09/21 17:52:15 ctriv Exp $


use Test::More tests => 6;
use strict;

BEGIN { 
    use_ok('Acme::DNS::Correct'); 
}


my $res = Acme::DNS::Correct->new;

$res->nameservers('ns.wpi.edu');

ok(!$res->search('lkjsdfhsdfsdlkfjsdfjh.com'));
ok(!$res->query('lkjsdfhsdfsdlkfjsdfjh.com'));

ok(my $ans = $res->send('lkjsdfhsdfsdlkfjsdfjh.com'));

ok(!scalar $ans->answer);
ok($ans->header->rcode eq 'NXDOMAIN');