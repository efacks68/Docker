#starting attempts for MiniScatter
FROM fedora:36

RUN dnf -y upgrade
RUN dnf -y group install "Development Tools"
RUN dnf -y group install "Python Science"

#OK, now we have a dev platform!


##Install ROOT
RUN dnf -y install wget git make cmake gcc-c++ gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel python openssl-devel

RUN dnf -y install root 

##Install Geant4

##make directories
##RUN cd #
RUN mkdir code
RUN mkdir -p code/geant4
##RUN cd code/geant4

##download the tar.gz source code
RUN wget https://gitlab.cern.ch/geant4/geant4/-/archive/v11.1.1/geant4-v11.1.1.tar.gz
##RUN ls
##RUN mv ~/Downloads/geant4-v11.1.1.tar.gz . #move the file to the folder

RUN tar -xzvf geant4-v11.1.1.tar.gz -C code/geant4 #unpack the file

#WORKDIR code/geant4
RUN mkdir build #a scratch folder for actually building it
WORKDIR code/geant4/build

#RUN cmake ../geant4-v11.1.1 
#-DCMAKE_INSTALL_PREFIX=/home/code/geant4/geant4-v11.1.1-build -DGEANT4_INSTALL_DATA=ON
#RUN make

#RUN make install

#RUN source ~/code/geant4/geant4-v11.1.1-install/bin/geant4.sh
