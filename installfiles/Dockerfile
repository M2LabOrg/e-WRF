#
FROM centos:7
MAINTAINER Michel Mesquita <michel@m2lab.org>
#
ENV WRF_VERSION 4.2
ENV WPS_VERSION 4.2
ENV NML_VERSION 4.2
#
# Set up base OS environment
RUN curl -SL https://ral.ucar.edu/sites/default/files/public/projects/ncar-docker-wrf/ucar-bsd-3-clause-license.pdf > /UCAR-BSD-3-Clause-License.pdf
#
RUN yum -y update

# Centos and Python
RUN yum -y install centos-release-scl \
 && yum -y install --setopt=tsflags=nodocs rh-python36

# Editor
RUN yum -y install nano

# Other libraries
RUN yum -y install file gcc gcc-gfortran gcc-c++ glibc.i686 libgcc.i686 libpng-devel jasper \
  jasper-devel hostname m4 make perl tar bash tcsh time wget which zlib zlib-devel \
  openssh-clients openssh-server net-tools fontconfig libgfortran libXext libXrender ImageMagick sudo epel-release
#
# Netcdf and openmpi 
RUN yum -y install netcdf-openmpi-devel.x86_64 netcdf-fortran-openmpi-devel.x86_64 \
    netcdf-fortran-openmpi.x86_64 hdf5-openmpi.x86_64 openmpi.x86_64 openmpi-devel.x86_64 \
   && yum clean all
#
RUN mkdir -p /var/run/sshd \
    && ssh-keygen -A \
    && sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#RSAAuthentication yes/RSAAuthentication yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
#
RUN groupadd wrf -g 9999
RUN useradd -u 9999 -g wrf -G wheel -M -d /WRF wrfuser
#

RUN mkdir /WRF \
 &&  chown -R wrfuser:wrf /WRF \
 &&  chmod 6755 /WRF

RUN mkdir -p  /WRF/WPS_GEOG /WRF/indata /WRF/outdata \
 &&  chown -R wrfuser:wrf /WRF /WRF/WPS_GEOG /WRF/indata /WRF/outdata /usr/local \
 &&  chmod 6755 /WRF /WRF/WPS_GEOG /WRF/indata /WRF/outdata /usr/local

# Set environment for interactive container shells
#
RUN echo export LDFLAGS="-lm" >> /etc/bashrc \
 && echo export NETCDF=/WRF/netcdf_links >> /etc/bashrc \
 && echo export JASPERINC=/usr/include/jasper/ >> /etc/bashrc \
 && echo export JASPERLIB=/usr/lib64/ >> /etc/bashrc \
 && echo export LD_LIBRARY_PATH="/usr/lib64/openmpi/lib" >> /etc/bashrc \
 && echo export PATH=".:/usr/lib64/openmpi/bin:$PATH" >> /etc/bashrc \
 && echo setenv LDFLAGS "-lm" >> /etc/csh.cshrc \
 && echo setenv NETCDF "/WRF/netcdf_links" >> /etc/csh.cshrc \
 && echo setenv JASPERINC "/usr/include/jasper/" >> /etc/csh.cshrc \
 && echo setenv JASPERLIB "/usr/lib64/" >> /etc/csh.cshrc \
 && echo setenv LD_LIBRARY_PATH "/usr/lib64/openmpi/lib" >> /etc/csh.cshrc \
 && echo setenv PATH ".:/usr/lib64/openmpi/bin:$PATH" >> /etc/csh.cshrc
#
#
RUN mkdir /WRF/.ssh ; echo "StrictHostKeyChecking no" > /WRF/.ssh/config
COPY default-mca-params.conf /WRF/.openmpi/mca-params.conf
RUN mkdir -p /WRF/.openmpi
RUN chown -R wrfuser:wrf /WRF/
# RUN echo "root    ALL=(ALL)     ALL" >> /etc/sudoers
#
#
# all root steps completed above, now below as regular userID wrfuser
USER wrfuser
WORKDIR /WRF
#
#
RUN curl -SL http://www2.mmm.ucar.edu/wrf/src/wps_files/geog_low_res_mandatory.tar.gz | tar -xzC /WRF/WPS_GEOG
# input FNL data for testing
RUN (cd /WRF/indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/9fec54d2fcc2acdbd59083f20323a05ad3c0139c/indata/fnl_20210414_06_00.grib2)
RUN (cd /WRF/indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/9fec54d2fcc2acdbd59083f20323a05ad3c0139c/indata/fnl_20210414_12_00.grib2) 
RUN (cd /WRF/indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/9fec54d2fcc2acdbd59083f20323a05ad3c0139c/indata/fnl_20210414_18_00.grib2) 
RUN (cd /WRF/indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/9fec54d2fcc2acdbd59083f20323a05ad3c0139c/indata/fnl_20210415_00_00.grib2)
# Script for downloading other FNL data
RUN (cd /WRF/indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/9fec54d2fcc2acdbd59083f20323a05ad3c0139c/indata/get_fnl_data.csh)
# Namelists for testing
RUN (cd /WRF/indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/c6228618b2b719a97fdc9379a0d95af3e4a974d0/indata/namelist.input.e-wrf)
RUN (cd /WRF/indata && curl -LJO https://github.com/M2LabOrg/e-WRF/blob/c6228618b2b719a97fdc9379a0d95af3e4a974d0/indata/namelist.wps.e-wrf)
#
# NCL
#
RUN curl -SL https://ral.ucar.edu/sites/default/files/public/projects/ncar-docker-wrf/nclncarg-6.3.0.linuxcentos7.0x8664nodapgcc482.tar.gz | tar zxC /usr/local
ENV NCARG_ROOT /usr/local
#
#
# WRF and WPS, version given at the top of script
RUN curl -SL https://github.com/wrf-model/WPS/archive/v$WPS_VERSION.tar.gz | tar zxC /WRF \
 && curl -SL https://github.com/wrf-model/WRF/archive/v$WRF_VERSION.tar.gz | tar zxC /WRF
RUN mv /WRF/WPS-$WPS_VERSION /WRF/WPS
RUN mv /WRF/WRF-$WRF_VERSION /WRF/WRF
ENV NETCDF_classic 1
#
# 
 RUN mkdir netcdf_links \
  && ln -sf /usr/include/openmpi-x86_64/ netcdf_links/include \
  && ln -sf /usr/lib64/openmpi/lib netcdf_links/lib \
  && export NETCDF=/WRF/netcdf_links \
  && export JASPERINC=/usr/include/jasper/ \
  && export JASPERLIB=/usr/lib64/ 

ENV LD_LIBRARY_PATH /usr/lib64/openmpi/lib
ENV PATH  /usr/lib64/openmpi/bin:$PATH
#
#
RUN ssh-keygen -f /WRF/.ssh/id_rsa -t rsa -N '' \
    && chmod 600 /WRF/.ssh/config \
    && chmod 700 /WRF/.ssh \
    && cp /WRF/.ssh/id_rsa.pub /WRF/.ssh/authorized_keys
#
#
CMD ["/bin/tcsh"]
#
