#!/bin/bash

# Fonction pour écrire un message périodiquement sur la sortie standard
emit_message() {
    local message="Message périodique"
    while true; do
        echo "$message"
        sleep 5  # Émission toutes les 5 secondes, à titre d'exemple
    done
}

# Fonction pour réceptionner une chaîne de caractères sur l'entrée standard
receive_message() {
    while true; do
        read -r input
        if [ -n "$input" ]; then
            if [ -z "$DISPLAY" ]; then
                # Si pas d'interface graphique, afficher sur la sortie erreur standard
                >&2 echo "Réception de $input"
            else
                # Si une interface graphique est disponible, afficher dans une boîte de dialogue par exemple
                zenity --info --text="Réception de $input"
            fi
        fi
    done
}

# Lancer la fonction d'émission en arrière-plan
emit_message &

# Lancer la fonction de réception en premier plan
receive_message
