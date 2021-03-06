#!/usr/bin/perl

# Simple implementation of Pollard's rho integer factorization algorithm.

# See also:
#   https://facthacks.cr.yp.to/rho.html
#   https://en.wikipedia.org/wiki/Pollard%27s_rho_algorithm

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use Math::AnyNum qw(:overload powmod gcd);

sub rho_factor ($n, $tries = 50000) {

    my sub f($x) {
        powmod($x, 2, $n) + 1;
    }

    my $x = f(2);
    my $y = f($x);

    for (1 .. $tries) {

        $x = f($x);
        $y = f(f($y));

        my $g = gcd($x - $y, $n);

        $g <= 1  and next;
        $g >= $n and last;

        return $g;
    }

    return 1;
}

say rho_factor(503 * 863);                   #=> 863
say rho_factor(33670570905491953);           #=> 36169843
say rho_factor(314159265358979323);          #=> 317213509
say rho_factor(242363923520394591022973);    #=> 786757556719
