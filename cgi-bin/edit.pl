#!C:/xampp/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;

my $dsn = "DBI:mysql:database=datospagina;host=127.0.0.1";
my $dbh = DBI->connect($dsn, "root", "") or die "No se pudo conectar";

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
    <link rel="stylesheet" href="../styles/general.css">
	<link rel="stylesheet" href="../styles/new.css">
     <title>Wikipedia 0.1</title>
</head>
<body>
    <div class="wrap">
        <h1>$titulo</h1>
        <form action="./new.pl" method="get">
            <input type="hidden" name="titulo" value="$titulo">
            <textarea class="inputTextArea" name="texto" rows="10">$texto</textarea>
    
            <input type="hidden" name="esNuevo" value="false">
    
            <input class="inputSubmit" type="submit" value="Enviar">
        </form>
        <a href="./list.pl">Cancelar</a>
    </div>
    
</body>
</html>
HTML

