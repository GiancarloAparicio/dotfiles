#!/usr/bin/env python3

import speech_recognition as sr
import os
import pyperclip
from pydub import AudioSegment
from pydub.silence import split_on_silence

# pip3 install pyaudio pyperclip SpeechRecognition

r = sr.Recognizer()

# a function that splits the audio file into chunks
# and applies speech recognition
def get_large_audio_transcription(path):
    # open the audio file using pydub
    sound = AudioSegment.from_wav(path)
    # split audio sound where silence is 700 miliseconds or more and get chunks
    chunks = split_on_silence(
        sound,
        # experiment with this value for your target audio file
        min_silence_len=500,
        # adjust this per requirement
        silence_thresh=sound.dBFS - 14,
        # keep the silence for 1 second, adjustable as well
        keep_silence=500,
    )
    folder_name = "audio-chunks"
    # create a directory to store the audio chunks
    if not os.path.isdir(folder_name):
        os.mkdir(folder_name)
    whole_text = ""
    # process each chunk
    for i, audio_chunk in enumerate(chunks, start=1):
        # export audio chunk and save it in
        # the `folder_name` directory.
        chunk_filename = os.path.join(folder_name, f"chunk{i}.wav")
        audio_chunk.export(chunk_filename, format="wav")
        # recognize the chunk
        with sr.AudioFile(chunk_filename) as source:
            audio_listened = r.record(source)
            # try converting it to text
            try:
                text = r.recognize_google(audio_listened, language="es")
            except sr.UnknownValueError as e:
                print("Error:", str(e))
            else:
                text = f"{text.capitalize()}. "
                print(chunk_filename, ":", text)
                whole_text += text
    # return the text for all chunks detected
    return whole_text


def testSR():
    for index, name in enumerate(sr.Microphone.list_microphone_names()):
        print(
            'Microphone with name "{1}" found for `Microphone(device_index={0})`'.format(
                index, name
            )
        )


def talk(text):
    # get home directory
    home = os.path.expanduser("~")
    os.system(
        f'{home}/.local/bin/edge-tts --voice es-MX-DaliaNeural --text "{text}" | play -t mp3 -'
    )


def listen():
    listener = sr.Recognizer()
    with sr.Microphone() as source:
        talk("Te escucho...")
        listener.pause_treshold = 0.1
        listener.adjust_for_ambient_noise(source)
        pc = listener.listen(source)

    try:
        rec = listener.recognize_google(pc, language="es")
        rec = rec.lower()
        return rec.capitalize().strip()
    except sr.UnKnownValueError:
        print("No te entendi, repitelo")
    except sr.RequestError as e:
        print("Not resultados ", e)


text = listen()
os.system(f'echo "{text}" | xclip -selection c')
talk("Listo.")

# testSR()
