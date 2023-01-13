#!C:/xampp/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;

my $dsn = "DBI:mysql:database=datospagina;host=127.0.0.1";
my $dbh = DBI->connect($dsn, "root", "") or die "No se pudo conectar";

my $t = $q->param('title');

my $sth = $dbh->prepare("delete from paginas where title=?");
$sth->execute($t);

$sth->finish;
$dbh->disconnect;

print "Location: ./list.pl \n\n";



