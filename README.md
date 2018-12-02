# filament_docker
Utility for building a Docker image to run [Google Filament](https://github.com/google/filament).

# Basic usage

You'll probably need to be on Ubuntu 16.04, or something else on which `nvidia-docker` works happily. And you'll need nvidia-docker -- follow e.g. [these instructions](https://github.com/RobotLocomotion/spartan/blob/master/setup/docker/README.md) to get that set up.

When you're happily set up, run:

```docker pull gizatt/filament:latest
python docker_run.py -i gizatt/filament:latest```

and then in the root directory that that drops you into, run

```./launch_demo.sh```

which should fire up a graphical window that is powered by Filament.

# Compiling a new image

Check out the version of Filament that you're interested in building an image for in the `filament` submodule, and then use the automated script:

`python docker_build.py`

which will take a while, but should succeed. (I found the Filament build to be very sensitive, so I wouldn't be surprised if this breaks.)
