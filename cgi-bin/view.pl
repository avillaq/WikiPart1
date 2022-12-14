#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=paginasDB;host=192.168.1.23";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");

my @titulo;
my $i = 0;

my $sth = $dbh->prepare("select * from paginas");
$sth->execute();

while(my @row = $sth->fetchrow_array){
  $titulo[$i] = $row[0];
  $i++;
}
$sth->finish;
$dbh->disconnect;

################para probar, eliminar
my $t = $q->param('title');

print $q->header('text/html');
print<<HTML;
<!DOCTYPE html>
<html>
<head>
     <title>Wikipedia 0.1</title>
</head>
<body>
    <a href="./list.pl">Retroceder</a>
    <p>$t</p>
</body>
</html>
HTML

