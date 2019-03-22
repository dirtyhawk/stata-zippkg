cd "~/Dokumente/stata-zippkg/"
clear all
run zippkg.ado
cls

// simple notation
zippkg fre tr , replace notrackfile verbose flat

// ()-binding notation , no global options , no pkgspec options
zippkg (fre tr) (findname catplot) (elabel)

// ||-separator notation , no global options , no pkgspec options
zippkg fre tr || findname catplot || elabel

// ()-binding notation , with global options , no pkgspec options
zippkg (fre tr) (findname catplot) (elabel) , replace notrackfile verbose flat

// ||-separator notation , with global options , no pkgspec options
zippkg fre tr || findname catplot || elabel || , replace notrackfile verbose flat

// ()-binding notation , no global options , with pkgspec options
zippkg (fre tr) (findname catplot , saving(njc.zip)) (sjlatex , from("https://www.stata-journal.com/production"))

// ||-separator notation , no global options , with pkgspec options
zippkg fre tr || findname catplot , saving(njc.zip) || sjlatex , from("https://www.stata-journal.com/production")

// ()-binding notation , with global options , with pkgspec options
zippkg (fre tr) (findname catplot , saving(njc.zip)) (sjlatex , from("https://www.stata-journal.com/production")) , replace notrackfile verbose flat

// ||-separator notation , with global options , with pkgspec options
zippkg fre tr || findname catplot , saving(njc.zip) || sjlatex , from("https://www.stata-journal.com/production") || , replace notrackfile verbose flat

