#!C:/xampp/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
my $titulo = $q->param('titulo');
my $texto = $q->param('texto');

my $isNuevo = $q->param('esNuevo');

##Conexion con la base de datos###################

my $dsn = "DBI:mysql:database=datospagina;host=127.0.0.1";
my $dbh = DBI->connect($dsn, "Alex", "") or die "No se pudo conectar";

my $sth;
if($isNuevo eq "true"){
  $sth = $dbh->prepare("INSERT INTO paginas(title, text)VALUES(?,?)");
  $sth->execute($titulo,$texto);
}else{
  $sth = $dbh->prepare("UPDATE paginas SET text=? where title=?");
  $sth->execute($texto,$titulo);
}
$sth->finish;
$dbh->disconnect;

##Fin de la conexion ####################

my $newTexto = $texto;
$newTexto =~ s/\n/<br>/g;
print $q->header('text/html');
print<<HTML;
<!DOCTYPE html>
<html>
<head>
    <title>Wikipedia 0.1</title>
</head>
<body>
    <h1>$titulo</h1>
    $newTexto
    <hr>

    <h2>Pagina grabada <a href="./list.pl">Listado de Paginas</a></h2>

</body>
</html>

HTML
