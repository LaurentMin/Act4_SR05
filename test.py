import sys
import time
import threading

# Fonction pour écrire le message périodiquement sur la sortie standard
def write_message():
    while True:
        print("Message périodique ici")
        sys.stdout.flush()  # Forcer le vidage du tampon de sortie
        time.sleep(5)  # Modifier ici la fréquence d'émission du message

# Fonction pour recevoir une chaîne de caractères sur l'entrée standard
def receive_message():
    for line in sys.stdin:
        print("Réception de", line.strip())
        sys.stderr.flush()  # Forcer le vidage du tampon de sortie

# Lancer la fonction d'écriture dans un thread
write_thread = threading.Thread(target=write_message)
write_thread.daemon = True
write_thread.start()

# Lancer la fonction de réception dans le thread principal
receive_message()
