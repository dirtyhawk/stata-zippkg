cd "~/Dokumente/stata-zippkg/"
clear all
run zippkg.ado
cls

// simple notation
zippkg fre tr , replace notrackfile verbose flat

// ||-separator notation
zippkg fre tr || findname catplot || , replace notrackfile verbose flat

// ()-binding notation
zippkg (fre tr) (findname catplot) , replace notrackfile verbose flat
