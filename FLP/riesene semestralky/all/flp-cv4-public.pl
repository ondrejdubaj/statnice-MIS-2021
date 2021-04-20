:- dynamic robot/2, dira/1.

subbags([], [[]]).
subbags([X|XS], P) :- subbags(XS, A), addOneToAll(X, A, B), append(A, B, P).
%priklad: subbags([1,2,3],X).
% pro vypocet mnoziny vsech pozmnozin
% pro dalsi vypocet aby se mi zobrazil zmacknu "w"

addOneToAll(_, [], []).
addOneToAll(E, [L|LS], [[E|L]|T]) :- addOneToAll(E, LS, T).
%priklad: addOneToAll(1,[[2,3],[5,6]],X). 
% kdy k 1 navazeme dve moznoziny potencni


% SVET robotu
%-------------
% I = index, P = pozice


obsazeno(P) :- robot(_,P); dira(P).
% ; je nebo
% , je a zaroven
% nebo druha varianta je kdyz udelam:
%% obsazeno(P) :- robot(_,P).
%% obsazeno(P) :- dira(P). 

vytvor(I, P) :- not(obsazeno(P)), assert(robot(I,P)).
% kontrola jesli jde o unikatnost Idecka I
vytvor(P) :- not(obsazeno(P)), assert(dira(P)).

odstran(P) :- retract(robot(_,P)); retract(dira(P)).

obsazene_pozice(X) :- bagof(A,obsazeno(A),X).
obsazene_roboty(X) :- bagof(P,I^robot(I,P),X).
% I^ podle tohle to nedeli nebo nedela

inkrementuj(X,Y) :- Y is X+1.
dekrementuj(X,Y) :- Y is X-1.
doleva(I) :- pohni(I, dekrementuj).
doprava(I) :- pohni(I, inkrementuj).


% jestli je dira tak zdechne
% jestli je na pozici robot tak ze zabijou
% jestli je volna pozice tak se robot posune

% Pnext = P dalsi pozice
% call dynamicke zavolani
% Operace = doleva(I) nebo doprava(I)

% postup:
% podivam se do databaze kde jsem
% a kam se chci pohnout na tu dalsi pozici
% kdyz se pozne tak ho odstranim protoze se pohybuji na dalsi pozici na puvodni zmizi
% IF je obsazena Pnext, tak (IF tam je robot tak ho odstranim, ELSE vratim true kdyz je dira)
% ELSE ho tam vlozim znovu

pohni(I, Operace) :- robot(I,P), retract(robot(I,P)), call(Operace, P, Pnext),
                      (obsazeno(Pnext) -> 
                              (robot(_,Pnext) -> odstran(Pnext); true)
                      ;
                              assert(robot(I,Pnext))
                      ).

%armageddon :- forall(robot(_,P), vybuch(P)).
%vybuch(P) :- odstran(P), vytvor(P).

% nebo
armageddon :- forall(retract(robot(_,P)), assert(dira(P))).


% Problem 4 dam
%-------------

% is dela matematickou operaci
sequence(0, []) :- !.
sequence(N, [N|T]) :- Nn is N-1, sequence(Nn, T).
%priklad: sequence(8,X).


queens(Solution) :- queens(8, Solution).
queens(N, Solution) :- sequence(N, List), permutation(List, Solution), test(Solution).

% Pos = pozice, Dist = vzdalenost

test([]) :- !.
test([H|T]) :- test(H, 1, T), test(T).
test(_,_,[]) :- !.
test(Pos, Dist, [H|T]) :-  Pos \= H, X is abs(Pos-H), X \= Dist, Dn is Dist+1, test(Pos, Dn, T).
%priklad: queens(4,X).


