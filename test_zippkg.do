cd "~/Dokumente/stata-zippkg/"
clear all
run zippkg.ado
local pwd `"`c(pwd)'"'
cls


// simple notation
zippkg fre tr , replace notrackfile verbose flat checksums saving(mypkgs.zip)
confirm file `"`pwd'/mypkgs.zip"'
rm `"`pwd'/mypkgs.zip"'

// ()-binding notation , no global options , no pkgspec options
zippkg (fre tr) (findname catplot) (elabel)
confirm file `"`pwd'/zippkg.zip"'
rm `"`pwd'/zippkg.zip"'

// ||-separator notation , no global options , no pkgspec options
zippkg fre tr || findname catplot || elabel
confirm file `"`pwd'/zippkg.zip"'
rm `"`pwd'/zippkg.zip"'

// ()-binding notation , with global options , no pkgspec options
zippkg (fre tr) (findname catplot) (elabel) , replace notrackfile verbose flat
confirm file `"`pwd'/zippkg.zip"'
rm `"`pwd'/zippkg.zip"'

// ||-separator notation , with global options , no pkgspec options
zippkg fre tr || findname catplot || elabel || , replace notrackfile verbose flat
confirm file `"`pwd'/zippkg.zip"'
rm `"`pwd'/zippkg.zip"'

// ()-binding notation , no global options , with pkgspec options
zippkg (fre tr) (findname catplot , saving(njc.zip)) (sjlatex , from("https://www.stata-journal.com/production"))
confirm file `"`pwd'/zippkg.zip"'
rm `"`pwd'/zippkg.zip"'
confirm file `"`pwd'/njc.zip"'
rm `"`pwd'/njc.zip"'

// ||-separator notation , no global options , with pkgspec options
zippkg fre tr || findname catplot , saving(njc.zip) || sjlatex , from("https://www.stata-journal.com/production")
confirm file `"`pwd'/zippkg.zip"'
rm `"`pwd'/zippkg.zip"'
confirm file `"`pwd'/njc.zip"'
rm `"`pwd'/njc.zip"'

// ()-binding notation , with global options , with pkgspec options
zippkg (fre tr) (findname catplot , saving(njc.zip)) (sjlatex , from("https://www.stata-journal.com/production")) , replace notrackfile verbose flat
confirm file `"`pwd'/zippkg.zip"'
rm `"`pwd'/zippkg.zip"'
confirm file `"`pwd'/njc.zip"'
rm `"`pwd'/njc.zip"'

// ||-separator notation , with global options , with pkgspec options
zippkg fre tr || findname catplot , saving(njc.zip) all || sjlatex , from("https://www.stata-journal.com/production") || , replace notrackfile verbose flat
confirm file `"`pwd'/zippkg.zip"'
rm `"`pwd'/zippkg.zip"'
confirm file `"`pwd'/njc.zip"'
rm `"`pwd'/njc.zip"'
