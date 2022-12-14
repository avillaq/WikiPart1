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

my $funtion = listaTitulos(@titulo);

print $q->header('text/html');
print<<HTML;
<!DOCTYPE html>
<html>
<head>
     <title>Wikipedia 0.1</title>
     <script>
     function enviarFor(){
        document.formula.submit();
     }
     </script>

</head>
<body>
    <h1>Nuestras paginas de wiki</h1>
    $funtion
    <hr>
    <a href="../new.html">Nueva Pagina</a><br>
    <a href="../index.html">Volver al Inicio</a>
</body>
</html>
HTML

sub listaTitulos(){
  my $lista="";
  foreach my $t(@_){
    $lista = $lista."<br><li>
    <form action='./view.pl' name='formView'>
    	<input type='hidden' name='title' value='$t'>
    	<a href='javascript:document.formView.submit();'>$t</a>
    </form>
    <form action='./delete.pl'>
    	<input type='hidden' name='title' value='$t'>
	<input type='submit' value='X'>
    </form>
    <form action='./edit.pl'>
        <input type='hidden' name='title' value='$t'>
	<input type='submit' value='E'>
    </form>
    </li>";
  }
  return "<ul>$lista</ul>";
}
