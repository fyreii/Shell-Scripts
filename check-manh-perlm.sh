#!/usr/bin/ksh
#
#    Test for presence of required Perl modules used for
#    Manhattan installs
#
echo
echo    "use DBI"
echo
perl -e 'use DBI; print "$DBI::VERSION\n"'

echo
echo
echo    "use DBD"
echo
perl -e 'use DBD::Oracle; print "$DBD::Oracle::VERSION\n"'

echo
echo
echo    "use XML Parser"
echo  
perl -e 'use XML::Parser; print "$XML::Parser::VERSION\n"'

echo
echo
echo    "use XML Writer"
echo  
perl -e 'use XML::Writer; print "$XML::Writer::VERSION\n"'

echo
echo
echo    "use utf8"
echo  
perl -e 'use utf8; print "$utf8::VERSION\n"'

echo
echo
echo    "use Convert IBM390"
echo
perl -e 'use Convert::IBM390; print "$Convert::IBM390::VERSION\n"'
