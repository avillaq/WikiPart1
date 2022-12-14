#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q = CGI->new;
my $titulo = $q->param('titulo');
my $texto = $q->param('texto');

print $q->header('text/html');
print<<HTML;
<!DOCTYPE html>
<html>
<head>
    <title>Wikipedia 0.1</title>
</head>
<body>
    <h1>$titulo</h1>
    <p>$texto</p>
    <hr>

    <h2>Pagina grabada <a href="./list.pl">Listado de Paginas</a></h2>

</body>
</html>

HTML
