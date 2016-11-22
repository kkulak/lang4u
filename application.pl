:- dynamic(xpositive/2,xnegative/2).

language(python) :- 
	is(entertaining),
	is(easy),
	positive(control,automatic).
	
language(java) :-
	is(money),
	is(medium),
	positive(control,automatic),
	positive(development,erp),
	positive(development,mobile).
	
language(python) :- 
	is(entertaining),
	is(easy).
	
language(python) :- 
	is(entertaining).
	
language(python) :- 
	is(easy).
	
is(money) :-
	positive(income,high).

is(entertaining) :-
	positive(entertainment, high).

is(medium) :-
	positive(difficulty, medium).
	
positive(X,Y) :- xpositive(X,Y), !.

positive(X,Y) :- \+xnegative(X,Y), ask(X,Y,tak).

negative(X,Y) :- xnegative(X,Y), !.

negative(X,Y) :- \+xpositive(X,Y), ask(X,Y,nie).

ask(X,Y,tak) :- !, format('is ~w ~w important for you? (t/n)~n',[Y,X]),
                    read(Reply),
                    (Reply = 't'),
                    remember(X,Y,tak).
                    
ask(X,Y,nie) :- !, format('is ~w ~w important for you? (t/n)~n',[Y,X]),
                    read(Reply),
                    (Reply = 'n'),
                    remember(X,Y,nie).
                    
remember(X,Y,tak) :- assertz(xpositive(X,Y)).

remember(X,Y,nie) :- assertz(xnegative(X,Y)).

clear :- write('Przycisnij cos aby wyjsc'), nl,
                    retractall(xpositive(_,_)),
                    retractall(xnegative(_,_)).
					
main :- language(X), !, format('Suggested language: ~w', X), nl, clear.

main :- write('No language matched your answers.'), nl, clear.
