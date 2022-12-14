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

my $titulo = $q->param('title');
my $texto;
my $sth = $dbh->prepare("select text from paginas where title=?");
$sth->execute($titulo);

while(my @row = $sth->fetchrow_array){
	$texto = $row[0];
}
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
    <h1>$titulo</h1>
    <form action="./new.pl" method="get">
    <input type="hidden" name="titulo" value="$titulo">
    <label for="texto">Texto</label>
    <textarea name="texto" id="" cols="30" rows="10">$texto</textarea><br>
    <input type="submit" value="Enviar">
    </form>
    <a href="./list.pl">Cancelar</a>
</body>
</html>
HTML

