#!/bin/bash
URL="$1"
$SPLUNK_HOME/bin/splunk stop
mv $SPLUNK_HOME $HOME/junk.splunk
if [ -e $HOME/junk.splunk ]
then
/bin/rm -rf $HOME/junk.splunk/* &
fi
curl -s $URL -o $HOME/splunk.tgz
cd $HOME
gunzip < $HOME/splunk.tgz | tar xv -
$SPLUNK_HOME/bin/splunk start
