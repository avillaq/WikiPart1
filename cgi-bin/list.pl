#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q = CGI->new;

print $q->header('text/html');
print<<HTML;
<!DOCTYPE html>
<html>
<head>
     <title>Wikipedia 0.1</title>
</head>
<body>
    <h1>Nuestras paginas de wiki</h1>
    <p>Aqui va la lista de paginas</p>
    <hr>
    <a href="../new.html">Nueva Pagina</a><br>
    <a href="../index.html">Volver al Inicio</a>
</body>
</html>
HTML
