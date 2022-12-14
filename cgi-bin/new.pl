#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
my $titulo = $q->param('titulo');
my $texto = $q->param('texto');
$texto =~ s/\n/<br>/g;

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=paginasDB;host=192.168.1.23";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar");

my $sth = $dbh->prepare("INSERT INTO paginas(title, text)VALUES(?,?)");
$sth->execute($titulo,$texto);
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
    $texto
    <hr>

    <h2>Pagina grabada <a href="./list.pl">Listado de Paginas</a></h2>

</body>
</html>

HTML
