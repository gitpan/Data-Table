# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..83\n"; }
END {print "not ok 1\n" unless $loaded;}
use Data::Table;
use Data::Dumper;
#use Data::Dumper;
$loaded = 1;
print "ok loaded\n";

$t = Data::Table::fromCSV("aaa.csv");
if ($t) {
  print "ok 1 fromCSV\n";
} else {
  print "not ok 1 fromCSV\n";
}

if ($t->colIndex('Grams "(a.a.)"/100g sol.') == 3) {
  print "ok 2 colIndex\n";
} else {
  print "not ok 2 colIndex\n";
}
if ($t->nofCol() == 6) {
  print "ok 3 nofCol\n";
} else {
  print "not ok 3 nofCol\n";
}
if ($t->nofRow() == 9) {
  print "ok 4 nofRow\n";
} else {
  print "not ok 4 nofRow\n";
}
if ($t->html()) {
  print "ok 5 html\n";
} else {
  print "not ok 5 html\n";
}
if ($t->html2()) {
  print "ok 6 html2\n";
} else {
  print "not ok 6 html2\n";
}
if ($t->nofCol() == 6) {
  print "ok 7 nofCol\n";
} else {
  print "not ok 7 nofCol\n";
}
$fun = sub {return lc;};
if ($t->colMap(0,$fun)) {
  print "ok 8 colMap\n";
} else {
  print "not ok 8 colMap\n";
}
$fun = sub {$_->[0] = ucfirst $_->[0]};
if ($t->colsMap($fun)) {
  print "ok 9 colsMap\n";
} else {
  print "not ok 9 colsMap\n";
}
if (($row = $t->delRow(0)) && $t->nofRow==8) {
  print "ok 10 delRow()\n";
} else {
  print "not ok 10 delRow()\n";
}
if ($t->addRow($row) && $t->nofRow==9) {
  print "ok 11 addRow()\n";
} else {
  print "not ok 11 addRow()\n";
}
if ((@rows = $t->delRows([0,2,3])) && $t->nofRow==6) {
  print "ok 12 delRows()\n";
} else {
  print "not ok 12 delRows()\n";
}
$t->addRow(shift @rows,0);
$t->addRow(shift @rows,2);
$t->addRow(shift @rows,3);
if ($t->nofRow==9) {
  print "ok 13 delRows() & addRow()\n";
} else {
  print "not ok 13 delRows() & addRow()\n";
}
if (($col = $t->delCol("Solvent")) && $t->nofCol==5) {
  print "ok 14 delCol()\n";
} else {
  print "not ok 14 delCol()\n";
}
if ($t->addCol($col, "Solvent",2) && $t->nofCol==6) {
  print "ok 15 addCol()\n";
} else {
  print "not ok 15 addCol()\n";
}
if ((@cols = $t->delCols(["Temp, C","Amino acid","Entry"])) && $t->nofCol==3) {
  print "ok 16 delCols()\n";
} else {
  print "not ok 16 delCols()\n";
}
$t->addCol(shift @cols,"Temp, C",2);
$t->addCol(shift @cols,"Amino acid",0);
$t->addCol(shift @cols,"Entry",1);
if ($t->nofCol==6) {
  print "ok 17 delCols() & addCol()\n";
} else {
  print "not ok 17 delCols() & addCol()\n";
}
if ($t->rowRef(3)) {
  print "ok 18 rowRef()\n";
} else {
  print "not ok 18 rowRef()\n";
}
if ($t->rowRefs(undef)) {
  print "ok 19 rowRefs()\n";
} else {
  print "not ok 19 rowRefs()\n";
}
if ($t->row(3)) {
  print "ok 20 row()\n";
} else {
  print "not ok 20 row()\n";
}
if ($t->colRef(3)) {
  print "ok 21 colRef()\n";
} else {
  print "not ok 21 colRef()\n";
}
if ($t->colRefs(["Temp, C", "Amino acid", "Solvent"])) {
  print "ok 22 colRefs()\n";
} else {
  print "not ok 22 colRefs()\n";
}
if ($t->col(3)) {
  print "ok 23 col()\n";
} else {
  print "not ok 23 col()\n";
}
if ($t->rename("Entry", "New Entry")) {
  print "ok 24 rename()\n";
} else {
  print "not ok 24 rename()\n";
}
$t->rename("New Entry", "Entry");
@t = $t->col("Entry");
$t->replace("Entry", [1..$t->nofRow()], "New Entry");
if ($t->replace("New Entry",\@t, 'Entry')) {
  print "ok 25 replace()\n";
} else {
  print "not ok 25 replace()\n";
}
if ($t->swap("Amino acid","Entry")) {
  print "ok 26 swap()\n";
} else {
  print "not ok 26 swap()\n";
}
$t->swap("Amino acid","Entry");
if ($t->elm(3,"Temp, C")==79) {
  print "ok 27 elm()\n";
} else {
  print "not ok 27 elm()\n";
}
if (${$t->elmRef(3,"Temp, C")}==79) {
  print "ok 28 elmRef()\n";
} else {
  print "not ok 28 elmRef()\n";
}
$t->setElm(3,"Temp, C", 100);
if ($t->elm(3,"Temp, C")==100) {
  print "ok 29 setElm()\n";
} else {
  print "not ok 29 setElm()\n";
}
$t->setElm(3,"Temp, C",79);
if ($t->sort('Ref No.',1,1,'Temp, C',1,0)) {
  print "ok 30 sort()\n";
} else {
  print "not ok 30 sort()\n";
}
if (($t2=$t->match_pattern('$_->[0] =~ /^L-a/ && $_->[3]<0.2')) && $t2->nofRow()==2) {
  print "ok 31 match_pattern()\n";
} else {
  print "not ok 31 match_pattern()\n";
}
if (($t2=$t->match_string('allo|cine')) && $t2->nofRow()==4) {
  print "ok 32 match_string()\n";
} else {
  print "not ok 32 match_string()\n";
}
if ($t2=$t->clone()) {
  print "ok 33 clone()\n";
} else {
  print "not ok 33 clone()\n";
}
if ($t2=$t->subTable([2..4],[0..($t->nofCol()-1)])) {
  print "ok 34 subTable()\n";
} else {
  print "not ok 34 subTable()\n";
}
if ($t2=$t->subTable([2..4],undef)) {
  print "ok 35 subTable(\$rowIdcsRef,undef)\n";
} else {
  print "not ok 35 subTable(\$rowIdcsRef,undef)\n";
}
if (($t2=$t->subTable(undef,[0..($t->nofCol-1)]))&& ($t2->nofRow() == 9)) {
  print "ok 36 subTable(undef,\$colIDsRef)\n";
} else {
  print "not ok 36 subTable(undef,\$colIDsRef)\n";
}
if ($t->rowMerge($t2) && $t->nofRow()==18) {
  print "ok 37 rowMerge()\n";
} else {
  print "not ok 37 rowMerge()\n";
}
$t->delRows([9..$t->nofRow-1]);
$t2=$t->subTable([0..($t->nofRow-1)],[1]);
$t2->rename(0, "new column");
if ($t->colMerge($t2) && $t->nofCol()==7) {
  print "ok 38 colMerge()\n";
} else {
  print "not ok 38 colMerge()\n";
}
$t->delCol('new column');
$t->sort('Entry',Data::Table::STRING,Data::Table::ASC);
$t2 = Data::Table::fromTSV("aaa.tsv");
if ($t->tsv eq $t2->tsv) {
  print "ok 39 fromTSV and tsv\n";
} else {
  print "not ok 39 fromTSV and tsv\n";
}

$t2 = $t->rowHashRef(1);
if (scalar keys(%$t2) == $t->nofCol) {
  print "ok 40 rowHashRef\n";
} else {
  print "not ok 40 rowHashRef\n";
}

$t2=Data::Table::fromCSV('aaa.csv');
if (equal($t->rowRefs(), $t2->rowRefs())) {
  print "ok 41 looks good so far\n";
} else {
  print "not ok 41 something broke already\n";
}

$t2->rename(0,'New1');
$t2->rename(1,'New2');
$t2->rename(2,'New3');
$t2->rename(3,'New4');
$t2->rename(4,'New5');
$t2->rename(5,'New6');
$t2->delRows([2,3,4]);
$t->delRows([0,8]);
$t3 = $t->join($t2, 0, [0,1], [0,1]);
if ($t3->nofRow == 4) {
  print "ok 42 join: inner\n";
} else {
  print "not ok 42 join: inner\n";
}
$t3 = $t->join($t2, 1, [0,1], [0,1]);
if ($t3->nofRow == 7) {
  print "ok 43 join: left outer\n";
} else {
  print "not ok 43 join: left outer\n";
}
$t3 = $t->join($t2, 2, [0,1], [0,1]);
if ($t3->nofRow == 6) {
  print "ok 44 join: right outer\n";
} else {
  print "not ok 44 join: right outer\n";
}
$t3 = $t->join($t2, 3, [0,1], [0,1]);
if ($t3->nofRow == 9) {
  print "ok 45 join: full outer\n";
} else {
  print "not ok 45 join: full outer\n";
}

$t = Data::Table->fromCSVi("aaa.csv");
$t2=Data::Table::fromCSV('aaa.csv');
if (equal($t->rowRefs(), $t2->rowRefs())) {
  print "ok 46 instant method fromCSVi\n";
} else {
  print "not ok 46 instant method fromCSVi\n";
}
$t = Data::Table->fromTSVi("aaa.tsv");
if (equal($t->rowRefs(), $t2->rowRefs())) {
  print "ok 47 instant method fromTSVi\n";
} else {
  print "not ok 47 instant method fromTSVi\n";
}

$t2 = $t->match_string("L-proline");
$t3 = $t->rowMask(\@Data::Table::OK, 1);
if ($t2->nofRow == 1 && $t3->nofRow == $t->nofRow - $t2->nofRow) {
  print "ok 48 rowMask\n";
} else {
  print "not ok 48 rowMask\n";
}

@h = $t2->header;
@h2 = @h;
$h2[1] = "new name";
$t2->header(\@h2);
if ($t2->rename("new name", $h[1])) {
  print "ok 49 header rename\n";
} else {
  print "not ok 49 header rename\n";
}

$t = new Data::Table(
  [
    ['Tom', 'male', 'IT', 65000],
    ['John', 'male', 'IT', 75000],
    ['Peter', 'male', 'HR', 85000],
    ['Mary', 'female', 'HR', 80000],
    ['Nancy', 'female', 'IT', 55000],
    ['Jack', 'male', 'IT', 88000],
    ['Susan', 'female', 'HR', 92000]
  ],
  ['Name', 'Sex', 'Department', 'Salary'], 0);

sub average {
  my @data = @_;
  my ($sum, $n) = (0, 0);
  foreach $x (@data) {
    next unless $x;
    $sum += $x; $n++;
  }
  return ($n>0)?$sum/$n:undef;
}

$t2 = $t->group([],["Name", "Salary"], [sub {scalar @_}, \&average], ["Nof Employee", "Average Salary"], 0);
if ($t2->nofRow == 1 && $t2->elm(0,0) == 7) {
  print "ok 50 group with no key\n";
} else {
  print "not ok 50 group with no key\n";
}

$t2 = $t->group(["Department","Sex"],["Name", "Salary"], [sub {scalar @_}, \&average], ["Nof Employee", "Average Salary"]);
if ($t2->nofRow == 4 && $t2->nofCol == 4) {
  print "ok 51 group\n";
} else {
  print "not ok 51 group\n";
}

$t2 = $t2->pivot("Sex", Data::Table::STRING, "Average Salary", ["Department"]);
#print $t2->html;
if ($t2->nofRow == 2 && $t2->nofCol == 3) {
  print "ok 52 pivot\n";
} else {
  print "not ok 52 pivot\n";
}

my $s = $t2->csv;
#open my $fh, "<", \$s or die "Cannot open in-memory file\n";
my $fh;
open($fh, "ccc.csv") or die "Cannot open ccc.csv to read\n";
my $t_fh=Data::Table::fromCSV($fh);
close($fh);
if ($t_fh->csv eq $s) {
  print "ok 53 fromCSV using file handler\n";
} else {
  print "not ok 53 fromCSV using file handler\n";
}
#print $t2->csv;

#my $s = $t2->tsv;
#open my $fh, "<", \$s or die "Cannot open in-memory file\n";
open($fh, "ccc.csv") or die "Cannot open ccc.csv to read\n";
my $t_fh=Data::Table::fromTSV($fh);
close($fh);
if ($t_fh->tsv eq $s) {
  print "ok 54 fromTSV using file handler\n";
} else {
  print "not ok 54 fromTSV using file handler\n";
}
#print $t2->csv;

$Well=["A_1", "A_2", "A_11", "A_12", "B_1", "B_2", "B_11", "B_12"];
$t = new Data::Table([$Well], ["PlateWell"], 1);
$t->sort("PlateWell", 1, 0);
#print join(" ", $t->col("PlateWell"));
# in string sorting, "A_11" and "A_12" appears before "A_2";
my $my_sort_func = sub {
  my @a = split /_/, $_[0];
  my @b = split /_/, $_[1];
  return ($a[0] cmp $b[0]) || (int($a[1]) <=> int($b[1]));
};
$t->sort("PlateWell", $my_sort_func, 0);
#print join(" ", $t->col("PlateWell"));
#$t->sort("PlateWell", $my_sort_func, 1);
#print join(" ", $t->col("PlateWell"));

if (join("", $t->col("PlateWell")) eq join("", @$Well)) {
  print "ok 55 sort using custom operator\n";
} else {
  print "not ok 55 fromTSV custom operator\n";
}

#open $fh, "<", \$s or die "Cannot open in-memory file\n";
open($fh, "colon.csv") or die "Cannot open colon.csv to read\n";
$t_fh=Data::Table::fromCSV($fh, 1, undef, {delimiter=>':', qualifier=>"'"});
close($fh);
  # col_A,col_B,col_C
  # 1,"2, 3 or 5",3.5
  # one,one:two,"double"", single'"
if ($t_fh->elm(0, 'col_B') eq "2, 3 or 5"
    && $t_fh->elm(1, 'col_B') eq "one:two"
    && $t_fh->elm(1, 'col_C') eq 'double", single\'') {
  print "ok 56 using custom delimiter and qualifier for fromCSV\n";
} else {
  print "not ok 56 using custom delimiter and qualifier for fromCSV\n";
} 

$t = Data::Table::fromCSV("bbb.csv", 1, undef, {skip_lines=>1, delimiter=>':', skip_pattern=>'^\s*#'});
$s = $t->tsv;
$t2 = Data::Table::fromTSV("aaa.tsv", 1);
if (equal($t->rowRefs, $t2->rowRefs)) {
  print "ok 57 using skip_lines and skip_pattern for fromCSV\n";
} else {
  print "not ok 57 using skip_lines and skip_pattern for fromCSV\n";
}

if (Data::Table::fromFileGuessOS("t_unix.csv")==0 &&
    Data::Table::fromFileGuessOS("t_dos.csv")==1 && 
    Data::Table::fromFileGuessOS("t_mac.csv")==2){
  print "ok 58 using fromFileGuessOS\n";
} else {
  print "not ok 58 using fromFileGuessOS\n";
}

my $t_unix=Data::Table::fromFile("t_unix.csv");
my $t_unix_noheader=Data::Table::fromFile("t_unix_noheader.csv");
my $t_dos=Data::Table::fromFile("t_dos.csv");
my $t_mac=Data::Table::fromFile("t_mac.csv");
if (equal($t_unix->rowRefs, $t_unix_noheader->rowRefs) &&
    equal($t_unix->rowRefs, $t_dos->rowRefs) &&
    equal($t_unix->rowRefs, $t_mac->rowRefs)) {
  print "ok 59 using fromFile\n";
} else {
  print "not ok 59 using fromFile\n";
}

$t=Data::Table::fromFile("ttt.tsv", {transform_element=>0});
$t2=Data::Table::fromFile("ttt.csv");
if (equal($t->rowRefs(), $t2->rowRefs())) {
  print "ok 60 using fromFile, fromTSV, transform_element\n";
} else {
  print "not ok 60 using fromFile, fromTSV, transform_element\n";
}

if ($t->html({odd=>'myOdd', even=>'myEven', header=>'myHeader'})) {
  print "ok 61 using html with CSS class\n";
} else {
  print "not ok 61 using html with CSS\n";
}

my %myRow=(COL_B=>'xyz');
if ($t->addRow(\%myRow, 1) && $t->nofRow==3 && equal($t->rowRef(1), [undef, 'xyz'])) {
  print "ok 62 addRow() with hash_ref\n";
} else {
  print "not ok 62 addRow() with hash_ref\n";
}

$t2 = $t->clone();
map {$t2->rename($_, $_."2")} $t2->header;
$t->rowMerge($t2, {byName => 1});
if ($t->nofRow == $t2->nofRow*2 && $t->nofCol == $t2->nofCol) {
  print "ok 63 rowMerge() with byName=1\n";
} else {
  print "not ok 63 rowMerge() with byName=1\n";
}

$t->rowMerge($t2, {byName => 1, addNewCol => 1});
if ($t->nofRow == $t2->nofRow*3 && $t->nofCol == $t2->nofCol*2) {
  print "ok 64 rowMerge() with byName=1 and addNewCol=1\n";
} else {
  print "not ok 64 rowMerge() with byName=1 and addNewCol=1\n";
}

$t2->rename(0, 'COL_A');
$t2->rename(1, 'COL_B');
$t->rowMerge($t2, {byName => 0, addNewCol => 1});
if ($t->nofRow == $t2->nofRow*4 && $t->nofCol == $t2->nofCol) {
  print "ok 65 rowMerge() with byName=0 and addNewCol=1\n";
} else {
  print "not ok 65 rowMerge() with byName=0 and addNewCol=1\n";
}

$t=Data::Table::fromCSV("aaa.csv", 1);
$t2=$t->clone();
$t = $t->join($t2, 0, ['Amino acid'], ['Amino acid'], {renameCol => 1});
if ($t->nofRow == $t2->nofRow && $t->nofCol == $t2->nofCol*2-1) {
  print "ok 66 join() with auto renaming duplicate column names\n";
} else {
  print "not ok 66 join() with auto renaming duplicate column names\n";
}

$t=Data::Table::fromCSV("aaa.csv", 1);
$t2=$t->clone();
$t->colMerge($t2, {renameCol => 1});
if ($t->nofCol == $t2->nofCol*2) {
  print "ok 67 colMerge() with auto renaming duplicate column names\n";
} else {
  print "not ok 67 colMerge() with auto renaming duplicate column names\n";
}

$t=Data::Table::fromCSV("aaa.csv", 1);
if (($t2=$t->match_pattern_hash('$_{"Amino acid"} =~ /^L-a/ && $_{"Grams \"(a.a.)\""}<0.2')) && $t2->nofRow()==2) {
  print "ok 68 match_pattern_hash()\n";
} else {
  print "not ok 68 match_pattern()\n";
}
$t2 = $t->subTable($t->{OK}, undef, {useRowMask=>1});
#print Dumper($t2);
if ($t2->nofRow()==2) {
  print "ok 69 subTable() with row mask\n";
} else {
  print "not ok 69 subTable() with row mask\n";
}

$t2->moveCol('Amino acid', 1);
if (($t2->header)[1] eq 'Amino acid') {
  print "ok 70 moveCol()\n";
} else {
  print "not ok 70 moveCol()\n";
}
#Entry,Amino acid,Solvent,"Grams ""(a.a.)""/100g sol.","Temp, C",Ref No.
$t2->reorder(["Amino acid","Temp, C","Entry"]);
if (($t2->header)[1] eq 'Temp, C') {
  print "ok 71 reorder()\n";
} else {
  print "not ok 71 reorder()\n";
}

$t = new Data::Table([[1,1,5,6], [1,2,3,5], [2,1,6,1], [2,2,2,4]],
  ['id','time','x1','x2'], Data::Table::ROW_BASED);

$t2=new Data::Table([],['id','count', 'rows']);
$t->each_group(['id'], sub { my ($t, $rows) = @_; $t2->addRow([$t->elm(0,'id'), $t->nofRow, join(":", @$rows)])});
my $t3 = new Data::Table([[1,2], [2,2], ['0:1','2:3']], ['id','count','rows'], Data::Table::COLUMN_BASED);
if (equal($t2->rowRefs, $t3->rowRefs)) {
  print "ok 72 group_each()\n";
} else {
  print "not ok 72 group_each()\n";
}

$t2 = $t->melt(['id','time']);
if ($t2->nofRow == 8 && $t2->nofCol == 4) {
  print "ok 73 melt()\n";
} else {
  print "not ok 73 melt()\n";
}
$t3 = $t2->cast(['id'],'variable',Data::Table::STRING,'value', \&average);
my $t=new Data::Table([[1,4,5.5], [2,4,2.5]], ['id','x1','x2'], Data::Table::ROW_BASED);
if (equal($t3->rowRefs, $t->rowRefs)) {
  print "ok 74 cast()\n";
} else {
  print "not ok 74 cast()\n";
}

$t3 = $t2->cast(['id'],undef,Data::Table::STRING,'value', \&average);
my $t=new Data::Table([[1,4.75], [2,3.25]], ['id','(all)'], Data::Table::ROW_BASED);
if (equal($t3->rowRefs, $t->rowRefs)) {
  print "ok 75 cast() without column to split\n";
} else {
  print "not ok 75 cast() withotu column to split\n";
}

$t3 = $t2->cast(undef,undef,Data::Table::STRING,'value', \&average);
my $t=new Data::Table([[4]], ['(all)'], Data::Table::ROW_BASED);
if (equal($t3->rowRefs, $t->rowRefs)) {
  print "ok 76 cast() with total aggregate\n";
} else {
  print "not ok 76 cast() with total aggregate\n";
}

$t_product=Data::Table::fromFile("Product.csv");
$t_product->match_pattern_hash('$_{UnitPrice} > 20');
$t_product->addCol('No', 'IsExpensive');
if ($t_product->lastCol == 6 && $t_product->elm(0, 'IsExpensive') eq 'No') {
  print "ok 77 addCol() with default value\n";
} else {
  print "not ok 77 addCol() with default value\n";
}

if (@{$t_product->{MATCH}} == 37) {
  print "ok 78 {MATCH} after match_pattern_hash\n";
} else {
  print "not ok 78 {MATCH} after match_pattern_hash\n";
}

$t_product->setElm($t_product->{MATCH}, 'IsExpensive', 'Yes');
if ($t_product->elm($t_product->{MATCH}->[0], 'IsExpensive') eq 'Yes') {
  print "ok 79 setElm() for multiple cells\n";
} else {
  print "not ok 79 setElm() for multiple cells\n";
}

my $cnt = 0;
my $next = $t_product->iterator();
while (my $row = &$next) {
  $cnt ++;
  $t_product->setElm(&$next(1), 'ProductName', 'New! '.$row->{ProductName});
}

if ($cnt == 77 && $t_product->elm(0, 'ProductName') =~ /^New!/) {
  print "ok 80 iterator()\n";
} else {
  print "not ok 80 iterator()\n";
}

$t_product->addRow({NewColumn=>'xyz',CategoryName=>'myname'}, undef, {addNewCol=>1});
if ($t_product->hasCol('NewColumn') && $t_product->elm($t_product->lastRow, 'NewColumn') eq 'xyz') {
  print "ok 81 addRow() that adds a column\n";
} else {
  print "not ok 81 addRow() that adds a column\n";
}

# use DBI;
# $dbh= DBI->connect("DBI:mysql:test", "test", "") or die $dbh->errstr;
# $t = Data::Table::fromSQL($dbh, "show tables");
# print $t->csv;
# $t = Data::Table->fromSQLi($dbh, "show tables");
# print $t->csv;

# @_ in match_
package FOO; @ISA = qw(Data::Table);

1;

package main;

$foo=FOO->new([[11,12],[21,22],[31,32]],['header1','header2'],0);
if ($foo->csv) {
  print "ok 82 Inheritance\n";
} else {
  print "not ok 82 Inheritance\n";
}
$foo = FOO->fromCSVi("aaa.csv");
if ($foo->csv) {
  print "ok 83 inheritated instant method fromCSVi\n";
} else {
  print "not ok 83 inheritated instant method fromCSVi\n";
}

sub equal {
  my ($data, $data2) = @_;
  my ($i ,$j);
  return 0 if (scalar @$data != scalar @$data2);
  for ($i=0; $i< scalar @$data; $i++) {
    return 0 if (scalar @{$data->[$i]} != scalar @{$data2->[$i]});
    for ($j=0; $j< scalar @{$data->[0]}; $j++) {
      return 0 if $data->[$i]->[$j]!= $data2->[$i]->[$j];
    }
  }
  return 1;
}
