##Docker image for the MiniScatter GEANT4 wrapper
Loads Fedora, Scientific programming packages, required dependencies, ROOT, GEANT4.
Then builds MiniScatter.

Instructions:

podman build -t miniscatter .

podman run --rm -it -p 8888:8888 -v <path-to-directory>:/home/ miniscatter

“-it” loads interactive mode and lets you run MiniScatter, definitely necessary.

Optional flags: “-p” for using a port if you need it, “-v” to connect the “/home/” directory to a directory in your external file system. Modify all components as needed. 

Once in the bash, don’t forget to load the tools needed to run MiniScatter with:

`source /code/geant4/4.11.0.0-MT-CXX17/bin/geant4.sh`

as printed at the end of the build. It will crash if you don’t :) 


