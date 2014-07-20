#!/usr/local/bin/perl

use HTML::Entities;
my $file = shift;
open ("IN", $file ) or "Cannot open $file :$!\n";

while (<IN>) {
	chomp;
	if (/<steps><\!\[CDATA[/) {
		s#<\!\[CDATA[#<step><step_number>1</step_number><actions>#;	
		s#</p>#</actions><expectedresults></expectedresults><execution_type>1</execution_type></step><step><ste    p_number>2</step_number><actions></p>#;
	}
    	encode_entites();	
}
