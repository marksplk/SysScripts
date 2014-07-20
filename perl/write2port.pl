#!/usr/bin/perl -w
#use strict;
#use IO::Socket::INET6;
use IO::Socket::INET;

my $text = 'Hello This is nedumbur=village, my city=nedumbur;';
my $text1 = `cat /etc/passwd`;
my $host = "2620:70:8000:c301:129a:ddff:fe69:102b";
my $port = "8081";

my $sock = IO::Socket::INET->new(
#my $sock = IO::Socket::INET6->new(
   PeerAddr   =>   $host,
   PeerPort   =>   $port,
   Proto      =>   'tcp'
   );

$sock or die "Can't connect to $host:$port\n";

@files=`ls /Users/ithangasamy/OpenDJ-2.4.3/logs`;
foreach $file (@files)
{
$file1="/Users/ithangasamy/OpenDJ-2.4.3/logs/" . $file;
$text1=`cat $file1`;
syswrite $sock,$text or die "Cant write to sock $sock\n";
print $sock $text1 or die "Cant write to sock $sock\n";
print "Done.. with $file\n";
}
$sock->shutdown(1);
close $sock;

exit;
