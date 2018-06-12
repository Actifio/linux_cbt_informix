Introduction
============

These scripts will help you protect IBM Informix databases running on Linux using Actifio Linux CBT. This script was written to support with any shell (tested on SLES 12), and should work with any RedHat or SuSe variant.

Install
=======

Manual Method
-------------

1. Copy contents of this repository to ```/act/scripts```.
2. Rename a copy of freeze.xxx and thaw.xxx files replacing xxx with protected appliaction ID.
```
cd /act/scripts
cp freeze.xxx freeze.00001
cp thaw.xxx thaw.00001
```

NOTE: you can find the application ID using ```udsinfo lsapplication -filtervalue apptype="LVM Volume"``` command or by hovering the mouse pointer over the application need to be protected on Actifio Desktop. 
3. Set the informix.conf parameters to match your environment.

 - **INFORMIXDIR**: Informix install directory, as per $IFORMIXDIR environment variable.
 - **INFORMIXSERVER**: Informix server name. Same as $INFORMIXSERVER environment variable.
 - **B_TIMEOUT**: Timeout for the block operation. Default is set to 15 seconds, however this can be tunes should there be a need.
 - **DB_MOUNT**: Mount point to mount the datafiles to. NOTE: this is not required for the protections, however, will be required to mount back the database.


Automated Method
----------------

