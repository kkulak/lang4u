from flask import Flask, request
from flask_socketio import SocketIO, emit

from lang4u_client import Lang4UClient, InvalidStateError

PATH = '/lang4u'
app = Flask(__name__)
socketio = SocketIO(app)
clients = {}


@socketio.on('connect', namespace=PATH)
def connect_new_client():
    session_id = request.sid
    clients[session_id] = Lang4UClient()


@socketio.on('disconnect', namespace=PATH)
def disconnect_client():
    session_id = request.sid
    clients[session_id].terminate()
    del clients[session_id]


@socketio.on('start_quiz', namespace=PATH)
def start_quiz(message):
    session_id = request.sid
    client = clients[session_id]
    client.start_quiz()
    client.get_description()
    emit('question', {'data': client.try_get_next_question().serialize()})


@socketio.on('answer', namespace=PATH)
def answer(message):
    session_id = request.sid
    client = clients[session_id]
    client.answer_last_question(message['data'])
    try:
        chosen_language = client.try_get_answer()
        emit('answer', {'data': chosen_language.serialize()})
    except InvalidStateError:
        next_question = client.try_get_next_question()
        emit('question', {'data': next_question.serialize()})


if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0')
