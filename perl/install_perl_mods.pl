#!/usr/bin/perl -w
    use CPANPLUS;
    use strict;
    CPANPLUS::Backend->new( conf => { prereqs => 1 } )->install(
        modules => [ qw(
            Date::Simple
            File::Slurp
            LWP::Simple
            MIME::Base64
            MIME::Parser
            MIME::QuotedPrint
        ) ]
    );
