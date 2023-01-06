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
     $final .= "<h6>$1</h6><br>";
}
elsif($text =~ /##([a-zA-Z\t\h]+)/) {
     $final .= "<h2>$1</h2><br>";
}
elsif($text =~ /#([a-zA-Z\t\h]+)/) {
     $final .= "<h1>$1</h1><br>";
}
if($text =~ /\*\*\*([a-zA-Z\t\h]+)\*\*\*/) {
     $final .= "<p><strong><em>$1</em></strong></p><br>";     
}
elsif($text =~ /\*\*([a-zA-Z\t\h]+)\*\*/) {
     $final .= "<p><strong>$1</strong></p><br>";     
}
elsif($text =~ /\*([a-zA-Z\t\h]+)\*/) {
     $final .= "<p><em>$1</em></p><br>";     
}

if($text =~ /~~([a-zA-Z\t\h]+)~~/) {
     $final .= "<p><del>$1</del></p><br>";     
}
if($text =~ /\*\*([a-zA-Z\t\h]+)_([a-zA-Z\t\h]+)_([a-zA-Z\t\h]+)\*\*/) {
     $final .= "<p><strong>$1<em>$2</em>$3</strong></p><br>";     
}
if($text =~ /``` ([a-zA-Z\t\h]+)```/) {
     $final .= "<p><code>$1</code></p><br>";     
}
if($text =~ /\[([a-zA-Z\t\h]+)\]\(([a-zA-Z\t\h\:\.\/]+)\)/) {
     $final .= "<p><a href='$2'>$1</a></p><br>";     
}

print $q->header('text/html');
print<<HTML;
<!DOCTYPE html>
<html>
<head>
     <link rel="stylesheet" href="../styles/general.css">
     <link rel="stylesheet" href="../styles/grabada.css">
     <title>Wikipedia 0.1</title>
</head>
<body>
     <div class="wrap">
          <div class="TextoContent">
                $final
          </div>

          <a href="./list.pl">Retroceder</a><br>
     </div>
    
</body>
</html>
HTML

