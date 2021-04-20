% FPR CVICENI 4 - PROLOG - UVOD

% ukazka predikatu pro vypocet funkce faktorial
factorial( 0, 1 ).
factorial( N, Value ) :-
     N > 0,
     Prev is N - 1,
     factorial( Prev, Prevfact ),
     Value is Prevfact * N.

% databaze rodinnych vztahu
muz(jan).
muz(pavel).
muz(robert).
muz(tomas).
muz(petr).

zena(marie).
zena(jana).
zena(linda).
zena(eva).

otec(tomas,jan).
otec(jan,robert).
otec(jan,jana).
otec(pavel,linda).
otec(pavel,eva).

matka(marie,robert).
matka(linda,jana).
matka(eva,petr).

% Implementujte nasledujici predikaty:

rodic(X,Y) :- matka(X,Y); otec(X,Y).
sestra(X,Y) :- zena(Y), rodic(R,X), rodic(R,Y), X \= Y.
sourozenec(X,Y) :- rodic(R,X), rodic(R,Y), X \= Y.
deda(X,Y) :- otec(X,T), rodic(T,Y).
% je_matka(X) :- ...
% teta(X,Y) :- ...



% Seznamy:
neprazdny([_|_]) :- true.
hlavicka([H|_], H).
posledni([H], H) :- !.
posledni([_|T], Res) :- posledni(T, Res).


% Dalsi ukoly:

spoj([], L, L).
spoj([H|T], L, [H|TT]) :- spoj(T, L, TT).

/* Ukazka spojeni
?- spoj([1,2], [1,2,3], X).
X = [1, 2, 1, 2, 3].
*/
/* Ukazka vypsani prvku posledniho
?- spoj([1,2], X, [1,2,3]).
X = [3].
*/


obrat([],[]).
obrat([H|T], Res) :- obrat(T,TT), spoj(TT,[H], Res).

/* obrati seznam
?- obrat([1,2,3],X).
X = [3, 2, 1].
*/

sluc(L, [], L).
sluc([], L, L).
sluc([X|XS] ,[Y|YS] , [X|T]) :- X @< Y, sluc(XS, [Y|YS], T).
sluc([X|XS] ,[Y|YS] , [Y|T]) :- X @>= Y, sluc([X|XS], YS, T).

/* Slouci dva serazene seznami do jedno serazenoho
?- sluc([1,2,5], [1,2,3], X).
X = [1, 1, 2, 2, 3, 5] .
*/

serad([], []).
serad([H|T], SL) :- serad(T,ST), sluc([H], ST, SL).

/* Seradi neserazeny seznam
?- serad([1,2,5,1,8,2], X).
X = [1, 1, 2, 2, 5, 8] .
*/

% to G dela to ze vezme X Y  a secte do Z

plus(X,Y,Z) :- Z is X + Y.

zipWith(P, [X|XS],[Y|YS],[Z|ZS]) :- G =.. [P,X,Y,Z], call(G), zipWith(P, XS, YS, ZS).
