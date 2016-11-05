FROM alpine:edge

# Add local files and according directories to image
ADD src /

# Packages
RUN apk update && \
    apk upgrade && \
    apk add ca-certificates libvirt-daemon libvirt-qemu qemu qemu-x86_64 qemu-system-x86_64 openssh supervisor && \
    rm -rf /var/cache/apk/* && \
    chmod -R +x /usr/local/bin && \
    rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa && \
    mkdir -p /var/run/sshd

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
