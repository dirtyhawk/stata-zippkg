/*-------------------------------------------------------------------------------
  zippkg.ado: Stata module to create ZIP file(s) of community-contributed content for offline distribution

    Copyright (C) 2019  Daniel Bela (daniel.bela@lifbi.de)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

-------------------------------------------------------------------------------*/
*! zippkg.ado: Stata module to create ZIP file(s) of community-contributed content for offline distribution
*! Daniel Bela (daniel.bela@lifbi.de), Leibniz Institute for Educational Trajectories (LIfBi), Germany
*! version 0.1 21 Mary 2019 - initialized development version release
program define zippkg , nclass
	version 12
	// convert input syntax from ||-separator notation to ()-binding notation
	while (regexm(`"`0'"',"\|\|")) {
		/*
		if (_caller()>=14) {
		
		}
		else {
		*/
			local 0="("+regexr(`"`0'"',`"\|\|"',`")("')+")"
		* }
	}
	// parse syntax
	syntax anything(everything equalok id="package specification" name=pkgspecs) ///
		[ , FLat single SAVing(string) replace Verbose noTRACKfile ]
	// parse global options, set defaults
	foreach global_opt in flat saving replace trackfile {
		if (!missing(`"``global_opt''"')) local glob_`global_opt' ``global_opt''
	}
	if (missing(`"`glob_saving'"')) local glob_saving `"./packages.zip"'
	if (!missing(`"`single'"')) local glob_saving ./\`pkgname'.zip
	// create temporary directory
	_create_tempsubdir `"`c(tmpdir)'"'
	local tmppath `r(tempdirfullpath)'
	
	local speccounter 0
	while (!missing(`"`pkgspecs'"')) {
		gettoken pkgspec`++speccounter' pkgspecs : pkgspecs , match(parens) bind quotes
		if (`"`pkgspec`speccounter''"'=="||") {
			local -- speccounter
			continue
		}
		di `"`speccounter': `pkgspec`speccounter''"'
	}
	/*
	// create archive
	_zipdir `"`tmppath'"' , `flat' `replace' `trackfile' `verbose' saving(`"`savename'"')
	// clean up
	_rm_dircontents `"`tmppath'"'
	 rmdir `"`tmppath'"'
	// exit
	*/
	exit 0
end
/* subroutine: create ZIP archive from a complete directory, descending by one level */
program define _zipdir , nclass
	syntax anything(everything name=parentdir id="directory name") ,  ///
		saving(string) [ flat replace noTRACKFILE verbose ]
	local parentdir `parentdir'
	if (`"`flat'"'==`"flat"') local archivetargets flattargets
	else {
		local archivebase `"`parentdir'"'
		local archivetargets allfiles
	}
	local allfiles : dir "`parentdir'" files "*" , respectcase
	if (`"`trackfile'"'==`"notrackfile"') {
		local allfiles : subinstr local allfiles `""stata.trk""' "" , all word
	}
	local subdirs : dir "`parentdir'" dirs "*" , respectcase
	foreach subdir of local subdirs {
		local subdirfiles : dir "`parentdir'/`subdir'" files "*" , respectcase
		foreach file of local subdirfiles {
			local newfile `""`subdir'/`file'""'
			local allfiles : list allfiles | newfile
		}
	}
	if (`"`flat'"'==`"flat"') {
		_create_tempsubdir `"`c(tmpdir)'"'
		local archivebase `r(tempdirfullpath)'
		foreach file of local allfiles {
			mata : st_local("filename",pathbasename(`"`file'"'))
			quietly : copy `"`parentdir'/`file'"' `"`archivebase'/`filename'"'
			local flattargets `"`flattargets' `"`filename'"'"'
		}
	}
	local oldpwd `"`c(pwd)'"'
	quietly : cd `"`archivebase'"'
	if (`"`verbose'"'==`"verbose"') {
		display as result in smcl `"{text}creating archive {result}`saving'{text}"'
		local q noisily
	}
	else local q quietly
	local mode create
	if (!missing(`"`replace'"')) {
		capture : confirm file `"`saving'"'
		if (_rc==0) {
			quietly : rm `"`saving'"'
			local mode replace
		}
	}
	`q' zipfile ``archivetargets'' , saving(`"`saving'"')
	quietly : cd `"`oldpwd'"'
	display as result in smcl `"{text}archive {result}`saving'{text} `mode'd"'
	if (`"`flat'"'==`"flat"') {
		_rm_dircontents `"`archivebase'"'
		 rmdir `"`archivebase'"'
	}
	exit 0
end
/* subroutine: remove all files from a directory, descending by one level */
program define _rm_dircontents , rclass
	syntax anything(everything name=dirname id="directory name")
	local dirname `dirname'
	local subdirs : dir "`dirname'" dirs "*" , respectcase
	foreach subdir of local subdirs {
		local subdirfiles : dir "`dirname'/`subdir'" files "*" , respectcase
		foreach file of local subdirfiles {
			rm `"`dirname'/`subdir'/`file'"'
		}
	}
	local dirfiles : dir "`dirname'" files "*" , respectcase
	foreach file of local dirfiles {
		rm `"`dirname'/`file'"'
	}
	exit 0
end
/* subroutine: create a temporary subdirectory not yet existent */
program define _create_tempsubdir , rclass
	syntax anything(everything name=parent id="parent directory")
	local parent `parent'
	local counter 0
	tempname subdirname
	capture : mkdir `"`parent'/`subdirname'"'
	while (_rc!=0) {
		if (`++counter'>1000) {
			display as error in smcl `"Error: could not create random subdirectory inside of {it:`parent'} in 1000 tries. Is the parent directory corretly specified?"'
			exit 693
		}
		tempname subdirname
		capture : mkdir `"`parent'/`subdirname'"'
	}
	return local tempdirname `"`subdirname'"'
	return local tempdirfullpath `"`parent'/`subdirname'"'
	exit 0
end
// EOF
