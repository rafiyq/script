import json
from os.path import join, dirname
from ibm_watson import SpeechToTextV1
from ibm_watson.websocket import RecognizeCallback, AudioSource
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator

apiKey = 'QW83BoRhgsyCZP642USpLHniFqah95JQ2GHzo81DHN6X'
url = 'https://api.au-syd.speech-to-text.watson.cloud.ibm.com/instances/1edcc5fe-3dc4-4a51-a65e-cedc3ea0248a'

authenticator = IAMAuthenticator(apiKey)
speech_to_text = SpeechToTextV1(
    authenticator=authenticator
)

speech_to_text.set_service_url(url)

speech_to_text.set_default_headers({'x-watson-learning-opt-out': "true"})


class MyRecognizeCallback(RecognizeCallback):
    def __init__(self):
        RecognizeCallback.__init__(self)

    def on_data(self, data):
        print(json.dumps(data, indent=2))
        with open('output.txt', 'w') as file_output:
            file_output.write(json.dumps(data, indent=2))

    def on_error(self, error):
        print('Error received: {}'.format(error))

    def on_inactivity_timeout(self, error):
        print('Inactivity timeout: {}'.format(error))


myRecognizeCallback = MyRecognizeCallback()

with open(join(dirname(__file__), '/home/rafiyq/Downloads/', 'mimk-084-1stHalf.mp3'), 'rb') as audio_file:
    audio_source = AudioSource(audio_file)
    speech_to_text.recognize_using_websocket(
        audio=audio_source,
        content_type='audio/mp3',
        recognize_callback=myRecognizeCallback,
        model='ja-JP_BroadbandModel',
        # keywords=['colorado', 'tornado', 'tornadoes'],
        # keywords_threshold=0.5,
        # timestamps=True
        speaker_labels=True
        # inactivity_timeout=31
        # max_alternatives=3
    )
