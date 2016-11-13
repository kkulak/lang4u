% hypothesis
language(python) :-
  why(entertainment).

language(java) :-
  why(money).

question(why) :-
  write('Dlaczego chcesz nauczyc sie programowac?'), nl.

why(Answer) :-
  knowledge_base(why, Answer).
why(Answer) :-
  \+ knowledge_base(why, _),
  ask(why, Answer, [entertainment, money]).

answer(entertainment) :-
  write('Rozrywka').

answer(money) :-
  write('$$').

describe(python) :-
  write('Python').

describe(java) :-
  write('Java').

% utils
answers([], _).
answers([Head|Tail], Index) :-
  write(Index), write(' '), answer(Head), nl,
  NextIndex is Index + 1,
  answers(Tail, NextIndex).

parse(0, [Head|_], Head).
parse(Index, [_|Tail], Response) :-
  Index > 0,
  NextIndex is Index - 1,
  parse(NextIndex, Tail, Response).

ask(Question, Answer, Choices) :-
  question(Question),
  answers(Choices, 0),
  read(Index),
  parse(Index, Choices, Response),
  asserta(knowledge_base(Question, Response)),
  Response = Answer.

match_language(Language) :- 
  language(Language), !.

:- dynamic(knowledge_base/2).

clear_facts :-
  retractall(knowledge_base(_, _)).

% main
main :-
  clear_facts,
  match_language(Language),
  describe(Language), nl.