#!/bin/ksh

echo "Creating Volume Groups..."
mkvg -y oramiscvg hdisk1
mkvg -y oraredovg hdisk2
mkvg -y oradatavg hdisk3
mkvg -y sapvg hdisk4

echo "Creating JFS2 Logs..."
mklv -t jfs2log -y saplog sapvg 7
mklv -t jfs2log -y redolog oraredovg 3
mklv -t jfs2log -y datalog oradatavg 3
mklv -t jfs2log -y misclog oramiscvg 6

export sid=$(hostname | cut -c 6-8)
export SID=$(echo ${sid} | tr 'a-z' 'A-Z')

echo "Creating /oracle"
mkdir /oracle
crfs -v jfs2 -g oramiscvg -a logname=misclog -a size=2G -A yes -m /oracle
chlv -n lvoracle fslv00
sleep 2
mount /oracle

echo "Creating /oracle/client"
mkdir /oracle/client
crfs -v jfs2 -g oramiscvg -a logname=misclog -a size=1G -A yes -m /oracle/client
chlv -n lvoraclt fslv00
sleep 2
mount /oracle/client

echo "Creating /oracle/stage/102_64"
mkdir /oracle/stage/
mkdir /oracle/stage/102_64
crfs -v jfs2 -g oramiscvg -a logname=misclog -a size=10G -A yes -m /oracle/stage/102_64
chlv -n lvorast1 fslv00
sleep 2
mount /oracle/stage/102_64

echo "Creating /oracle/${SID}"
mkdir /oracle/${SID}
crfs -v jfs2 -g oramiscvg -a logname=misclog -a size=6G -A yes -m /oracle/${SID}
chlv -n lvora${sid}1 fslv00
sleep 2
mount /oracle/${SID}

echo "Creating /oracle/${SID}/102_64"
mkdir /oracle/${SID}/102_64
crfs -v jfs2 -g oramiscvg -a logname=misclog -a size=10G -A yes -m /oracle/${SID}/102_64
chlv -n lvora${sid}2 fslv00
sleep 2
mount /oracle/${SID}/102_64

echo "Creating /oracle/${SID}/orarch"
crfs -v jfs2 -g oramiscvg -a logname=misclog -a size=10G -A yes -m /oracle/${SID}/orarch
chlv -n lvoraarch fslv00
sleep 2
mount /oracle/${SID}/orarch

echo "Creating /oracle/${SID}/sapreorg"
mkdir /oracle/${SID}/sapreorg
crfs -v jfs2 -g oramiscvg -a logname=misclog -a size=20G -A yes -m /oracle/${SID}/sapreorg
chlv -n lvorreorg fslv00
sleep 2
mount /oracle/${SID}/sapreorg

echo "Creating /oracle/${SID}/sapdata1" 
mkdir /oracle/${SID}/sapdata1
crfs -v jfs2 -g oradatavg -a logname=datalog -a size=69G -A yes -m /oracle/${SID}/sapdata1
chlv -n lvoradat1 fslv00
sleep 2
mount /oracle/${SID}/sapdata1

echo "Creating /oracle/${SID}/sapdata2"
mkdir /oracle/${SID}/sapdata2
crfs -v jfs2 -g oradatavg -a logname=datalog -a size=69G -A yes -m /oracle/${SID}/sapdata2
chlv -n lvoradat2 fslv00
sleep 2
mount /oracle/${SID}/sapdata2

echo "Creating /oracle/${SID}/sapdata3"
mkdir /oracle/${SID}/sapdata3
crfs -v jfs2 -g oradatavg -a logname=datalog -a size=69G -A yes -m /oracle/${SID}/sapdata3
chlv -n lvoradat3 fslv00
sleep 2
mount /oracle/${SID}/sapdata3

echo "Creating /oracle/${SID}/sapdata4"
mkdir /oracle/${SID}/sapdata4
crfs -v jfs2 -g oradatavg -a logname=datalog -a size=69G -A yes -m /oracle/${SID}/sapdata4
chlv -n lvoradat4 fslv00
sleep 2
mount /oracle/${SID}/sapdata4

echo "Creating /oracle/${SID}/origlogA"
mkdir /oracle/${SID}/origlogA
crfs -v jfs2 -g oraredovg -a logname=redolog -a size=1G -A yes -m /oracle/${SID}/origlogA
chlv -n lvoraloga fslv00
sleep 2
mount /oracle/${SID}/origlogA

echo "Creating /oracle/${SID}/origlogB"
mkdir /oracle/${SID}/origlogB
crfs -v jfs2 -g oraredovg -a logname=redolog -a size=1G -A yes -m /oracle/${SID}/origlogB
chlv -n lvoralogb fslv00
sleep 2
mount /oracle/${SID}/origlogB

echo "Creating /oracle/${SID}/mirrlogA"
mkdir /oracle/${SID}/mirrlogA
crfs -v jfs2 -g oraredovg -a logname=redolog -a size=1G -A yes -m /oracle/${SID}/mirrlogA
chlv -n lvoramira fslv00
sleep 2
mount /oracle/${SID}/mirrlogA

echo "Creating /oracle/${SID}/mirrlogB"
mkdir /oracle/${SID}/mirrlogB
crfs -v jfs2 -g oraredovg -a logname=redolog -a size=1G -A yes -m /oracle/${SID}/mirrlogB
chlv -n lvoramirb fslv00
sleep 2
mount /oracle/${SID}/mirrlogB

echo "Creating /home/${sid}adm"
mkdir /home/${sid}adm
crfs -v jfs2 -g sapvg -a logname=saplog -a size=1G -A yes -m /home/${sid}adm
chlv -n lvhomeadm fslv00
sleep 2
mount /home/${sid}adm

echo "Creating /sapmnt/${SID}"
mkdir /sapmnt
mkdir /sapmnt/${SID}
crfs -v jfs2 -g sapvg -a logname=saplog -a size=8G -A yes -m /sapmnt/${SID}
chlv -n lvsapmnt fslv00
sleep 2
mount /sapmnt/${SID}

echo "Creating /usr/sap/${SID}"
mkdir /usr/sap
mkdir /usr/sap/${SID}
crfs -v jfs2 -g sapvg -a logname=saplog -a size=16G -A yes -m /usr/sap/${SID} 
chlv -n lvusrsap fslv00
sleep 2
mount /usr/sap/${SID}

echo "Creating /usr/sap/trans"
mkdir /usr/sap/trans
crfs -v jfs2 -g sapvg -a logname=saplog -a size=12G -A yes -m /usr/sap/trans
chlv -n lvstrans fslv00
sleep 2
mount /usr/sap/trans

echo "Creating /sap/stage${SID}"
mkdir /sap
mkdir /sap/stage${SID}
crfs -v jfs2 -g sapvg -a logname=saplog -a size=60G -A yes -m /sap/stage${SID}
chlv -n lvsapstg fslv00
sleep 2
mount /sap/stage${SID}

echo "All filesystems created!"
