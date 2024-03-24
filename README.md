Travail de programmation
Le but de cette activité est de faire le lien entre l'écriture des algorithmes et leur programmation.

Travail demandé : réaliser un programme dans le langage de votre choix tel que :

Le programme écrit un message périodiquement sur la sortie standard.
Le message est simplement une chaîne de caractères.
Si le programme inclut une interface graphique, le message pourrait être modifiable en cours d'exécution. Sinon son contenu peut être fixé au lancement du programme.
Il n'y a pas d'autres affichages sur la sortie standard. Utiliser la sortie erreur standard pour tout autre affichage.
Le programme est capable de réceptionner une chaîne de caractères sur son entrée standard.
Si le programme inclut une interface graphique, alors celle-ci pourrait l'afficher.
Sinon le message reçu peut être affiché sur la sortie erreur standard, par exemple sous la forme "réception de xxx".
Propriétés :
Le programme est séquentiel (une seule action à la fois).
Les actions d'émission et de réception sont atomiques (une fois commencées, elles ne sont pas interrompues).
Dans la mesure du possible, la réception est asynchrone : le programme ne vérifie pas périodiquement son entrée ; il lit l'entrée standard lorsqu'il y a quelque chose à lire.
Vérification (cf. TD) :
Pour vérifier les communications, construire un réseau simple avec le shell :
Un lien entre deux sites : ./prog | ./prog
Un anneau : mkfifo /tmp/f ; ./prog < /tmp/f | ./prog | ./prog > /tmp/f
NB : d'autres exemples de réseaux en shell seront développés dans le tutoriel Airplug, dans le cadre du projet de programmation.
Pour vérifier l'atomicité, ajouter une boucle dans les actions de réception ou d'émission afin d'augmenter artificiellement leur durée :
répéter un grand nombre de fois
écrire sur stderr "."
attendre 10 secondes
