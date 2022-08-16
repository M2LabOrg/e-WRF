<table>
   <tr>
      <td> <img src="https://github.com/M2LabOrg/MISC/blob/8d099e146d84b9d011358030888c5b069b1e8c54/Logo_M2Lab.png" align="center" height="50"></td>
      <td><img src="https://github.com/M2LabOrg/MISC/blob/8d099e146d84b9d011358030888c5b069b1e8c54/Yarker-Consulting-Logo-Darker-700x125.png" align="center" height="50"></td>
      <td><img src="https://github.com/M2LabOrg/MISC/blob/8d099e146d84b9d011358030888c5b069b1e8c54/YCOMM_logo-300x89.png" align="center" height="50">
  </td>
  </tr>
</table>


# e-WRF: Educational purposes

This page contains scripts for installing WRF v4.4 for educational purposes. WRF stands for the "Weather Research and Forecasting" model, developed by NCAR (see copyright information below).

## Input data
The [input data](indata/) used here are based on the FNL model: NCEP FNL Operational Model Global Tropospheric Analyses. Only four files are used as examples to be ingested in WRF (See reference below).

## Installation files
The [installation files](installfiles/) are used as part of our educational lessons. Please, contact us for more information on how to used them.

### WRF Copyright statement
Copyright (c) 2017 the University Corporation for Atmospheric Research (“UCAR”). [All rights reserved](https://github.com/NCAR/container-wrf/raw/dd94dd90d01459e483bf032103e7a56761bae025/UCAR-BSD-3-Clause-License.pdf).
Developed at the Research Applications Laboratory at National Center for Atmospheric Research (“NCAR”).

### FNL Reference
National Centers for Environmental Prediction/National Weather Service/NOAA/U.S. Department of Commerce, 2000: NCEP FNL Operational Model Global Tropospheric Analyses, continuing from July 1999. Research Data Archive at the National Center for Atmospheric Research, Computational and Information Systems Laboratory, Boulder, CO. [Available online at https://doi.org/10.5065/D6M043C6.] Accessed† 15 Apr 2021.

### WRF-Python
One can use plotgrids.ncl to plot the WRF domains. However, the new wrf-python package allows you to read WRF files and plot variables from them. The folder [WRF_Python](WRF_Python/) contains an example script on how you can do that. There, you will also find a wrfout file for you to test, as well as a plot of the domain.

> Contents developed by: 
>   > **Michel Mesquita**, PhD | m2lab.io, YCOMM, michel@m2lab.org
>   > 
>   > **Morgan Yarker**, PhD | Yarker Consulting, YCOMM
>   > **Michelle Serino Steinmacher**, MSc | Yarker Consulting
