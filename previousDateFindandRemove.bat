rem : This script was written to rename files starting with the previous day's two digit date by stripping the two digit prefix and moving them to a specified folder to be processed
rem : in this specific case the source folder contained files from multiple days
rem : i.e. today is 11/18/2020, this script will look for a set of files named 17file1.txt, 17file2.txt .. 17file5.txt and rename them to file1.txt, file2.txt .. file5.txt, but ignore the other files

@echo off 
rem : please note this file has been anonymized/privatized 

echo *** set date info for correct date adn date offset ***

set DD=%date:~7,2%
set MM=%date:~4,2%
set YY=%date:~10,2%
set currdate=%YY%-%MM%-%DD%
echo %currdate%
set offset=01 
rem : this offset determines how many days back to go
rem : the script is currently only set up for 01 or "yesterday" from current date
rem : if another date was needed, the workaround is to change "current date" rather than offset

echo *** Define log and enter notes ***
set logpath=C:\path\to\log\
set logname=filename.log
cd %logpath%
echo starting %logname% in %logpath%
echo **** %currdate% **** >> %logname%
echo moving files to Folder >> %logname%



echo *** Creating Previous Date variable ***

if NOT %DD%=="01" goto :sameMonth
if %DD%=="01" if %MM%=="01" goto :longMonth
if %DD%=="01" if %MM%=="02" goto :longMonth
if %DD%=="01" if %MM%=="03" goto :feb
if %DD%=="01" if %MM%=="04" goto :longMonth
if %DD%=="01" if %MM%=="05" goto :shortMonth
if %DD%=="01" if %MM%=="06" goto :longMonth
if %DD%=="01" if %MM%=="07" goto :shortMonth
if %DD%=="01" if %MM%=="08" goto :longMonth
if %DD%=="01" if %MM%=="09" goto :longMonth
if %DD%=="01" if %MM%=="10" goto :shortMonth
if %DD%=="01" if %MM%=="11" goto :longMonth
if %DD%=="01" if %MM%=="12" goto :shortMonth

:sameMonth
	echo Applying Same Month rules and copying files >> %logname%
	set /a VARA=%DD%-%offset%
	rem : the /a flag specifies the value is numerical
	
	if VARA lss 10 set VARA=0%VARA%
	rem : ensures DD is two digits
	
	echo Previous Date is %YY%-%MM%-%VARA% >> %logname%
	copy "C:\path\to\file\%VARA%file1.txt" "D:\new\file\location\file1.txt"
	copy "C:\path\to\file\%VARA%file2.txt" "D:\new\file\location\file2.txt"
	copy "C:\path\to\file\%VARA%file3.txt" "D:\new\file\location\file3.txt"
	copy "C:\path\to\file\%VARA%file4.txt" "D:\new\file\location\file4.txt"
	copy "C:\path\to\file\%VARA%file5.txt" "D:\new\file\location\file5.txt"
	
	goto :skip
	
:feb
	echo Applying Feb rules and copying files >> %logname%
	set /a VARB="29"
	set /a VARC="28"
	
	echo Trying Previous Date %YY%-%MM%-%VARB% >> %logname%
	copy "C:\path\to\file\%VARB%file1.txt" "D:\new\file\location\file1.txt" 
	copy "C:\path\to\file\%VARB%file2.txt" "D:\new\file\location\file2.txt"
	copy "C:\path\to\file\%VARB%file3.txt" "D:\new\file\location\file3.txt"
	copy "C:\path\to\file\%VARB%file4.txt" "D:\new\file\location\file4.txt"
	copy "C:\path\to\file\%VARB%file5.txt" "D:\new\file\location\file5.txt"
	
	echo Trying Previous Date %YY%-%MM%-%VARC% >> %logname%
	copy "C:\path\to\file\%VARC%file1.txt" "D:\new\file\location\file1.txt" 
	copy "C:\path\to\file\%VARC%file2.txt" "D:\new\file\location\file2.txt"
	copy "C:\path\to\file\%VARC%file3.txt" "D:\new\file\location\file3.txt"
	copy "C:\path\to\file\%VARC%file4.txt" "D:\new\file\location\file4.txt"
	copy "C:\path\to\file\%VARC%file5.txt" "D:\new\file\location\file5.txt"
	
	goto :skip
	
:shortMonth
	echo Applying Same Month rules and copying files >> %logname%
	set /a VARD="30"
	
	echo Previous Date is %YY%-%MM%-%VARD% >> %logname%
	copy "C:\path\to\file\%VARD%file1.txt" "D:\new\file\location\file1.txt"
	copy "C:\path\to\file\%VARD%file2.txt" "D:\new\file\location\file2.txt"
	copy "C:\path\to\file\%VARD%file3.txt" "D:\new\file\location\file3.txt"
	copy "C:\path\to\file\%VARD%file4.txt" "D:\new\file\location\file4.txt"
	copy "C:\path\to\file\%VARD%file5.txt" "D:\new\file\location\file5.txt"
	
	goto :skip
	
:longMonth
	echo Applying Same Month rules and copying files >> %logname%
	set /a VARE="31"
	
	echo Previous Date is %YY%-%MM%-%VARE% >> %logname%
	copy "C:\path\to\file\%VARE%file1.txt" "D:\new\file\location\file1.txt"
	copy "C:\path\to\file\%VARE%file2.txt" "D:\new\file\location\file2.txt"
	copy "C:\path\to\file\%VARE%file3.txt" "D:\new\file\location\file3.txt"
	copy "C:\path\to\file\%VARE%file4.txt" "D:\new\file\location\file4.txt"
	copy "C:\path\to\file\%VARE%file5.txt" "D:\new\file\location\file5.txt"
	
	goto :skip
	
:skip
	cd C:\new\file\location\ 
	echo listing files in \location\ folder >> %logname%
	
	dir /b >> %logname%
	rem : lists contents of the current directory specified in CD
	
	findstr /n "." file1 | findstr "^{string}" >> %logname%               
	rem : findstr command to output a line beginning with a specified string, of a specified file, to the log
	rem : this allows the result to be checked at a glance, without needing to open and compare the file
	
	echo process complete >> %logname%

	