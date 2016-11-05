FROM alpine:edge

# Add local files and according directories to image
ADD src /

# Packages
RUN apk update && \
    apk upgrade && \
    apk add ca-certificates libvirt-daemon libvirt-qemu qemu qemu-x86_64 qemu-system-x86_64 openssh supervisor && \
    rm -rf /var/cache/apk/*

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor.conf"]
