FROM centos:7
SHELL ["/bin/bash", "-c"]
USER 0
ARG USERNAME
ARG USERID
RUN echo USERID=${USERID} USERNAME=${USERNAME}
RUN useradd --uid ${USERID} ${USERNAME}
ENTRYPOINT ["/bin/bash"]
