FROM nvidia/cuda:8.0-devel-ubuntu14.04

COPY filament/ /filament/

COPY install_prereqs.sh /tmp/install_prereqs.sh
RUN yes "Y" | /tmp/install_prereqs.sh

COPY docker_setup.sh /tmp/docker_setup.sh
RUN /tmp/docker_setup.sh

COPY do_build.sh /filament
RUN /filament/do_build.sh

COPY launch_demo_pbr.sh /launch_demo_pbr.sh
COPY launch_demo_helmet.sh /launch_demo_helmet.sh

ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
ENV LIBRARY_PATH=/usr/local/lib:${LIBRARY_PATH}

ENTRYPOINT bash -c "/bin/bash"
