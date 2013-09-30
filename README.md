hide-email-in-html
==================

This is a perl script, used sucessfully, to hide email addresses in static web pages from spam address harvesters.

The script automates the conversion of plain email addresses in a static web page into fragments of javascript that will create mailto links in the page when it is downloaded and rendered.

The conversion has the dual advantages that users can now click on the links to send email and that spam address harvesting will be more difficult.

The script was written under the assumption that the script and the web pages being converted are located on a Linux server.

Although this is written in perl, the concept is quite general. This script could easily be ported to any language that uses perl style regular expressions.

==How to use it==

The script is currently configured to rewrite the file named current.html in place.

The script can be executed by typing at the command line, in the web folder:

 ./hide-email.pl

The response will look like:

 hide email in: current.html
 
 wrote result to: current.html

This takes about one second for a large page.

It is safe to run this program whenever you change or add an email address and want to convert it to the script form.

===Hiding addresses in other files===

You can hide email addresses in other files using this same tool. While there are several ways to do this, the most general way is to
supply the names of the source and destination files on the command line, as in this example:

 ./hide-email.pl --dst_page=currenty.html --src_page=currentx.html

The ''--dst_page'' and ''--src_page'' values can occur in either order. As always, the source and destination file names can be the same or different.

If the actual file names contain spaces, enclose the full file name in quotes, like this:

 ./hide-email.pl --src_page="current x.html" --dst_page="current y.html" 

You should run this command from the folder where the program is installed. The names of the files to read and write can contain path information if they are not in the current folder. 

===limitations===

This script unconditionally replaces all email addresses found. The script can be confused by finding email addresses inside of existing scripts. 

==Installation==

The script is stored in the web folder, it is executable by a user with shell access.

A subfolder, ''App'', is created to hold the options Perl module, because the current folder (.) is included in the @INC Perl search path for modules. The module is ''./App/Options.pm'', which is available from the Perl CPAN library.

==description of operation==

There is an initial setup phase where the script determines the names of the file to convert and the destination file after conversion.

The script also sets up the 3 part javascript substitution template.

The script then reads the file to convert all at once.

A global search and replace statement is applied to the input file which converts all email addresses matching a given regular expression into javascript statments.

The script then writes the conveted file to the destination.

