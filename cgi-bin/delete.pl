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

my $t = $q->param('title');

my $sth = $dbh->prepare("delete from paginas where title=?");
$sth->execute($t);

$sth->finish;
$dbh->disconnect;

print $q->header('text/html');
print<<HTML;
<!DOCTYPE html>
<html>
<head>
     <title>Wikipedia 0.1</title>
</head>
<body>
    <a href="./list.pl">Retroceder</a>
    <p>Borrado con exito</p>
</body>
</html>
HTML

