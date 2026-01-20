# TP Cloud 1 : Introduction au Cloud avec OpenTofu et MinIO

## 1. Objectif
Ce projet met en œuvre une infrastructure de stockage objet locale en utilisant l'approche **Infrastructure as Code (IaC)**. Conformément aux consignes du TP, nous avons utilisé **OpenTofu** pour orchestrer les ressources et **MinIO** pour simuler un service compatible S3.

## 2. Structure du Rendu
Ce dépôt contient l'ensemble des fichiers demandés :
* `main.tf` : Description de l'infrastructure.
* `variables.tf` : Définition des variables.
* `outputs.tf` : Sorties utiles (URL du site).
* `capture d'écran.png` : Preuve du fonctionnement.

## 3. Étapes réalisées (Conformément au TP)

### 3.1 Installation des outils
Les outils nécessaires ont été installés sur un environnement Windows :
* **OpenTofu** (via Winget/Scoop) pour l'IaC.
* **MinIO Server** (binaire exécutable) pour le stockage objet.
* **Git** pour le versionning.

### 3.2 Lancement du serveur MinIO
1. Création du répertoire de données `minio-data`.
2. Lancement du serveur local avec la commande :
   .\minio.exe server .\minio-data --console-address ":9001"
3. Accès vérifié via la console d'administration sur http://localhost:9001.

### 3.3 Création de la configuration OpenTofu
1. Initialisation du projet dans le dossier tp1-minio.
2. Création du fichier main.tf configurant le provider minio (pointant vers localhost:9000).
3. Définition d'une première ressource : un bucket nommé tp1-cloud-bucket en mode privé.

### 3.4 Initialisation et déploiement
Le cycle de vie IaC a été validé avec les commandes suivantes :
    tofu init : Téléchargement du provider MinIO.
    tofu plan : Vérification du plan d'exécution (création du bucket).
    tofu apply : Déploiement effectif.
Vérification : Le bucket tp1-cloud-bucket est apparu correctement dans la console MinIO.

### 3.5 Transformation en site web statique
Le code a été enrichi pour héberger un site web :
    Création des fichiers locaux index.html et style.css.
    Modification de main.tf pour créer un nouveau bucket webbucket.

### 3.6 Gestion des Variables et Secrets
1. Les accès (User/Password) ont été extraits du main.tf.
2. Ils ont été placés dans un fichier terraform.tfvars (exclu de Git via .gitignore).
3. Un fichier variables.tf a été créé pour déclarer ces entrées.
4. Un fichier outputs.tf a été ajouté pour afficher l'URL du site après le déploiement.

### 3.7 Optimisation Sécurité
Conformément aux exigences de sécurité :
    L'ACL du bucket webbucket a été configurée sur private pour empêcher le listing public des fichiers.
    Les objets spécifiques (index.html et style.css) ont été configurés pour être accessibles publiquement (public-read), permettant l'accès au site web sans exposer le reste du bucket.

### 3.8 Validation et Nettoyage
Le cycle complet a été testé pour prouver la résilience de l'infrastructure :
    Destruction : Exécution de tofu destroy -> Suppression de toutes les ressources (buckets et fichiers).
    Reconstruction : Exécution de tofu apply -> Tout l'environnement (site web inclus) a été reconstruit automatiquement et fonctionnel en quelques secondes.