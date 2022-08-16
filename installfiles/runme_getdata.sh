#!/bin/bash
echo -e "\e[4;49;34m eWRF | WRF for Educational Purposes Container\e[0m"

echo
echo -e "\e[0;49;32m-----------------------------------\e[0m"
echo -e "\e[7;49;32mRetrieving WPS geog data, FNL input and namelists\e[0m"

#
mkdir /home/docker/WPS_GEOG
curl -SL https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_low_res_mandatory.tar.gz | tar -xzC /WRF/WPS_GEOG
# input FNL data for testing
(cd /WRF/indata && curl -LJ https://github.com/M2LabOrg/e-WRF/blob/main/indata/fnl_20210414_06_00.grib2?raw=true --output fnl_20210414_06_00.grib2)
(cd /WRF/indata && curl -LJ https://github.com/M2LabOrg/e-WRF/blob/main/indata/fnl_20210414_12_00.grib2?raw=true --output fnl_20210414_12_00.grib2) 
(cd /WRF/indata && curl -LJ https://github.com/M2LabOrg/e-WRF/blob/main/indata/fnl_20210414_18_00.grib2?raw=true --output fnl_20210414_18_00.grib2) 
(cd /WRF/indata && curl -LJ https://github.com/M2LabOrg/e-WRF/blob/main/indata/fnl_20210415_00_00.grib2?raw=true --output fnl_20210415_00_00.grib2)
# Script for downloading other FNL data
(cd /WRF/indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/9fec54d2fcc2acdbd59083f20323a05ad3c0139c/indata/get_fnl_data.csh)
# Namelists for testing
(cd /WRF/indata && curl -LJO https://raw.githubusercontent.com/M2LabOrg/e-WRF/main/indata/namelist.input.e-wrf)
(cd /WRF/indata && curl -LJO https://raw.githubusercontent.com/M2LabOrg/e-WRF/main/indata/namelist.wps.e-wrf)


echo "Retrieved the data"

echo
echo -e "\e[0;49;32m-----------------------------------\e[0m"
echo -e "\e[7;49;32mRetrieving coupled test case domain files\e[0m"



echo
echo -e "\e[0;49;32m-----------------------------------\e[0m"
echo -e "You can also retrieve other data, including other geog files"
echo
echo "You can type the following command for examples on how to"
echo "use the curl command to download files"
echo -e "\033[33;5;7mcat runme_getdata.sh\033[0m"
echo -e "\e[0;49;32m-----------------------------------\e[0m"
