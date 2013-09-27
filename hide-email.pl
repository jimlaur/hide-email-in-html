#!/usr/bin/perl
#
use warnings;
use strict;
use App::Options( 
        option => {
            src_page => {
                default => "current.html",
            },
            dst_page => {
                default => "current.html",
            }
        },
    );
#
#---------------------------------------------------------------------------
#
# Define the fixed-text pieces of the javascript template.
# The changing parts of the email address are added between these parts.
my $temp1;
my $temp2;
my $temp3;
#
# First part
   $temp1 = qq~
<script language="javascript" >
<!--
var mailname = ~
;
#
# Second part
   $temp2 = qq~
var mailhost = ~
;
#
# Third part
   $temp3 = qq~
document.write("<a href=" + "mail" + "to:" + mailname + "@")
document.write(mailhost +">" + mailname + "@" + mailhost + "</a>")
//-->
</script> ~
;
#
# Get the names of the source and destination page files, can be the same.
my $source_page = $App::options{"src_page"};
my $dest_page   = $App::options{"dst_page"};
#
   print "hide email in: $source_page\n";
my $input = '';
   undef $/; # remove input record separator, slurp the whole file mode
   open(SOURCE, "<./$source_page" ) || die "input file $source_page missing";
   #  
   # get the page to modify
   $input = <SOURCE>;
   #   
   # Perform the substitution of all email addresses with javascript.
   $input =~ s{
       \b
       (
          (\w[-.\w]*)
          \@
          ([-a-z0-9]+(\.[-a-z0-9]+)*\.\w\w\w\w?)
       )
       \b
    }{$temp1\"$2\";$temp2\"$3\";$temp3}gix;
   #
   # "put the results back out
   close (SOURCE);
   open(RESULT, ">$dest_page" ) || die "can not create $dest_page";
   print RESULT $input;
   close (RESULT);
   print "wrote result to: $dest_page\n";
# done
