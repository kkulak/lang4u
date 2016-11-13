% hypothesis
language(python) :-
  why(entertainment),
  learning_preference(easy),
  control(automatic).

language(java) :-
  why(money),
  learning_preference(hard),
  control(automatic).

language(cpp) :-
  (why(experience);why(money)), /* ; alternatywa, czyli cpp jesli dla rozwoju lub hajsow*/
  learning_preference(hard).

language(c) :-
  why(experience),
  learning_preference(hardest),
  control(manual).

language(objc) :-
  why(money),
  learning_preference(hard).
  
/*
language(js) :-


language(php) :-
  

language(ruby) :-
*/

language(csharp) :-	
  why(money),
  learning_preference(easy).
 
question(why) :-
  write('Dlaczego chcesz nauczyc sie programowac?'), nl.
  
question(learning_preference) :-
  write('Jakich rzeczy wolisz sie uczyc?'), nl.
  
question(control) :-
  write('Wolisz pelna manualna kontrole czy czesciowa automatyzacje?'), nl.

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
  
answer(hardest) :-
  write('bardzo trudnych').
  
answer(entertainment) :-
  write('Rozrywka').

answer(money) :-
  write('$$').
  
answer(experience) :-
  write('rozwoj').

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