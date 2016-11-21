% hypothesis
language(python) :-
  why(entertainment),
  learning_preference(easy),
  control(automatic).

language(java) :-
  why(money),
  learning_preference(hard),
  (which_platform(erp); which_platform(mobile)),
  control(automatic).

language(cpp) :-
  which_platform(gaming),
  (why(experience);why(money)),
  learning_preference(hard).

language(c) :-
  why(experience),
  which_platform(embedded),
  learning_preference(hardest),
  control(manual).

language(objc) :-
  why(money),
  which_platform(mobile),
  learning_preference(hard).
  
/*
language(js) :-
language(php) :-
  
language(ruby) :-
*/

language(csharp) :- 
  why(money),
  learning_preference(easy).
  
language(fallback).
 
question(why) :-
  write('Dlaczego chcesz nauczyc sie programowac?'), nl.
  
question(learning_preference) :-
  write('Jakich rzeczy wolisz sie uczyc?'), nl.
  
question(control) :-
  write('Wolisz pelna manualna kontrole czy czesciowa automatyzacje?'), nl.

question(which_platform) :-
  write('Wybierz swoja ulubiona platforme'), nl.

control(Answer) :- 
  knowledge_base(control, Answer).
control(Answer) :-
  \+ knowledge_base(control, _),
  ask(control, Answer, [manual, automatic]).
  
learning_preference(Answer) :-
  knowledge_base(learning_preference, Answer).
learning_preference(Answer) :-
  \+ knowledge_base(learning_preference, _),
  ask(learning_preference, Answer, [easy, hard, hardest]).  

which_platform(Answer) :-
  knowledge_base(which_platform, Answer).
which_platform(Answer) :-
  \+ knowledge_base(which_platform, _),
  ask(which_platform, Answer, [erp, gaming, embedded, mobile]).

why(Answer) :-
  knowledge_base(why, Answer).
why(Answer) :-
  \+ knowledge_base(why, _),
  ask(why, Answer, [entertainment, money, experience]).
  
answer(manual) :-
  write('manualna').
  
answer(automatic) :-
  write('automatyzacje').

answer(easy) :-
  write('latwych').

answer(hard) :-
  write('trudnych').
  
answer(erp) :-
  write('Systemy biznesowe klasy ERP').

answer(gaming) :-
  write('Gry komputerowe').

answer(embedded) :-
  write('Systemy wbudowane - Arduino, RaspberryPi, etc.').

answer(mobile) :-
  write('Oprogramowanie przeznaczone dla telefonów komórkowych').

answer(hardest) :-
  write('bardzo trudnych').
  
answer(entertainment) :-
  write('Rozrywka').

answer(money) :-
  write('Wzgledy zarobkowe').
  
answer(experience) :-
  write('Rozwoj osobisty').

stdout_manual :-
  write('Witamy!'), nl,
  write('Program \'Wybierz swoj pierwszy jezyk\' pomoze dobrac Ci swoj pierwszy jezyk programowania'), nl,
  write('Wystarczy, ze udzielisz odpowiedzi na ponizsze pytania'), nl,
  write('Wybierz jedna opcje, nastepnie zakoncz interpretacje kropka.'), nl, nl.

%descriptions
describe(python) :-
  write('Python').

describe(java) :-
  write('Java').
  
describe(c) :- 
  write('C').
  
describe(cpp) :- 
  write('C++').
  
describe(objc) :- 
  write('objective-C').
  
describe(php) :- 
  write('PHP').

describe(ruby) :- 
  write('Ruby').
  
describe(csharp) :- 
  write('C#').
  
describe(js) :- 
  write('JavaScript').

describe(fallback) :- 
  write('Zaden jezyk nie pasuje do Twoich odpowiedzi. Moze sprobujesz z Pythonem?').
  
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
  stdout_manual,
  clear_facts,
  match_language(Language),
  describe(Language), nl.
