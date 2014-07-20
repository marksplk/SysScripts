#!/usr/bin/perl

use strict;
use LWP::UserAgent;
use HTTP::Request;
use Data::Dumper;


my $ua = LWP::UserAgent->new();
my $uri = "https://localhost:8089/services/";
my $user = "admin";
my $pass = "changeme";
$ua->credentials($uri, "splunk", $user, $pass);
#$ua->ssl_opts(verify_hostname => 0);
#my $request = HTTP::Request->new(GET => $uri);
my $response = $ua->get($uri);
print "Resp ". Dumper($response)."\n";
