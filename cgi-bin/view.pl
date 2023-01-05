#!C:/xampp/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use DBI;
my $q = CGI->new;

my $dsn = "DBI:mysql:database=datospagina;host=127.0.0.1";
my $dbh = DBI->connect($dsn, "Alex", "") or die "No se pudo conectar";

my $titulo = $q->param('title');
my $texto;
my $sth = $dbh->prepare("select text from paginas where title=?");
$sth->execute($titulo);

while(my @row = $sth->fetchrow_array){
	$texto = $row[0];
}
$sth->finish;
$dbh->disconnect;
my $final = "";

my $text = $texto;
$text =~ s/\n/ /g;
if($text =~ /######([a-zA-Z\t\h]+)/) {
     $final .= "<h6>$1</h6>";
}
elsif($text =~ /##([a-zA-Z\t\h]+)/) {
     $final .= "<h2>$1</h2>";
}
elsif($text =~ /#([a-zA-Z\t\h]+)/) {
     $final .= "<h1>$1</h1>";
}

if($text =~ /\*\*\*([a-zA-Z\t\h]+)\*\*\*/) {
     print $1."\n";
}
elsif($text =~ /\*\*([a-zA-Z\t\h]+)\*\*/) {
     print $1."\n";
}
elsif($text =~ /\*([a-zA-Z\t\h]+)\*/) {
     print $1."\n";
}

if($text =~ /~~([a-zA-Z\t\h]+)~~/) {
     print $1."\n";
}
if($text =~ /\*\*([a-zA-Z\t\h]+)_([a-zA-Z\t\h]+)_([a-zA-Z\t\h]+)\*\*/) {
     print $1.$2.$3."\n";
}
if($text =~ /``` ([a-zA-Z\t\h]+)```/) {
     print $1."\n";
}
if($text =~ /\[([a-zA-Z\t\h]+)\]\(([a-zA-Z\t\h\:\.\/]+)\)/) {
     print $1.$2."\n";
}

print $q->header('text/html');
print<<HTML;
<!DOCTYPE html>
<html>
<head>
     <title>Wikipedia 0.1</title>
</head>
<body>
    <a href="./list.pl">Retroceder</a><br>
    $final
</body>
</html>
HTML

