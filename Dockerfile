FROM giovtorres/docker-centos7-slurm

LABEL org.opencontainers.image.source="https://github.com/ReproNim/reproman-slurm" \
      org.opencontainers.image.title="reproman-slurm" \
      org.opencontainers.image.description="Slurm + sshd for ReproMan testing" \
      org.label-schema.docker.cmd="docker run -it -h ernie repronim/reproman-slurm:latest" \
      maintainer="Kyle Meyer"

ENV PATH "/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin"

RUN set -x \
    && yum makecache fast \
    && yum -y update \
    && yum -y install \
        hwloc \
        nmap-ncat \
        openssh-clients \
        openssh-server \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN git clone https://github.com/TACC/launcher /launcher

RUN echo 'root:root' | chpasswd
RUN mkdir /root/.ssh && echo "LAUNCHER_DIR=/launcher" >/root/.ssh/environment && \
   echo "PermitUserEnvironment yes" >>/etc/ssh/sshd_config

EXPOSE 22/tcp

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["/bin/bash"]
