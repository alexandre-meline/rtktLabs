# rootkitLabs

Le script BASH et le Dockerfile sont utilisés pour créer un environnement minimaliste avec Busybox et un initramfs personnalisé pour les besoins du cours de l'[École 2600](https://ecole2600.com/)
: "Linux Kernel Programming I - Workshop". Les étapes suivantes expliquent en détail comment le système est construit.

## Script BASH

Le script BASH est utilisé pour préparer l'initramfs et la configuration du disque image. Voici un aperçu des principales étapes effectuées par le script :

1. Vérification des privilèges root.
2. Suppression des répertoires et fichiers existants s'ils sont présents.
3. Vérification et suppression des périphériques loopback existants.
4. Configuration de certaines variables d'environnement.
5. Clonage du référentiel Busybox et construction de Busybox.
6. Création d'un répertoire `my_init_loop` et d'un programme C `main.c`.
7. Création de la structure de répertoires pour l'initramfs.
8. Copie des fichiers de Busybox dans l'initramfs.
9. Compilation et ajout du programme `my_init_loop` dans l'initramfs.
10. Copie des bibliothèques nécessaires dans l'initramfs.
11. Création du script `init` pour l'initramfs.
12. Création d'une image CPIO gzippée de l'initramfs.

## Utilisation
Une fois que le script BASH a été exécuté avec succès pour créer l'initramfs et configurer le disque image, vous pouvez lancer Qemu avec le disque image pour tester votre environnement minimaliste. Assurez-vous de suivre les étapes du sujet du cours pour configurer Qemu et le système NFS si nécessaire.

N'oubliez pas de personnaliser le script et le Dockerfile en fonction de vos besoins spécifiques et de votre configuration.
```
chmod +x ./build
sudo ./build
```

## Dockerfile

Le Dockerfile est utilisé pour configurer un système minimaliste Alpine Linux qui sera inclus dans l'initramfs. Voici un aperçu des principales étapes effectuées par le Dockerfile :

1. Utilisation d'une image Alpine Linux de base.
2. Installation des packages nécessaires tels qu'OpenRC, util-linux, build-base, Vim, etc.
3. Configuration de l'accès au port série via QEmu.
4. Définition d'un mot de passe pour l'utilisateur root.
5. Configuration des systèmes de fichiers pseudo.
6. Copie des fichiers de configuration de Docker dans le répertoire monté du disque image.
