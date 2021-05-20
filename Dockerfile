FROM centos:7
SHELL ["/bin/bash", "-c"]
USER 0
ARG USERNAME
ARG USERID
RUN echo USERID=${USERID} USERNAME=${USERNAME}
RUN groupadd -g ${USERID} ${USERNAME} \
  && echo "${USERNAME}:x:${USERID}:${USERID}::/home/${USERNAME}:/bin/bash" >> /etc/passwd \
  && cp -a /etc/skel /home/${USERNAME} && chown -R ${USERNAME} /home/${USERNAME} \
  && chmod -R go=u,go-w /home/${USERNAME} && chmod go= /home/${USERNAME}
ENTRYPOINT ["/bin/bash"]
