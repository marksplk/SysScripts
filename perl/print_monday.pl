#!/usr/bin/env perl
#
use strict;
use warnings;

use DateTime;

my $year = 2013;
my $dt   = DateTime->new(
    'year'  => $year,
        'month' => 1,
            'day'   => 1,
            );

            # find first Monday
            while ( $dt->day_name() ne 'Monday' ) {
                $dt->add( 'days' => 1 );
                }

                while ( $dt->year() == $year ) {
                    print $dt->strftime("%m_%d_%Y\n");
                        $dt->add( 'weeks' => 1 );
                       }
