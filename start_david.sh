#!/bin/bash
# startet DavidClassic
#

if [ -x $HOME/bin/start_david.lokal ]; then
	$HOME/bin/start_david.lokal ; exit 0 
fi

DEBUG=1
unset DEBUG
test $DEBUG && echo 'Start...' > ~/x.x

# das brauchen wir _immer_
# test -z "$PROFILEREAD" -a -r /etc/profile && . /etc/profile
test -z "$DAV_HOME" && DAV_HOME=$(dirname $(dirname $0)) && export DAV_HOME
test -z "$STARTDVREAD" -a -r $DAV_HOME/.startdv && . $DAV_HOME/.startdv
test -z "$STARTVPREAD" -a -r ~/.startvp && . ~/.startvp
OUT='unbekannt'

test $DEBUG && echo $TERM,$DISPLAY,$HOST,$HOSTNAME,`tty`,$USER,$REMOTEHOST,$OUT >> ~/x.x


DAV_ID=$USER

#
# wurde uns eine gueltige DAV_ID uebergeben ?
#
while read did p11 p12 p21 p22 x1 x2 a1 a2 lid
do
	if [ -n "$did" -a "$did" = "$1" ] ; then
		DAV_ID=$1
		break
	fi
done < $DAV_HOME/david.cfg

#
# und los...
#
export DAV_ID
cd $DAV_HOME/
test $DEBUG && echo $TERM,$DISPLAY,$HOST,$HOSTNAME,`tty`,$USER,$REMOTEHOST,$OUT,$DAV_HOME >> ~/x.x
umask 0002
if [ -n "$DISPLAY" ] ; then
   xterm -geometry 80x25 -fa "DejaVu Sans Mono" -fs 18 +sb -tm "erase ^?" -bg blue3 -fg white -title "Arztprogramm D A V I D" -e /bin/bash --rcfile $DAV_HOME/menux
else
   source menux
fi

exit