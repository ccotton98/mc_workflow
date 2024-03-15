grep -v '^#' < kinematics_CWC_dummy_v1_hms.txt | { while read line; do 
	stringarr=($line)
 	echo ${stringarr[0]},${stringarr[1]},${stringarr[2]},${stringarr[3]},${stringarr[4]},${stringarr[5],${stringarr[6]},${stringarr[6]}}

	if [[ "${stringarr[0]}" =~ ^shms*  ]]; then
	    spect=2
	else
	    spect=1
	fi

	FILE="./mc-single-arm/infiles/"${stringarr[0]}".inp"

	/bin/cat <<EOM >$FILE
!------------------------------------------------------------------------------
! Input file for MC_HMS_SINGLE                 March 11, 2021  
!------------------------------------------------------------------------------
     5000000    Monte-Carlo trials
     $spect          Spectrometer (1=HMS, 2=SHMS, 3=..)
     ${stringarr[2]}     Spectrometer momentum (in MeV/c)
     ${stringarr[1]}     Spectrometer angle (in degrees)
    -15.0       M.C. DP/P  down limit 
     15.0       M.C. DP/P  up   limit 
    -65.0       M.C. Theta down limit (mr)
     65.0       M.C. Theta down limit (mr)
    -110.0      M.C. Phi   down limit (mr)
     110.0      M.C. Phi   down limit (mr)
     0.06       Horiz beam spot size in cm (Full width of +/- 1 sigma)
     0.06       Vert  beam spot size in cm (Full width of +/- 1 sigma)
     ${stringarr[7]}   Thickness of target (Full width, cm)
     0.2        Raster full-width x (cm)
     0.2        Raster full-width y (cm)
     100.0      DP/P  reconstruction cut (half width in % )
     100.0      Theta reconstruction cut (half width in mr)
     100.0      Phi   reconstruction cut (half width in mr)
     100.0      ZTGT  reconstruction cut (Half width in cm)
     ${stringarr[8]}    one radiation length of target material (in cm)
     ${stringarr[3]}        Beam x offset (cm)  +x = beam left
     0.0        Beam y offset (cm)  +y = up
     ${stringarr[4]}        Target z offset (cm)+z = downstream (0.25)
     ${stringarr[6]}        Spectrometer x offset (cm) +x = down
     ${stringarr[5]}      Spectrometer y offset (cm)
     0.0        Spectrometer z offset (cm)
     0.0        Spectrometer xp offset (mr)
     0.0        Spectrometer yp offset (mr)
     0          particle identification :e=0, p=1, d=2, pi=3, ka=4
     1          flag for multiple scattering
     1          flag for wire chamber smearing
     1          flag for storing all events (including failed events with stop_id > 0)
     0          flag for beam energy, if >0 then calculate for C elastic
     0          flag to use sieve
EOM

done;}
