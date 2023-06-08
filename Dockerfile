#starting attempts for MiniScatter
FROM fedora:36

RUN dnf -y upgrade
RUN dnf -y group install "Development Tools"
RUN dnf -y group install "Python Science"

#OK, now we have a dev platform!

##Install ROOT
RUN dnf -y install wget git make cmake gcc-c++ gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel python openssl-devel
RUN dnf -y install expat expat-devel emacs xerces-c xerces-c-devel virtualenv htop libXmu-devel motif-devel libXpm-devel openssl-devel screen python3-h5py meld nodejs eigen3-devel tcl tcl-devel tk tk-devel gsl gsl-devel gmp gmp-devel qt5-qtbase-devel coreutils
RUN dnf -y install root 

##Install Geant4
###make directories
RUN mkdir code
RUN mkdir -p code/geant4

##download the tar.gz source code
RUN wget https://gitlab.cern.ch/geant4/geant4/-/archive/v11.1.1/geant4-v11.1.1.tar.gz
RUN tar -xzvf geant4-v11.1.1.tar.gz -C code/geant4 #unpack the file

RUN mkdir build #a scratch folder for actually building it
WORKDIR code/geant4/build

## cmake and set options
RUN cmake ../geant4-v11.1.1 -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=/code/geant4/4.11.1.1-MT-CXX17 -DGEANT4_BUILD_MULTITHREADED=ON -DGEANT4_INSTALL_DATA=ON -DGEANT4_INSTALL_DATADIR=/code/geant4/data/data_v4.11.1.1
#RUN cmake ../geant4-v11.1.1 -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=/code/geant4/4.11.1.1-MT-CXX17 -DGEANT4_BUILD_MULTITHREADED=ON -DGEANT4_INSTALL_DATA=ON -DGEANT4_INSTALL_DATADIR=/code/geant4/data/data_v4.11.1.1 -DGEANT4_USE_GDML=ON -DGEANT4_USE_OPENGL_X11=OFF -DGEANT4_USE_QT=OFF -DGEANT4_USE_RAYTRACER_X11=ON -DGEANT4_USE_XM=ON
RUN make
RUN make install
RUN source ../4.11.1.1-MT-CXX17/bin/geant4.sh

#Install MiniScatter
WORKDIR /
RUN git clone https://github.com/kyrsjo/MiniScatter.git
WORKDIR MiniScatter
RUN mkdir build
WORKDIR build
RUN cmake ../. -DGeant4_DIR=../../code/geant4/build
#RUN make

#./MiniScatter -h
