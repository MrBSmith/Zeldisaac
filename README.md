Baba des bois

## **Partie 1: Les bases de Godot, et déplacements du personnage**
[1:20](https://www.youtube.com/watch?v=xoivFC5wXq4&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=1&t=80s) Initialisation du projet

- nouveau projet - Interface
- système de fichiers res:// - Interface
- import de sprites - Interface

[3:30](https://www.youtube.com/watch?v=xoivFC5wXq4&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=1&t=210s) Votre première scène

- système de nœuds - Interface
- **Node2D** - Noeud
- **KinematicBody2D** – Nœud
- **Sprite** - Noeud
- **Sprite** – Ajout d’une texture – Interface
- import des images, 2DPixel – Interface
- lancement du jeu – Interface
- placement des nœuds – Interface
- vérouiller le placement d’un nœud – Interface
- créer un script pour un nœud – Interface

[10:06](https://www.youtube.com/watch?v=xoivFC5wXq4&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=1&t=606s) Les bases de GDscript : Les variables

- les commentaires avec **#** - GDScript
- déclaration d’une variable – GDScript
- types de variables – GDScript
- la fonction **\_\_ready()** - GDScript
- tabulations – GDScript
- la fonction **print()**, la console – GDScript
- typer une variable (**int**, **float**, **String**, **bool**) – GDScript

[22:00](https://www.youtube.com/watch?v=xoivFC5wXq4&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=1&t=1320s) Les bases de GDscript : Les fonctions

- déclaration d’une fonction **func** – GDScript
- arguments d’une fonction – GDScript
- retourner une valeur avec **return** – GDScript
- typer le return d’une fonction avec **->** - GDScript

[29:30](https://www.youtube.com/watch?v=xoivFC5wXq4&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=1&t=1770s) Les deplacements

- le mot clé **pass** – GDScript
- condition **if** – GDScript
- la fonction **\_input()** – GDScript
- la fonction **is\_action\_pressed()** – GDScript
- variables locales – GDScript
- la fonction **move\_and\_slide()** – GDScript
- le type **Vector2** – GDScript
- la fonction **\_process()** – GDScript

## **Partie 2: Tilemap & Collisions**
[0:12](https://www.youtube.com/watch?v=YBm6d_xO55Y&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=2&t=12s) Scene & instances de scenes

- Sauvegarder la branche comme scène – Nœud
- Créer des instances de scène – Nœud
- Modifier un paramètre d’une instance de scène – Nœud

[3:15](https://www.youtube.com/watch?v=YBm6d_xO55Y&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=2&t=195s) Tilemap

- **Tilemap** – Nœud
- **Tilemap** créer un tileset – Interface
- **Tilemap** créer des tuilles (tiles) – Interface
- **Tilemap** taille des tuilles (**Cell**) – Interface
- **Tilemap** - **Atlas** – Interface
- **Tilemap** – Copier / coller des groupes de tiles – Interface
- **Tilemap** – Faire des lignes et des carrés de tiles – Interface
- Affichage des nœuds – Noeud

[9:17](https://www.youtube.com/watch?v=YBm6d_xO55Y&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=2&t=557s) Les collisions du Tilemap

- **Tilemap** – Les collisions – Interface
- **CollisionShape2D** – Nœud
- **CollisionShape2D** - définir le Shape  – Nœud
- Débogage – Formes de collisions visibles – Interface

## **Partie 3: Animations de mouvement et conditions**

[0:22](https://www.youtube.com/watch?v=bTGAeXB1nHw&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=3&t=22s) AnimatedSprite & SpriteFrame

- Changer le type d’un nœud – Interface
- **AnimatedSprite** – Nœud
- **AnimatedSprite** – créer **SpriteFrames**– Interface
- **AnimatedSprite** – découper spritesheet en frames – Interface
- **AnimatedSprite** – Créer animation – Interface
- **AnimatedSprite** – Jouer animation – Interface
- **AnimatedSprite** – Vitesse de l’animation – Interface
- **AnimatedSprite** – Ajouter une autre animation – Interface

[3:48](https://www.youtube.com/watch?v=bTGAeXB1nHw&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=3&t=228s) Petite correction de mouvements

- Changement de event à Input – GDScript

[4:43](https://www.youtube.com/watch?v=bTGAeXB1nHw&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=3&t=283s) Les conditions

- les conditions **if** – else – GDScript
- comparaison **==**, **!=** – GDScript

[10:02](https://www.youtube.com/watch?v=bTGAeXB1nHw&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=3&t=602s) Implémentation des animations

- test des directions – GDScript
- déclarations de variables avec **onready** – GDScript
- récupérer un nœud enfant la fonction **get\_node()** - GDScript
- **AnimatedSprite** – play() - jouer une animation – GDScript
- **AnimatedSprite** – stop() - arrêter une animation – GDScript
- **AnimatedSprite** – setFrame() - afficher une frame spécifique – GDScript
- utiliser **match** à la place de **if** – GDScript
- limiter la taille d’un  **Vector2** avec normalized() – GDScript


## **Partie 4: Les Data Structures et animation d'attaque**
[0:34](https://www.youtube.com/watch?v=8nupwbj1Heo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=4&t=34s) Les Structures de données

- type de donnée **Array** – GDScript
- type de donnée **Dictionary** (clé – valeur) – GDScript

[](https://www.youtube.com/watch?v=8nupwbj1Heo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=4&t=364s)

[6:04](https://www.youtube.com/watch?v=8nupwbj1Heo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=4&t=364s) Amélioration du code grâce aux data structures

- fonction \_find\_dir\_name
- rechercher dans l’aide – Interface
- **Dictionary –** values() - récupérer les valeurs du dictionnaire **–** GDScript
- **Array** – find() - Rechercher une valeur dans un array – GDScript
- **AnimatedSprite** – has\_animation() - Test si l’animation existe – GDScript
- Supprimer le warning The function returns a value, but this value is never used – GDScript

[15:35](https://www.youtube.com/watch?v=8nupwbj1Heo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=4&t=935s) Animation d'attaque

- la fonction **is\_action\_just\_pressed()** - éviter l’appuie d’une touche en continue – GDScript

[22:26](https://www.youtube.com/watch?v=8nupwbj1Heo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=4&t=1346s) Votre premier debug

- Ajouter un breakpoint – Interface
- Le debogueur – la valeur des variables – Interface

[25:30](https://www.youtube.com/watch?v=8nupwbj1Heo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=4&t=1530s) moving\_direction != facing\_direction

- Typer une variable par affectation **:=** – GDScript

[27:40](https://www.youtube.com/watch?v=8nupwbj1Heo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=4&t=1660s) Votre premier signal

- **Signal** - Les signaux d’un nœud – Interface
- **Signal** – Connecter un signal – Interface
- **AnimatedSprite** – signal animation\_finished() – GDScript
- **AnimatedSprite** – get\_animation() - retourne l’animation en cours – GDScript

[30:30](https://www.youtube.com/watch?v=8nupwbj1Heo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=4&t=1830s) Read the fu\*\*ing manual

- String – is\_subsequence\_of() - cherche une sous-chaîne dans une chaîne de caractères – GDScript


## **Partie 5: StateMachine et accesseurs**
[1:50](https://www.youtube.com/watch?v=TJEj6WPOq34&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=5&t=110s) Les Enumérations

- type de donnée **enum** – GDScript

[3:07](https://www.youtube.com/watch?v=TJEj6WPOq34&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=5&t=187s) State Machine

- utiliser enum – GDScript
- design pattern StateMachine – GDScript

[6:59](https://www.youtube.com/watch?v=TJEj6WPOq34&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=5&t=419s) Les accesseurs

- **setget** – les setter et les getter – GDScript

[9:12](https://www.youtube.com/watch?v=TJEj6WPOq34&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=5&t=552s) Déclarer un signal

- **Signal** – déclarer un signal custom dans le code – GDScript
- **Signal** – **emit\_signal** – émettre un signal custom – GDScript
- **Signal** – signal custom dans l’interface – Interface

[14:13](https://www.youtube.com/watch?v=TJEj6WPOq34&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=5&t=853s) \_update\_animation()

- Création des animations idle

[18:40](https://www.youtube.com/watch?v=TJEj6WPOq34&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=5&t=1120s) Le problème des diagonales

## **Partie 6: Attaque et interactions**
[0:14](https://www.youtube.com/watch?v=oekRKCktSdo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=6&t=14s) HitBox d'attaque & rotation

- **Area2d** – Noeud
- **Area2d** – Ajouter une collision shape– Interface
- Vector2 – **angle()** - GDScript
- méthode **set\_rotation()** - GDScript
- méthode **set\_rotation\_degrees()** - GDScript
- méthode **rad2deg()** et **deg2rad()** - GDScript
- **AnimatedSprite** – signal **frame\_changed** – GDScript
- **AnimatedSprite** – get\_frame() - retourne le numéro de la frame de l’animation en cours – GDScript

[5:41](https://www.youtube.com/watch?v=oekRKCktSdo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=6&t=341s) Déclenchement de l'effet d'attaque

- **Area2d** - get\_overlapping\_areas() – GDScript
- **Area2d** - get\_overlapping\_bodies()  – GDScript
- **Array** – parcourir un array avec une boucle for – GDScript
- méthode **has\_method()** - savoir la méthode est définie par l’objet – GDScript
- méthode **destroy()** - supprimer un objet et le libérer de la mémoire– GDScript

[10:17](https://www.youtube.com/watch?v=oekRKCktSdo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=6&t=617s) Pots destructibles

- créer une nouvelle scène - Interface
- **StaticBody2d** – Noeud
- récupérer un nœud enfant avec **$** plutôt que **get\_node()** - GDScript
- **CollisionShape2D** – méthode set\_disabled() - désactive la collision shape  – GDScript

[16:58](https://www.youtube.com/watch?v=oekRKCktSdo&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=6&t=1018s) Coffres

- Préfixer une méthode privée avec \_ - GDScript

## **Partie 7: Camera & Collectables**
[0:48](https://www.youtube.com/watch?v=kKP71d9tmcI&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=7&t=48s) Taille de l'ecran

- Taille de la fenêtre (Paramètres du projet - Display - window) **Width** – **Height** – Interface
- Configuration de la fenêtre (Paramètres du projet - Display - window) Borderless – Fullscreen - Mode 2D – Aspect keep\_width– Interface

[2:26](https://www.youtube.com/watch?v=kKP71d9tmcI&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=7&t=146s) Camera

- **Camera2D** – Noeud
- **Camera2D** – **current** définir la caméra active- Interface
- **Camera2D** – **Drag Margin** la caméra bouge moins– Interface
- **Camera2D** – **Draw Drag Margin** – Interface
- **Camera2D** – **Smoothing** – la caméra bouge plus gentillement – Interface

[4:40](https://www.youtube.com/watch?v=kKP71d9tmcI&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=7&t=280s) YSort

- **YSort** – Afficher le personnage dessus/dessous en fonction de sa position en Y - Noeud


[6:25](https://www.youtube.com/watch?v=kKP71d9tmcI&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=7&t=385s) Collectables: Pieces

- gestion d’un ombre
- **AnimatedSprite** – **Modulate** – modifier la couleur - ajouter de la transparence – Interface
- fonction **\_physics\_process()** indépendante de la vitesse de la machine – GDScript
- méthode **get\_position()** - position d’un objet 2D – GDScript
- méthode **move\_toward()** - déplacer vers – GDScript
- méthode **distance\_to()** - déplacer vers – GDScript
- **Particles2D** – Noeud
- **Particles2D** – ParticlesMaterial – Interface
- **Particles2D** – Velocity – Amount -  Initial vélocity – Direction – Gravity – Emission Shape -Color Ramp – One Shot – Emitting – Interface
- **Particles2D** – set\_emitting() - Lancer les particules – GDScript
- **AudioStreamPlayer2D** – Noeud
- **AudioStreamPlayer2D** – Stream – Ajouter un son – Interface
- **AudioStreamPlayer2D** – Importer sans loop – Interface
- **AudioStreamPlayer2D** – play() - jouer le son – GDScript
- **AnimatedSprite** – set\_visible() - Afficher / Cacher – GDScript
- fonction **yield()** - attente d’un signal – GDScript
- fonction **queue\_free()** - supprimer le nœud et le libérer de la mémoire – GDScript
- **Timer** – Noeud
- **Timer** – Wait time - Autostart– Interface
- **Timer** – Signal timeout() – Interface
- **AnimationPlayer** – Faire varier une propriété des nœud dans la temps– Noeud
- **AnimationPlayer** – Piste de propriété – Interface
- **AnimationPlayer** – Changer l’interpolation – Interface
- **AnimationPlayer** – méthode play() - lancer l’animation – GDScript
- **AnimationPlayer** – méthode stop() - stopper l’animation – GDScript
- Stopper le flickering (Paramètres du projet - Display – Use Gpu Pixel Snap) – Interface

## **Partie 8: HUD, Autoload & Events Bus**
[1:12](https://www.youtube.com/watch?v=37sHqWunsKc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=8&t=72s) Preview du résultat

[1:33](https://www.youtube.com/watch?v=37sHqWunsKc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=8&t=93s) CanvasLayer

- **TextureRect** – Afficher une image dans une interface utilisateur – Noeud
- **TextureRect** – Ajout d’une texture – Interface
- **CanvasLayer** – Noeud

[3:16](https://www.youtube.com/watch?v=37sHqWunsKc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=8&t=196s) HUD

- **Control –** Noeud
- **Control –** Disposition sur l’écran **–** Positionner un control **–** Interface
- **Control –** Disposition sur l’écran **–** rectangle complet **–** Interface
- **TextureRect** – Noeud
- **TextureRect** – Ajout d’une texture – Interface
- **TextureRect** – Déplacer la texture – Interface
- **Light2D** – Noeud
- **Light2D –** Mode mask** – Interface
- **Light2D –** Ajout d’une texture** – Interface
- **Light2D –** Déplacer avec Transform - Position** – Interface
- Faire un calcul dans les propriétés** – Interface
- **Light2D –** Range – Régler les layers** – Interface
- **Light2D –** Les Mask** – Interface
- Gestion des masks – Interface

[13:12](https://www.youtube.com/watch?v=37sHqWunsKc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=8&t=792s) Label & Font

- **Label** – Noeud
- **Label –** Gestion des polices de caractères (font) – Interface
- **Label –** Antialiasing des fonts– Interface
- **Label –** Gestion du contours – outline size** – Interface

[16:00](https://www.youtube.com/watch?v=37sHqWunsKc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=8&t=960s) Quelques notions d’architecture

[17:42](https://www.youtube.com/watch?v=37sHqWunsKc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=8&t=1062s) Autoload (Singleton)

- design pattern Singleton – GDScript
- création du script Singleton – GDScript
- charger le script au démarrage (Autoload) – GDScript

[22:08](https://www.youtube.com/watch?v=37sHqWunsKc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=8&t=1328s) Events Bus

- design pattern Event Bus - Gérer les évènements d’une scène à l’autre – GDScript
- **Signal** – déclarer un signal custom dans un autoload – GDScript
- **Signal** – connecter un signal qui est dans l’autoload – GDScript
- **Signal** – méthode **connect()** - connecter un signal en GDScript – GDScript
- # warnings-disable - Désactiver les warning sur un script – GDScript
- Convertir un int en String (cast) – GDScript

## **Partie 9: Spawn de collectables**
[0:27](https://www.youtube.com/watch?v=ckMzmfnXXtc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=9&t=27s) Simple Factory

- design pattern Simple Factory – GDScript
- fonction **preload()** - chargement d’une scène dans une ressource – GDScript
- méthode **instance()** - instancier une scène – GDScript
- objet owner – nœud racine de la scène – GDScript
- méthode add\_child() - ajouter l’instance à un nœud – GDScript

[13:28](https://www.youtube.com/watch?v=ckMzmfnXXtc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=9&t=808s) Animation de Spawn

- fonction **rand\_range()** tirer un numéro aléatoirement – GDScript
- **Vector2 :** fonction **length()** - longueur d’un vecteur– GDScript
- **Vector2 :** fonction **clamped()** limiter la longueur d’un vecteur– GDScript
- ctrl + shift + O – Ouvrir une scène rapidement – Interface
- alt + shift + O – Ouvrir un script rapidement – Interface
- **Timer** – One Shot – Interface

[32:38](https://www.youtube.com/watch?v=ckMzmfnXXtc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=9&t=1958s) Aléatoire

- fonction **randomize()** initialiser l’aléatoire – GDScript

[34:19](https://www.youtube.com/watch?v=ckMzmfnXXtc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=9&t=2059s) Un peu de debug

- **class\_name** – définir un type d’objet – GDScript

[36:16](https://www.youtube.com/watch?v=ckMzmfnXXtc&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=9&t=2176s) Autocollect

## **Partie 10: Ennemi, Héritage & scènes héritées**
[0:50](https://www.youtube.com/watch?v=XP-1spKkZ_g&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=10&t=50s) Héritage (De class)

- **class\_name** – l’héritage – GDScript
- **extends** – l’héritage – GDScript
- Création d’une class avec un script – GDScript

[13:28](https://www.youtube.com/watch?v=XP-1spKkZ_g&list=PLeeK5VJQ55mOsZpct-OtUB2TIgNnGjHZq&index=10&t=808s) Héritage de scènes

- function override avec **.** – Surcharge de méthoodes, appel de la méthode du parent – GDScript
- **Fusionner depuis la scène** – récupérer les nœud (Copier / Coller) d’une autre scène – Interface
- **Fichier – Nouvelle scène héritée…** - Créer une nouvelle scène héritée d’une scène existante – Interface
- **AnimatedSprite** – Enregistrer une ressource SpriteFrames – Fichier **.tres** – Interface
- Enregistrer une ressource sous Godot – Fichier **.tres** – Interface
- Charger une ressource sous Godot – Fichier **.tres** – Interface
- **Instancier une scène enfant** – Interface

## **Partie 11: implementation avancée des StatesMachines**
[1:43](https://www.youtube.com/watch?v=0jDSSzYXv74&t=103s) StateMachine a partir de nodes

- type de donnée **Object** – GDScript
- fonction **get\_node\_or\_null()** - GDScript
- design pattern State – GDScript

[18:58](https://www.youtube.com/watch?v=0jDSSzYXv74&t=1138s) La class State

- class abstraite - GDScript

[20:07](https://www.youtube.com/watch?v=0jDSSzYXv74&t=1207s) enter\_state() & exit\_state()

[21:43](https://www.youtube.com/watch?v=0jDSSzYXv74&t=1303s) update()

[23:07](https://www.youtube.com/watch?v=0jDSSzYXv74&t=1387s) Refacto de Actor avec la nouvelle implementation

- Ajouter un nœud custom – Interface
- fonction **get\_child()** - Récupérer un nœud enfant en fonction de sa position – GDScript

## **Partie 12: Comportement des ennemis & BehaviourTree**
[1:24](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=84s) Behaviour Tree

- design pattern Behaviour Tree – GDScript

[3:43](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=223s) Area de détection

[5:36](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=336s) Code de détection du joueur

- Signal – body\_entered – Détection d’un de collision – Interface
- Signal – body\_exited – Détection d’un de collision – Interface

[14:36](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=876s) StateLabel

[19:00](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=1140s) Déclenchement des Behaviour States

[21:08](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=1268s) Chase

- **Array** – empty() - Teste si l’array est vide– GDScript
- global\_position – position locale – position globale– GDScript
- **Vector2** - **direction\_to**() – cherche la direction vers une position – GDScript
- **Vector2** - **distance\_to**() – cherche la distance vers une position – GDScript
- **move\_and\_collide()** - GDScript
- **Array** – remove() - Enlever un élément de l’array – GDScript

[36:08](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=2168s) export var

- **export** – exposer une variable dans l’interface – GDScript

[37:19](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=2239s) Placeholder pour Wander

[37:56](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=2276s) Attack

[41:02](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=2462s) Flickering & facing\_direction

[45:36](https://www.youtube.com/watch?v=4lyGVF3zsOQ&t=2736s) Interruption de l'attaque

- **Timer** – start() – GDScript
- **Timer** – is\_stopped() – GDScript
- **Timer** – is\_paused() – GDScript

## **Partie 13: BehaviourTree, FSM imbriquées et fonction récursives**
[1:10](https://www.youtube.com/watch?v=Op9E8CXSPTA&t=70s) StateMachine imbriquée

- design pattern State – GDScript

[11:47](https://www.youtube.com/watch?v=Op9E8CXSPTA&t=707s) WaitState

- **export** – exposer une variable dans l’interface – GDScript

[18:40](https://www.youtube.com/watch?v=Op9E8CXSPTA&t=1120s) GoToState

[31:27](https://www.youtube.com/watch?v=Op9E8CXSPTA&t=1887s) StateLabel & fonctions récursives

- **is\_class()** - test si un objet est d’une certaine class – GDScript

## **Partie 14: Pathfinding & A\***
[1:00](https://www.youtube.com/watch?v=kjveugvr9cM&t=60s) Pathfinder.gd

- class **AStar2d** – Gdscript
- **Vector2** – type **PoolVector2Array** – Array de Vector2 – GDScript

[8:53](https://www.youtube.com/watch?v=kjveugvr9cM&t=533s) Création des points du A\*

- **Tilemap** - get\_used\_cells() - Retourne la liste des points utilisés – GDScript
- **Tilemap** - get\_cellv – Retourne l’id du tile utilisé  – GDScript
- **Tilemap** - Tileset – tile\_get\_name() – Retourne le nom du tile utilisé  – GDScript
- abs() - retourne la valeur absolue d’une valeur – Gdscript
- **AStar2d** – add\_point() – Gdscript

[22:07](https://www.youtube.com/watch?v=kjveugvr9cM&t=1327s) Connexion des points adjacents

- **AStar2d** – has\_point() – Gdscript
- **continue** – passer à la prochaine itération d’une boucle – Gdscript

[30:25](https://www.youtube.com/watch?v=kjveugvr9cM&t=1825s) find\_path()

[35:48](https://www.youtube.com/watch?v=kjveugvr9cM&t=2148s) Dependancy injection & groupes

[42:34](https://www.youtube.com/watch?v=kjveugvr9cM&t=2554s) update\_move\_path()

[44:30](https://www.youtube.com/watch?v=kjveugvr9cM&t=2670s) Un peu de bugfix

[53:18](https://www.youtube.com/watch?v=kjveugvr9cM&t=3198s) Les obstacles

[1:03:20](https://www.youtube.com/watch?v=kjveugvr9cM&t=3800s) Diagonales

[1:06:20](https://www.youtube.com/watch?v=kjveugvr9cM&t=3980s) Trouver une destination valide
