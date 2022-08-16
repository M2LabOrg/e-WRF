#!/bin/bash

###Change the version here
version=v5.1.2
###########################


###########################
###No need to edit below here
echo -e "\e[4;49;34m eWRF | WRF for Educational Purposes Container\e[0m"

echo
echo -e "\e[0;49;32m-----------------------------------\e[0m"
echo -e "\e[7;49;32mRetrieving WPS geog data subset\e[0m"

#
mkdir /home/docker/WPS_GEOG
curl -SL https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_low_res_mandatory.tar.gz | tar -xzC /home/docker/wps-geog
# input FNL data for testing
(cd /home/docker/wrf-indata && curl -LJ https://github.com/M2LabOrg/e-WRF/blob/main/indata/fnl_20210414_06_00.grib2?raw=true --output fnl_20210414_06_00.grib2)
(cd /home/docker/wrf-indata && curl -LJ https://github.com/M2LabOrg/e-WRF/blob/main/indata/fnl_20210414_12_00.grib2?raw=true --output fnl_20210414_12_00.grib2) 
(cd /home/docker/wrf-indata && curl -LJ https://github.com/M2LabOrg/e-WRF/blob/main/indata/fnl_20210414_18_00.grib2?raw=true --output fnl_20210414_18_00.grib2) 
(cd /home/docker/wrf-indata && curl -LJ https://github.com/M2LabOrg/e-WRF/blob/main/indata/fnl_20210415_00_00.grib2?raw=true --output fnl_20210415_00_00.grib2)
# Script for downloading other FNL data
(cd /home/docker/wrf-indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/9fec54d2fcc2acdbd59083f20323a05ad3c0139c/indata/get_fnl_data.csh)
# Namelists for testing
(cd /home/docker/wrf-indata && curl -LJO https://raw.githubusercontent.com/M2LabOrg/e-WRF/main/indata/namelist.input.e-wrf)
(cd /home/docker/wrf-indata && curl -LJO https://raw.githubusercontent.com/M2LabOrg/e-WRF/main/indata/namelist.wps.e-wrf)


echo "Retrieved the WPS geog data subset"

echo
echo -e "\e[0;49;32m-----------------------------------\e[0m"
echo -e "\e[7;49;32mRetrieving coupled test case domain files\e[0m"



echo
echo -e "\e[0;49;32m-----------------------------------\e[0m"
echo -e "Training Jupyter notebook server running"
echo
echo "Open your browser to the following address to access notebooks"
echo -e "\033[33;5;7mhttp://localhost:8887\033[0m"
echo
echo -e "The password to login is:"
echo -e "\033[33;5;7meWRFtutorial\033[0m"
echo 
echo "Press ctrl-C then type 'y' then press return to shut down container." 
echo "NOTE ALL WORK WILL BE LOST UNLESS copied out of the container"

jupyter lab --ip 0.0.0.0 --no-browser &> /dev/null