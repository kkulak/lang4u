import pexpect
import re


def _parse_description(raw_text):
    return ProgramDescription(raw_text)


def _parse_question(raw_text):
    lines = re.split('\n', raw_text)
    question_text = lines[0]
    answers = [PossibleAnswer(single_question[0], single_question[1])
               for single_question in [x.split(' ', 1) for x in lines[1:]]]
    return Question(question_text, answers)


def _parse_chosen_language(raw_text):
    return ChosenLanguage(raw_text)


def _unixified(text):
    return text.replace('\r\n', '\n')


class Lang4UClient:
    def __init__(self):
        self.prolog_shell = pexpect.spawn('swipl application.pl')
        self.timeout = 1

    def start_quiz(self):
        self.prolog_shell.sendline('main.')
        self.prolog_shell.expect('\?- main.\r\n')

    def get_description(self):
        self.prolog_shell.expect('\n\s*\n')
        return _parse_description(_unixified(self.prolog_shell.before))

    def answer_last_question(self, answer):
        answer_to_send = str(answer) + '.'
        self.prolog_shell.sendline(answer_to_send)
        self.prolog_shell.readline()

    def try_get_next_question(self):
        try:
            return self._get_next_question()
        except Exception:
            raise InvalidStateError()

    def _get_next_question(self):
        self.prolog_shell.expect('\r\n\|:', self.timeout)
        return _parse_question(_unixified(self.prolog_shell.before))

    def try_get_answer(self):
        try:
            return self._get_answer()
        except Exception:
            raise InvalidStateError()

    def _get_answer(self):
        self.prolog_shell.expect('\r\n\x1b[^m]*mtrue.', self.timeout)
        return _parse_chosen_language(self.prolog_shell.before)

    def terminate(self):
        self.prolog_shell.close()


class ProgramDescription:
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return self.value

    def serialize(self):
        return {'value': self.value}


class Question:
    def __init__(self, question_text, possible_answers):
        self.question_text, self.possible_answers = question_text, possible_answers

    def __str__(self):
        return 'Q: ' + self.question_text + '\nA: ' + [a.__str__() for a in self.possible_answers].__str__()

    def serialize(self):
        return {
            'text': self.question_text,
            'answers': [answer.serialize() for answer in self.possible_answers]
        }


class PossibleAnswer:
    def __init__(self, ordinal, text):
        self.ordinal, self.text = ordinal, text

    def __str__(self):
        return self.ordinal + ': ' + self.text

    def serialize(self):
        return {
            'ordinal': self.ordinal,
            'text': self.text
        }


class ChosenLanguage:
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return self.value

    def serialize(self):
        return {'value': self.value}


class InvalidStateError(Exception):
    pass
