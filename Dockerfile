FROM giovtorres/docker-centos7-slurm

LABEL org.opencontainers.image.source="https://github.com/repronim-services/reproman-slurm" \
      org.opencontainers.image.title="reproman-slurm" \
      org.opencontainers.image.description="Slurm + sshd for ReproMan testing" \
      org.label-schema.docker.cmd="docker run -it -h ernie repronim/reproman-slurm:latest" \
      maintainer="Kyle Meyer"

ENV PATH "/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin"

RUN set -x \
    && yum makecache fast \
    && yum -y update \
    && yum -y install \
        openssh-clients \
        openssh-server \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN echo 'root:root' | chpasswd
RUN mkdir /root/.ssh

EXPOSE 22/tcp

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["/bin/bash"]
