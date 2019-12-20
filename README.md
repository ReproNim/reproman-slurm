This image exists for testing [ReproMan's][rman] Slurm submitter.  All
the hard work is done by the [docker-centos7-slurm][dcs] image.  This
Dockerfile adds OpenSSH on top so that the container can be exposed as
a ReproMan SSH resource.

At some point it'd be good to add [DataLad][dl] to the image to
provide a more fully functioning ReproMan resource.  Doing so will
require custom Git and git-annex installs because the yum repository
for CentOS 7.7.1908 offers very old versions: Git 1.8.3.1 and
git-annex 5.20140221.

[dcs]: https://github.com/giovtorres/docker-centos7-slurm
[dl]: https://www.datalad.org/
[rman]: https://github.com/ReproNim/reproman
