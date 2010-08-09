# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Data-Table.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 5;
BEGIN { use_ok('Data::Table') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $tbl = Data::Table->new(3, 4, 0);
ok(defined $tbl, "Construct Table");

$tbl->setCell(0, 0, 1);
is($tbl->getCell(0, 0), 1, "Set & Get Cell Method");

$tbl->turnRight();
my @col = $tbl->getCol(3);
is_deeply(\@col,[1,0,0],"Turn Right Test");

$tbl->turnLeft();
@col = $tbl->getCol(0);
is_deeply(\@col,[1,0,0,0],"Turn Left Test");

1;
__END__
