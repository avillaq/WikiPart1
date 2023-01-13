#!C:/xampp/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;

my $dsn = "DBI:mysql:database=datospagina;host=127.0.0.1";
my $dbh = DBI->connect($dsn, "root", "") or die "No se pudo conectar";

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
		<link rel="stylesheet" href="../styles/general.css">
  	<link rel="stylesheet" href="../styles/list.css">

</head>
<body>
    <div class="wrap">
      <h1>Nuestras paginas de wiki</h1>

      <div class="list">
        <ul>$funtion</ul>
      </div>

      <hr>
      
      <div class="NavigationButton">
        <a href="../new.html">Nueva Pagina</a><br>
        <a href="../index.html">Volver al Inicio</a>
      </div>
      
    </div>
  
    
</body>
</html>
HTML

sub listaTitulos(){
  my $lista="";
  foreach my $t(@_){
    $lista = $lista."<li>
    <div class='item'>

    <label>$t</label>

    <form action='./view.pl'>
    	<input type='hidden' name='title' value='$t'>
	    <input type='submit' value='Ver'>
    </form>

    <form action='./edit.pl'>
      <input type='hidden' name='title' value='$t'>
	    <input type='submit' value='Editar'>
    </form>
    
    <form action='./delete.pl'>
    	<input type='hidden' name='title' value='$t'>
	    <input type='submit' value='X'>
    </form>

    
    </div>
    
    </li>";
  }
  return $lista;
}
