# Logiciel Furet du Nord
## Sommaire
- [Présentation](#présentation)
- [MCD](#mcd)
- [Détails du projet](#détails-du-projet)
- [Exemple d'utilisation](#exemple-dutilisation)


## Présentation

Ce projet consiste à réaliser un logiciel dans le langage Dart reposant sur la programmation orientée objet permettant à l'utilisateur de gérer une base de données sans avoir besoin de connaissances en SQL ou Dart. Ce dernier comprend 3 tables différentes au sein de sa BDD soit une table Auteur, Editeur et enfin Produit.


## MCD
![Projet furet](https://user-images.githubusercontent.com/100768194/162479396-4185caf7-3329-4288-a196-0fa339e0fdf1.png)


## Détails du projet

### Fonctionnement

Ce logiciel se lance dans un terminal ; son utilisation se fait à l'aide d'écrans distincts qui apparaissent en fonction des choix faits par l'utilisateur. 
Les choix réalisés se traduisent par des entiers : c'est à dire qu'un entier permet de déterminer la suite du logiciel selon la volonté de l'utilisateur.


### Les affichages / saisies (IHM)

Les différents écrans se trouvent dans les classes "IHM" tel que "IHM_Auteur", "IHM_Editeur", "IHM_Produit" ou encore "IHM_P". 
Cette dernière classe permet l'affichage des écrans principaux.
La saisie des paramètres qui permettent la connexion à la BDD, est donc assurée par cette classe. Notamment les saisies de l'utilisateur et l'affichage donnant suite aux requêtes ayant un impact sur la BDD entière. 
Les 3 autres IHM permettent donc l'affichage engendrant les requêtes sur une seule et unique table.


### L'intelligence (DB)

Concernant l'intelligence du logiciel elle-même, on trouve les classes "DB" comme "DB_Auteur", "DB_Editeur", "DB_Produit" et pour finir "DB_Config". 
Ces classes comme dit précédemment sont l'intelligence même du logiciel. 
En somme, ce sont ces classes qui réalisent les connexions à la BDD ou exécutent les requêtes SQL souhaitées. 
Les méthodes lançant les requêtes SQL demandées sont appellées par leurs IHM réspectives.

### Les différentes requêtes

Le logiciel propose une multitude de requêtes possible, on trouve pour les différentes tables (Auteur, Editeur et Produit):
* Insérer un élément
* Modifer un élément en fonction de son identifiant (ID)
* Supprimer tous les éléments de la table ou un élément précis en fonction de son identifiant (ID)
* Selectionner tous les éléments de la table ou un élément précis en fonction de son identifiant (ID)

Les requêtes qui se trouvent dans la classe "DB_Config" permettent d'affecter la BDD de manière générale tel que:
* Vérifier l'éxistance de toutes les tables dans la BDD
* Créer les tables manquantes
* Afficher la liste des tables présentent dans la BDD
* Supprimer toutes les tables ou une tables précise en fonction de son nom
Il est à noter que la suppression des tables Auteur ou Editeur avant Produit est impossible puisque cette dernière détient des clés étrangères.

## Exemple d'utilisation

Pour commencer, le logiciel demandera la saisie des paramètres de connexion à la BDD:

![saisir settings](https://user-images.githubusercontent.com/100768194/162490541-2ba2c553-2bd7-46b1-923d-a7b766eb609f.png)

Il effectuera une vérification de ces identifiants par une tentative de connexion. Si celle-ci échoue, la saisie sera redemandée.

Par la suite, nous arrivons sur un écran nous demandant le choix de la table sur laquelle nous souhaitons travailler:

![saisir choix tables](https://user-images.githubusercontent.com/100768194/162490775-b5a5140c-7594-4e00-8dd1-aabaa084c57f.png)

Dans cet exemple, nous irons faire nos modifications sur la BDD entière, nous saisissons alors ``` 1 ``` ce qui nous conduira vers l'écran ci-dessous:

![saisir choix BDD](https://user-images.githubusercontent.com/100768194/162491166-59b117e7-333c-4960-b3db-4d7fa7dc7f5a.png)

Différents choix nous sont proposés, pour commencer nous voulons vérifier l'existence des tables dans notre BDD, nous saisissons donc ``` 2 ```:

![tables manquantes](https://user-images.githubusercontent.com/100768194/162491360-fb115089-9319-4756-bb1d-e87b553f525d.png)

On remarque alors que notre BDD n'a pas toutes les tables nécessaires à son bon fonctionnement. Nous alons alors à présent saisir ``` 1 ``` pour y remédier:

![création tables](https://user-images.githubusercontent.com/100768194/162491491-03e1f851-830d-49d2-9be6-e06a82b5404f.png)

A présent, nous pouvons re-vérifier leur existence ou bien les afficher directement. Pour cela, il suffit d'entrer ``` 3 ```:

![afficher tables](https://user-images.githubusercontent.com/100768194/162491666-50122925-97bc-4572-aa98-ffae50f04686.png)

Nous constatons que les tables sont présentes. Nous pouvons alors retourner au menu précédent pour en modifier le contenu en tapant ``` 0 ```:

![menu précédent](https://user-images.githubusercontent.com/100768194/162492159-568adbdd-b802-4aac-8853-b96e63eb55a4.png)

