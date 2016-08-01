use v6;
use Test;

plan 2;

# RT #82946
subtest 'signature binding outside of routine calls' => {
    plan 2;

    my ($f, $o, @a);
    @a = 2, 3, 4;
    :($f, $o, $) := @a;

    is $f, 2, 'f eq 2 after binding';
    is $o, 3, 'o eq 3 after binding';
};

# RT #127444
subtest 'smartmatch on signatures with literal strings' => {
    plan 2;
    is :("foo") ~~ :("bar"), False, 'two differing literal strings';
    is :(Str)   ~~ :("foo"), False, 'type object and a literal string';
}

# vim: ft=perl6
