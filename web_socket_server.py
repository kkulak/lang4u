from lang4u_client import Lang4UClient, InvalidStateError

if __name__ == '__main__':
    client = Lang4UClient()
    client.start_quiz()
    client.get_description()
    client.try_get_next_question()
    client.answer_last_question(1)

    try:
        client.try_get_answer()
    except InvalidStateError:
        pass

    client.try_get_next_question()
    client.answer_last_question(0)
    client.try_get_next_question()
    client.answer_last_question(0)

    try:
        client.try_get_next_question()
        client.try_get_next_question()
    except InvalidStateError:
        pass

    print client.try_get_answer()
