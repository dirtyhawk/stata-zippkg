{smcl}
{* *! version 0.1 21 March 2019}{...}
{vieweralsosee "[R] net" "help net"}{...}
{vieweralsosee "[R] ssc" "help ssc"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] net" "mansection R net"}{...}
{vieweralsosee "[R] ssc" "mansection R ssc"}{...}
{viewerjumpto "Syntax" "zippkg##syntax"}{...}
{viewerjumpto "Description" "zippkg##description"}{...}
{viewerjumpto "Options" "zippkg##options"}{...}
{viewerjumpto "Remarks" "zippkg##remarks"}{...}
{viewerjumpto "Examples" "zippkg##examples"}{...}
{viewerjumpto "Author" "zippkg##author"}{...}
{viewerjumpto "Also see" "zippkg##alsosee"}{...}
help for {cmd:zippkg}{right:version 0.1 (21 March 2019)}
{hline}


{title:Title}

{phang}
{bf:zippkg} {hline 2} A Stata module to create ZIP file(s) of
 community-contributed content for offline distribution{p_end}


{title:Table of contents}

        {help zippkg##syntax:Syntax}
        {help zippkg##description:Description}
        {help zippkg##options:Options}
        {help zippkg##remarks:Remarks}
        {help zippkg##examples:Examples}
        {help zippkg##author:Author}
        {help zippkg##alsosee:Also see}


{marker syntax}
{title:Syntax}

{p 8 16 2}
{cmd:zippkg}
{it:pgkspec}
[{cmd:,}
{opt fl:at}
{opt s:ingle}
{opt sav:ing}{bf:(}{it:{help filename}}{bf:)}
{opt replace}
{opt v:erbose}]

{phang}where the syntax of {it:pkgspec} is

{pin}
[{cmd:(}]
{it:pkglist} {cmd:,}
{opt f:rom(directory_or_url)}
{opt all}
[{cmd:)}] [{cmd:||}]

{phang}and {it:pkglist} is a list of packages names

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:overall options}
{synopt:{opt fl:at}}requests that the archive file(s) created should not
contain a directory structure{p_end}
{synopt:{opt s:ingle}}instead of creating a joint archive file for all packages
requested, create a single archive file for each package{p_end}
{synopt:{opt sav:ing}{bf:(}{it:{help filename}}{bf:)}}save output archive as
{it:{help filename}}; if {it:filename} is specified without a file extension,
{input:.zip} is assumed{p_end}
{synopt:{opt replace}}replace the output archive file(s), if already
present{p_end}
{synopt:{opt v:erbose}}give verbose output{p_end}

{syntab:{it:pgkspec} options}{...}
{synopt:{opt f:rom(directory_or_url)}} requests to use {it:directory_or_url} as
installation source; the special keyword {input:"SSC"} is allowed (and used as
default if the option is omitted), any other content will be passed through to
{help net##options_net_install:net install}{p_end}
{synopt:{opt all}}also download ancillary files; will be passed through to
{help net##options_net_install:net install} or
{help ssc##options_ssc_install:ssc}, respectively{p_end}
{synoptline}
{p2colreset}{...}


{marker description}
{title:Description}

{pstd}
{cmd:zippkg} is a tool to download community-contributed content from the
internet, and create a ZIP archive from it. Its purpose is to ease the
distribution of such content to machines not connected to the internet, be it
in data centers, secure enclaves, or any other scenario.{break}Also, it may help
in equipping new Stata installations with a set of preinstalled packages.
{p_end}

{pstd}
Downloading several packages from different sources is supported via a syntax
mechanism similar to the one of {help graph twoway##remarks2:graph twoway}; both
variants ({input:||}-separator notation and {input:()}-binding notation) are
supported.
{p_end}


{marker options}{...}
{title:Options}

{dlgtab:overall}

{pstd} Overall options for {cmd:zippkg}:{p_end}

{phang}{opt flat} requests that the archive file(s) created should not contain a
directory structure. By default, the archive file(s) will contain the typical
directory structure Stata uses in the PLUS directory (see {help sysdir}). When
the option {opt flat} is specified, all files will be saved in the top-level
directory of the archive(s).{p_end}

{phang}{opt single} requests that single archive files will be created for each
package downloaded, instead of a joint archive file for all packages. Each of
the single archive files will be named {input:{it:packagename}.zip}, and saved
to Stata's current working directory.{break}
Options {opt single} and {opt saving(filename)} are mutually exclusive, with
{opt single} taking precedence if both are specified.{p_end}

{phang}{opt saving(filename)} requests the archive file created to be named
{filename}. If {it:filename} is specified without a file extension, {input:.zip}
is assumed. If the option is omitted (and option {opt single} is not specified),
{input:"./packages.zip"} will be used as the default. This will create a file
named {bf:packages.zip} in the current working directory of Stata.{break}
Options {opt single} and {opt saving(filename)} are mutually exclusive, with
{opt single} taking precedence if both are specified.{p_end}

{phang}{opt replace} requests that {cmd:zippkg} will overwrite existing archive
files without an error.{p_end}

{phang}{opt verbose} gives verbose output during the process. Possibly needed
for debugging download problems.{p_end}

{dlgtab:pkgspec}

{pstd} Options for each individual package specification:{p_end}

{phang}
{opt f:rom(directory_or_url)} requests to use {it:directory_or_url} as
installation source for the packages in {it:pkglist}. It will be passed through
to {help net##options_net_install:net install}, unless the special keyword
{input:"SSC"} is specified.{break}The special keyword {input:"SSC"}, which is
the default if the option is omitted, makes {cmd:zippkg} use the command
{help ssc:ssc install} for package installation instead of
{help net:net install} in order to use the {browse "https://ideas.repec.org/s/boc/bocode.html":Statistical Software Components} (SSC)
 archive as installation source.{p_end}

{phang}
{opt all} requests to also download ancillary files (and include in the
resulting archive file). It will be passed through to
{help net##options_net_install:net install} or
{help ssc##options_ssc_install:ssc} (if SSC is the installation source).


{marker remarks}
{title:Remarks}

{pstd}
The source code of the program is licensed under the
GNU General Public License version 3 or later.
The corresponding license text can be found on the internet at
{browse "http://www.gnu.org/licenses/"} or in {help gnugpl}.
{p_end}


{marker examples}
{title:Examples}

{phang}Download packages {it:fre} and {it:njc_stuff} from SSC:{p_end}
{phang}{input:. zippkg fre njc_stuff}{p_end}

{phang}Download packages {it:fre} and {it:njc_stuff} from SSC , and {it:sjlatex}
from {browse "https://www.stata-journal.com/production"}:{p_end}
{phang}{input}. zippkg (fre njc_stuff) (sjlatex ,
from("https://www.stata-journal.com")){reset}{p_end}

{phang}Do the same, but using the {input:||}-separator notation rather than
the {input:()}-binding notation:{p_end}
{phang}{input}. zippkg fre njc_stuff || sjlatex ,
from("https://www.stata-journal.com"){reset}{p_end}

{phang}Download the very same packages, but place each in its single archive
file:{p_end}
{phang}{input}. zippkg (fre njc_stuff) (sjlatex ,
from("https://www.stata-journal.com")) , single{reset}{p_end}

{phang}Do the same, but using the {input:||}-separator notation rather than
the {input:()}-binding notation:{p_end}
{phang}{input}. zippkg fre njc_stuff || sjlatex ,
from("https://www.stata-journal.com") || , single{reset}{p_end}

{marker author}
{title:Author}

{pstd}
Daniel Bela ({browse "mailto:daniel.bela@lifbi.de":daniel.bela@lifbi.de}),
Leibniz Institute for Educational Trajectories (LIfBi), Germany.
{p_end}


{marker alsosee}
{title:Also see}

{psee}
{help net}, {help ssc}
{p_end}
