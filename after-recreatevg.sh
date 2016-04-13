#!/bin/ksh

# Take the /fs out of the mount point and the lv name that gets added by recreatevg
# This script expects two parameters, the first is the old SID and the second is the new
# SID.  The script can't run without those inputs.

# Determine the old SID.  Do this by looking at the sapdata1 volume
oldSID=$(lsvg -l oradatavg | grep sapdata1 | awk '{print $7}' | sed 's:/oracle/::' | sed 's:/sapdata1::' | sed 's:/fs::')
echo "oldSID=$oldSID"

# Called to set the SID varaible
. /admin/.env
echo "SID=$SID"

volumeGroup=$1
for volumeGroup in oraredovg oradatavg; do
   echo "Starting on $volumeGroup"

   lsvg -l ${volumeGroup} > /tmp/vg.out

   while read line; do
      logicalVolume=$(echo ${line} | awk '{print $1}')
      mountPoint=$(echo ${line} | awk '{print $7}')
      if [ "${logicalVolume}" = "${volumeGroup}:" -o "${mountPoint}" = "LV" ]; then
         :
#        skip this line because it is just header information
      else
         if [ "$(echo ${mountPoint})" = "N/A" ]; then
            logFile=$(echo ${logicalVolume} | sed 's/fs//')
            echo "  logfile=$logFile"
         else
            echo "  upgading volume ${mountPoint}"
            chfs -a mount=true  ${mountPoint}
            echo "    mountpoint"
            chfs -a log=/dev/${logFile} ${mountPoint}
            echo "    logfile"
#           For the sapdata mount points, set them to cio
            if echo ${mountPoint} | grep -q "sapdata" ; then
               chfs -a options=cio ${mountPoint}
               echo "    cio option"
            fi
         fi
         if [ $(echo ${logicalVolume} | cut -c1,2) = "fs" ]; then
            newVolumeName=$(echo ${logicalVolume} | sed 's/fs//')
            chlv -n ${newVolumeName} ${logicalVolume}
            echo "    volume name"
         fi
         if [ $(echo ${mountPoint} | cut -c1-3) = "/fs" ]; then
            newMountPoint=$(echo ${mountPoint} | sed "s:${oldSID}:${SID}:" | se
            chfs -m ${newMountPoint} ${mountPoint}
            echo "    mountpoint"
         fi
      fi
   done < /tmp/vg.out
done
rm /tmp/vg.out
