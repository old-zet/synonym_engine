#!/usr/bin/perl;

use strict;
use warnings;
use utf8;

binmode(STDIN,':utf8');
binmode(STDOUT,':utf8');

open(IN,'DEM-1_0.xml') or die "Can't open > DEM-1_0.xml: $!";
binmode(IN,':utf8');

open(OUT,'+>vos_synonymes.html') or die "Can't open > vos_synonymes.html: $!";
binmode(OUT,':utf8');

my $entree;
my $tous_mots;
my $tous_cont;
my $tous_op;
my $tous_domaine;
my $cont_actuel = '';
my $op_actuel = '';
my $domaine_actuel = '';
my %selection_synonymes = ();
my %selection_synonymes_moyenne = ();
my %selection_synonymes_stricte = ();
my %dico = ();

print "Précisez le mot dont les synonymes vous intéressent : ";
$entree = <STDIN>;
chomp $entree;

while (my $lemme = <IN>) {

    chop $lemme;

    if ($lemme =~ /M mot="([^"]*)"/) {
        $tous_mots = $1;
		$dico{$1} = 1;
    } elsif ($lemme =~ /<CONT>(.*)<\/CONT>/) {
        $tous_cont = $1;
	} elsif ($lemme =~ /<DOM nom="([^"]*)"/) {
		$tous_domaine = $1;
	} elsif ($lemme =~ /<OP>(.*)<\/OP>/) {
		$tous_op = $1;
        if ($entree eq $tous_mots) {
            $cont_actuel = $tous_cont;
			$domaine_actuel = $tous_domaine;
			$op_actuel = $tous_op;
        } elsif ($domaine_actuel eq $tous_domaine && $op_actuel eq $tous_op && $cont_actuel eq $tous_cont) {
			$selection_synonymes_stricte{$tous_mots} = 1;
		} elsif ($cont_actuel eq $tous_cont && $domaine_actuel eq $tous_domaine) {
			$selection_synonymes_moyenne{$tous_mots} = 1;
		} elsif ($domaine_actuel eq $tous_domaine) {
			$selection_synonymes{$tous_mots} = 1;
		}
	}
}

close(IN);

use locale;

if (exists($dico{$entree})) {

	print OUT "<br><ol style=\"width:30%; float:left;\"><font size=\"5\">Les synonymes proches de « <strong>$entree</strong> » :</font>";

	foreach my $synonymes (sort(keys %selection_synonymes_stricte)) {
		print OUT "<li>\n$synonymes\n</li>\n";
	}
	
	print OUT "</ol>";
	
	print OUT "<ol style=\"width:30%; float:left;\"><font size=\"5\">Les synonymes à mi-chemin de « <strong>$entree</strong> » :</font>";

	foreach my $synonymes (sort(keys %selection_synonymes_moyenne)) {
		print OUT "<li>\n$synonymes\n</li>\n";
	}
	
	print OUT "</ol>";
	
	print OUT "<ol style=\"width:30%; float:left;\"><font size=\"5\">Les synonymes lointains de « <strong>$entree</strong> » :</font>";

	foreach my $synonymes (sort(keys %selection_synonymes)) {
		print OUT "<li>\n$synonymes\n</li>\n";
	}
	
	print OUT "</ol>\n";

} else {
	print "\nLe mot « $entree » est absent dans notre dictionnaire, essayez un autre.";
	print OUT "<font size=\"5\">Le mot « $entree » est absent dans notre dictionnaire, essayez un autre.</font>\n";
}

close(OUT);

print "\nLe fichier HTML comportant les synonymes qui vous intéressent a été créé.\n";
