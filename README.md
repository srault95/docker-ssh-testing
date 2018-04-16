# Docker SSH for Testing

Environnement Docker avec serveur SSH intégré et lancé automatiquement en tâche de fond.

Cette image peut servir pour simuler plusieurs serveurs dans un déploiement automatique par SSH avec **Ansible** ou **Fabric**.

Un utilisateur (par défault: admin-user) avec des droits **sudo** est créé pendant l'exécution du conteneur.

La connection SSH est possible de l'extérieur du conteneur Docker à l'aide de la clé publique non sécurisée qui est installée dans **/home/${SSH_USER}/.ssh/authorized_keys**.

Le conteneur Docker peu également initier une connection cliente SSH vers un autre conteneur Docker à l'aide de la clé privée située dans **/home/${SSH_USER}/.ssh/id_rsa**.

## Usage

```
# Téléchargement de la clé SSH privée
curl -L https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant -o id_rsa_myuser

chmod 0600 id_rsa_myuser

# Création d'un conteneur avec écoute SSH sur 127.0.0.1 avec le port 2200
docker run -d --name sshtest1 -p 127.0.0.1:2200:22 -e SSH_USER=myuser srault95/docker-ssh-testing:centos6

ssh -i ./id_rsa_myuser -p 2200 myuser@127.0.0.1

# OU

docker run -d --name sshtest1 -e SSH_USER=myuser srault95/docker-ssh-testing:centos6

SSH_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" sshtest1)

ssh -i ./id_rsa_myuser myuser@${SSH_IP}
```

> Ajoutez ```-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no``` si vous avez des erreurs comme **Host key verification failed**

## Pour personnaliser l'image

```
# Dockerfile
FROM srault95/docker-ssh-testing:centos6
ADD . /app
```

```
docker build -t myssh .

docker run -d --name sshtest1 -e SSH_USER=myuser myssh
```
