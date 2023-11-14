###Building image for MiniScatter
FROM fedora:36

RUN dnf -y upgrade
RUN dnf -y group install "Development Tools"
RUN dnf -y group install "Python Science"

##OK, now we have a dev platform!

###Install various packages and ROOT
RUN dnf -y install wget git make cmake gcc-c++ gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel python openssl-devel
RUN dnf -y install expat expat-devel emacs xerces-c xerces-c-devel virtualenv htop libXmu-devel motif-devel libXpm-devel openssl-devel screen python3-h5py meld nodejs eigen3-devel tcl tcl-devel tk tk-devel gsl gsl-devel gmp gmp-devel qt5-qtbase-devel coreutils
RUN dnf -y install root python3-root root-notebook

###Install Geant4
##Make directories
RUN mkdir code
RUN mkdir -p code/geant4

##Download the tar.gz source code
RUN wget https://gitlab.cern.ch/geant4/geant4/-/archive/v11.0.0/geant4-v11.0.0.tar.gz
RUN tar -xzvf geant4-v11.0.0.tar.gz -C code/geant4 #unpack the file
RUN mkdir build
WORKDIR code/geant4/build

##Cmake and set options
RUN cmake ../geant4-v11.0.0 -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=/code/geant4/4.11.0.0-MT-CXX17 -DGEANT4_BUILD_MULTITHREADED=ON -DGEANT4_INSTALL_DATA=ON -DGEANT4_INSTALL_DATADIR=/code/geant4/data/data_v4.11.0.0
RUN make -j 8
RUN make install

###Install MiniScatter
WORKDIR /
RUN git clone https://github.com/kyrsjo/MiniScatter.git
WORKDIR MiniScatter
RUN mkdir build
WORKDIR build
RUN cmake ../. -DGeant4_DIR=../../code/geant4/build
RUN make -j 8

RUN echo "run 'source /code/geant4/4.11.0.0-MT-CXX17/bin/geant4.sh' to run MiniScatter"
