import time
import os
import subprocess

# Tiempo de trabajo en minutos
job = 50
# Tiempo libre en minutos
free = 10
# Limite de pomodoros realizados (6 horas)
limit = 6

count = 0


def send(title, status):
    message = "Pomodoro"
    subprocess.run(
        [
            "notify-send",
            title,
            message,
            "-u",
            status,
            "-a",
            "Pomodoro",
            "-i",
            "~/.oh-my-zsh/custom/files/noti/pomodoro.ico",
        ]
    )


def pomo(minutes, status, message):
    send(message, status)

    if status == "critical":
        os.system(
            " echo ' Busy' > /tmp/pom.temp && play -v 0.3 ~/.oh-my-zsh/custom/files/noti/sound2.mp3; pkill play;"
        )

    else:
        os.system(
            " echo ' Free' > /tmp/pom.temp && play -v 0.3 ~/.oh-my-zsh/custom/files/noti/sound1.mp3; pkill play;"
        )

    time.sleep(minutes * 60)


if __name__ == "__main__":
    while count < limit:
        pomo(job, "critical", "Es hora de trabajar!!!")
        count += 1
        pomo(free, "normal", "Tomale un tiempo libre...")

    pomo(free, "Final 🤩 🤩 🤩", "Trabajo finalizado")
    os.system("play -v 0.3 ~/.oh-my-zsh/custom/files/noti/sound1.mp3; pkill play;")
