# stata-zippkg
Stata module to create ZIP file(s) of community-contributed content for offline distribution

## Description
`zippkg` is a Stata helper program to distribute community-contributed content into offline environments (such as data centers / secure enclaves or any other system that is not connected to the internet). It enables users to download Stata packages from the internet (via SSC or user-hosted sites) and directly create ZIP archives from it, so that these archive files can be imported via offline methods (memory sticks, shared network drives, etc) to the target system(s).

## Installation
Install the development version of the package from within Stata by running:
`. net from https://raw.githubusercontent.com/dirtyhawk/stata-zippkg/master/`

## Stable version on SSC
As soon as we reach a stable version, it will be release on SSC for public use.
