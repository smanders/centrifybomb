# centrifybomb

there is a move to employ [Centrify](https://www.centrify.com/) on development systems in our organization

Centrify and our Docker build images don't currently mix well... one of the final Docker image layers
[adds a user](https://github.com/smanders/buildpro/blob/21.09/compose/.devcontainer/centos7-pro.dockerfile#L13)
to match the user id (and group id) of the user on the host running the docker-compose script -- this is common
practice and makes it so any files created in the build container have the same user ownership in the host OS
and so git configuration and ssh keys work seamlessly between host OS and Docker build container

this repo is a minimal reproduction of the issue we are seeing with Centrify and Docker
* a simple [Dockerfile](Dockerfile) calls useradd, which is where things go awry
* a [build script (bld.sh)](bld.sh) calls `docker image build` and provides build arguments for USERID and USERNAME used by
  the Dockerfile
* if the image build was successful (it isn't for systems with Centrify installed, but is without Centrify in the mix),
  a [run script (run.sh)](run.sh) starts a container using the built image
* when things go south (with Centrify in the mix),
  even after cancelling the build and cleaning up all things Docker via (`docker system prune`),
  the `/var/lib/docker` directory starts to grow uncontrollably until it fills the drive (hence the name: centrifybomb)
  -- when this happens, the only recourse I've found is to uninstall docker, which is what the
  [delete script (del.sh)](del.sh) does, on a Ubuntu 18.04 host OS system
* after docker has been removed/purged and the system rebooted (necessary for a successful reinstall, in my experience),
  the [new script (new.sh)](new.sh) installs docker on Ubuntu 18.04 and runs `docker run hello-world` to verify docker install

the fix branch https://github.com/smanders/centrifybomb/compare/fix shows the workaround and the commit message provides
a URL with more detail

the realfix branch https://github.com/smanders/centrifybomb/compare/realfix shows the fix and the commit message provides more detail
