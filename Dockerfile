# Utilisez une image Alpine Linux comme base
FROM alpine:latest

# Installez les packages nécessaires pour votre système minimaliste
RUN apk --no-cache add \
    openrc \
    util-linux \
    build-base \
    vim \
    tar

# Configuration de l'accès au port série via QEmu
RUN ln -s agetty /etc/init.d/agetty.ttyS0 \
    && echo ttyS0 > /etc/securetty \
    && rc-update add agetty.ttyS0 default \
    && rc-update add root default

# Définissez un mot de passe pour l'utilisateur root
RUN echo "root:your_password_here" | chpasswd

# Configuration des systèmes de fichiers pseudo
RUN rc-update add devfs boot \
    && rc-update add procfs boot \
    && rc-update add sysfs boot

# We copy the Docker configuration into the mounted partition of the disk image, which is
# accessible under Docker in my-rootfs.
RUN mkdir -p /my-rootfs

RUN for d in bin etc lib root sbin usr; do tar c "/$d" | tar x -C /my-rootfs; done

RUN for dir in dev proc run sys var; do mkdir /my-rootfs/${dir}; done


