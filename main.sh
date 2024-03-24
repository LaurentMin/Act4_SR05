#!/bin/bash

# Fonction pour écrire le message périodiquement sur la sortie standard
write_message() {
    while true; do
        echo "Message périodique ici"
        for i in {1..10}; do
            echo "Attente $i"
            sleep 5
        done
        sleep 10 # Modifier ici la fréquence d'émission du message
    done
}

# Fonction pour recevoir une chaîne de caractères sur l'entrée standard
receive_message() {
    while read -r line; do
        echo "Réception de $line" >&2
    done
}

# Lancement de la fonction d'écriture en arrière-plan
write_message &

# Lancement de la fonction de réception
receive_message

# Fin du programme
