package Acme::DNS::Correct;
#
# $Id: CGIForm.pm,v 1.28 2003/06/16 20:14:35 ctriv Exp $
#
use strict;
use vars qw($VERSION @ISA $ROOT_OF_EVIL);
use Net::DNS;

$VERSION = 0.1;
@ISA     = qw(Net::DNS::Resolver);

$ROOT_OF_EVIL ||= $ENV{'ROOT_OF_EVIL'} || '64.94.110.11';

sub search {
	my $self = shift;
	my $ans  = $self->SUPER::search(@_) || return;
	
	_remove_evil($ans);
	
	return $ans
} 

sub query {
	my $self = shift;
	my $ans  = $self->SUPER::query(@_) || return;
	
	_remove_evil($ans);
	
	return $ans
} 

sub send {
	my $self = shift;
	my $ans  = $self->SUPER::send(@_);
	
 	_remove_evil($ans);
	
	return $ans
} 


sub _remove_evil {
	my ($packet) = @_;
	
	my @ans = $packet->answer;
	
	if (@ans == 1) {
		my $rr = $ans[0];
		
		if ($rr->type eq 'A' and $rr->address eq $ROOT_OF_EVIL) {
			$packet->pop('answer')     while $packet->answer;
			$packet->pop('authority')  while $packet->authority;
			$packet->pop('additional') while $packet->additional;
			
			$packet->header->rcode('NXDOMAIN');
		}
	}
}
			

=head1 NAME

Acme::DNS::Correct - Fix the DNS System

=head1 DESCRIPTION

Acme::DNS::Correct is a subclass of L<Net::DNS::Resolver|Net::DNS::Resolver>,
adding functionality that returns sanity to the DNS system.  Consult the 
Net::DNS manpages for comprehensive documentation on using this module.

=head1 SYNOPSIS

 my $res = Acme::DNS::Correct->new;
 
 # use $res just like a Net::DNS::Resolver object, but the answers it 
 # returns will make sense, and be correct.

=head1 CONFIGURATION

This module strips out answers from C<64.94.110.11>, a place of evil that you
should keep far far away from your poor defenseless computer.  

If you would rather ignore another root of evil, set the C<ROOT_OF_EVIL> 
envirement variable, or the C<$Acme::DNS::ROOT_OF_EVIL> variable.

=head1 TODO

Check that the root of evil is really an IP address.

Allow for more than one root of evil.

Zone transfers are not safe from evil.

=head1 AUTHOR

Chris Reinhardt E<lt>ctriv@dyndns.orgE<gt>

=head1 COPYRIGHT

Copyright (c) 2003 Chris Reinhardt E<lt>ctriv@dyndns.orgE<gt>.  All rights 
reserved.  This program is free software; you can redistribute it and/or 
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<Net::DNS>

=cut
	
	
1;
__END__

	
	
