#
FROM centos:7
LABEL maintainer="Michel Mesquita michel@m2lab.org"
#
ENV WRF_VERSION 4.2
ENV WPS_VERSION 4.2
ENV NML_VERSION 4.2
# To use yum with the latest Centos, we need this line. Otherwise, use Centos 7
# RUN dnf --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos -y \
#    && dnf distro-sync -y
#
# Set up base OS environment
RUN curl -SL https://github.com/NCAR/container-wrf/raw/dd94dd90d01459e483bf032103e7a56761bae025/UCAR-BSD-3-Clause-License.pdf > /UCAR-BSD-3-Clause-License.pdf
#
RUN yum -y update

# Editors
RUN yum -y install nano gedit

# Centos and Python
RUN yum -y install centos-release-scl \
 && yum -y install --setopt=tsflags=nodocs rh-python38

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
#
# Copy runme file here
COPY runme_getdata.sh /WRF/.
RUN chmod 777 /WRF/runme_getdata.sh
# RUN echo "root    ALL=(ALL)     ALL" >> /etc/sudoers
#
#
# all root steps completed above, now below as regular userID wrfuser
USER wrfuser
WORKDIR /WRF
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
# Configure WRF with options 34 (dmpar) and 1 (basic nesting)
# Then compile em_real
RUN cd WRF \
    && export NETCDF=/WRF/netcdf_links \
    && printf '34\n1\n' | ./configure \
    && ./compile em_real  > /dev/null 2>&1
#
# Configure and compile WPS
# Discard compile output since it reaches Docker's log limit
RUN cd /WRF/WPS && ./clean -a \
    && cd /WRF/WPS && export NETCDF=/WRF/netcdf_links && printf '1\n' | ./configure  \
    && sed -i 's/-lnetcdf/-lnetcdff -lnetcdf/g' configure.wps \
    && ./compile
#
CMD ["/bin/tcsh"]
#
