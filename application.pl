% hypothesis
language(python) :-
  why(entertainment),
  is_(company_size, medium),
  (learning_preference(easy); learning_preference(skip)),
  is_(control,easy).
 
language(java) :-
  why(money),
  is_(company_size,big),
  (learning_preference(easy); learning_preference(hard)),
  (which_platform(erp); which_platform(mobile)),
  is_(control,easy).
 
language(cpp) :-
  (which_platform(gaming);which_platform(skip)),
  (why(experience);why(money)),
  learning_preference(hard).
 
language(c) :-
  why(experience),
  (which_platform(embedded);which_platform(skip)),
  learning_preference(hardest),
  is_(control, difficult).
 
language(objc) :-
  why(money),
  (which_platform(mobile);which_platform(skip)),
  learning_preference(hard).

language(js) :-
  why(money),
  is_(company_size, medium),
  which_platform(web).

language(matlab) :-
  why(education),
  math_background(strong_math_background),
  (which_platform(science);which_platform(skip)).

language(ruby) :-
  why(money),
  is_(company_size,small),
  (which_platform(erp); which_platform(web)).

language(csharp) :-
  why(money),
  learning_preference(easy).
 
language(fallback).

is_(control, easy) :-
  (control(automatic);control(skip)).
  
is_(control, difficult) :-
  control(manual).
  
is_(company_size, small) :-
  company_size(startup).
  
is_(company_size, medium):-
  (company_size(startup); company_size(middle_sized_company)).
  
is_(company_size, big) :-
  (company_size(middle_sized_company); company_size(big_corporation)).
 
question(why) :-
  write('Dlaczego chcesz nauczyc sie programowac?'), nl.
 
question(learning_preference) :-
  write('Jakich rzeczy wolisz sie uczyc?'), nl.
 
question(control) :-
  write('Wolisz pelna manualna kontrole czy czesciowa automatyzacje?'), nl.
 
question(which_platform) :-
  write('Wybierz swoja ulubiona dziedzine:'), nl.
 
question(company_size) :-
  write('Chcialbys pracowac w'), nl.

question(math_background) :-
  write('Czy posiadasz matematyczny background?'), nl.
 
control(Answer) :-
  knowledge_base(control, Answer).
control(Answer) :-
  \+ knowledge_base(control, _),
  ask(control, Answer, [manual, automatic, skip]).
 
learning_preference(Answer) :-
  knowledge_base(learning_preference, Answer).
learning_preference(Answer) :-
  \+ knowledge_base(learning_preference, _),
  ask(learning_preference, Answer, [easy, hard, hardest, skip]).  
 
which_platform(Answer) :-
  knowledge_base(which_platform, Answer).
which_platform(Answer) :-
  \+ knowledge_base(which_platform, _),
  ask(which_platform, Answer, [erp, web, gaming, embedded, mobile, science, skip]).
 
why(Answer) :-
  knowledge_base(why, Answer).
why(Answer) :-
  \+ knowledge_base(why, _),
  ask(why, Answer, [entertainment, money, experience, education, skip]).

math_background(Answer) :-
  knowledge_base(math_background, Answer).
math_background(Answer) :-
  \+ knowledge_base(math_background, _),
  ask(math_background, Answer, [strong_math_background, lack_of_math_background, skip]).

company_size(Answer) :-
  knowledge_base(company_size, Answer).
company_size(Answer) :-
  \+ knowledge_base(company_size, _),
  ask(company_size, Answer, [startup, middle_sized_company, big_corporation, skip]).  
 
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

answer(web) :- 
    write('Web').
 
answer(embedded) :-
  write('Systemy wbudowane - Arduino, RaspberryPi, etc.').
 
answer(mobile) :-
  write('Oprogramowanie przeznaczone dla telefonow komorkowych').
 
answer(science) :-
  write('Nauki scisle').

answer(hardest) :-
  write('bardzo trudnych').
 
answer(entertainment) :-
  write('Rozrywka').
 
answer(money) :-
  write('Wzgledy zarobkowe').
 
answer(experience) :-
  write('Rozwoj osobisty').

answer(education) :-
  write('Szkolnictwo').
 
answer(startup) :-
  write('Startupie').
 
answer(middle_sized_company) :-
  write('Sredniego rozmiaru firmie').
 
answer(big_corporation) :-
  write('Miedzynarodowej korporacji').

answer(strong_math_background) :-
  write('Tak, posiadam, i wiaze swoja przyszlosc z tym kierunkiem').
 
answer(lack_of_math_background) :-
  write('Nie posiadam, chcialbym mozliwie odizolowac sie od tej dziedziny').
  
answer(skip) :-
  write('Nie wiem/pomin').

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

describe(matlab) :-
  write('Matlab').
 
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
