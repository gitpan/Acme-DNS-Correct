# $Id: 00-load.t,v 1.2 2002/11/10 12:19:26 ctriv Exp $


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