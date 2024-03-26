#!/bin/bash

lock_dir="/tmp/message_lock"

# Créer le répertoire de verrouillage s'il n'existe pas
if [ ! -d "$lock_dir" ]; then
    mkdir "$lock_dir"
fi

# Demander à l'utilisateur de saisir un message à afficher périodiquement
echo -n "Message à afficher périodiquement: "
read -r message

# Fonction pour écrire un message périodiquement sur la sortie standard
emit_message() {
    while true; do
        # Acquérir le verrou
        (
            flock 200 || exit 1
            # Test d'atomicité
            # atomic_test "Emission"
            echo "$message" 
        ) 200>"$lock_dir/lockfile"
        
        sleep 5  # Émission toutes les 5 secondes
    done
}

# Fonction pour réceptionner une chaîne de caractères sur l'entrée standard
receive_message() {
    while true; do
    read -r input
        # Acquérir le verrou
        (
            flock 200 || exit 1
            # Test d'atomicité
            # atomic_test "Réception"
            if [ -n "$input" ]; then
                if [ -z "$DISPLAY" ] || ! command -v zenity > /dev/null; then
                    # Si pas d'interface graphique, afficher sur la sortie erreur standard
                    >&2 echo "Réception de $input"
                else
                    # Si une interface graphique est disponible, afficher dans une boîte de dialogue par exemple
                    zenity --info --text="Réception de $input" --timeout=5
                fi
            fi
        ) 200>"$lock_dir/lockfile"
        sleep 5  # Émission toutes les 5 secondes, à titre d'exemple
    done
}

# Fonction pour tester l'atomicité des actions
atomic_test() {
    local action="$1"
    local counter=0
    while [ $counter -lt 10 ]; do
        # Ajouter un délai artificiel pour simuler une action atomique
        >&2 echo -n "."
        sleep 1
        ((counter++))
    done
    >&2 echo "$action terminée."
}

# Lancer la fonction d'émission en arrière-plan
emit_message &

# Lancer la fonction de réception en premier plan
receive_message
