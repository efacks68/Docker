##Docker image for the MiniScatter GEANT4 wrapper
Loads Fedora, Scientific programming packages, required dependencies, ROOT, GEANT4.
Then builds MiniScatter.

Instructions:

podman build -t rasterscatter .

podman run --rm -it -p 8888:8888 -v <path-to-directory>:/home/ rasterscatter 

-it loads interactive mode. Once in the bash, load the tools needed to run MiniScatter with:

`source /code/geant4/4.10.7.3-MT-CXX17/bin/geant4.sh`

as printed at the end of the build.

Be sure to check for the correct Geant4 version

