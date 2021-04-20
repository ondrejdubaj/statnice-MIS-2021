:- dynamic velikost/2, pozice/2.


prvek(H, [H|_]) :- !.
prvek(H, [_|T]) :- prvek(H, T).


rozdil([], _, []).
%prvek H se nachazi v mozine S
rozdil([H|T], S, R) :- prvek(H,S), !, rozdil(T,S,R).
%pridavame ho do vysledku
rozdil([H|T], S, [H|P]) :- rozdil(T,S,P).

%POUZITI:
% rozdil([a,b,c,d], [c,d,e,f], R).

%-----------------------------------
%Pomocne predikaty: assert, retract, =.. , call, bagof, setof, var
%POPIS K = klic, V = hodnota (var), D = slovnik

%kontroly
slovnik(D, _, _) :- var(D), !, fail.
slovnik(_, K, V) :- var(K), var(V), !, fail.

%pouziti slozeny term a(..,..) =.. seznam [..,..]
%vyhledani hodnoty
slovnik(D, K, V) :- var(V), !, G =.. [D,K,V], call(G).
%vyhledani klicu (! kdyz se nechceme vracet kdyz je to volna promena a dal nas to nezajima)

%pro jeden klic
%slovnik(D, K, V) :- var(K), !, G =.. [D,K,V], call(G).

%pro vice klicu
%X pro pomocnou promenou
slovnik(D, K, V) :- var(K), !, G =.. [D,X,V], bagof(X, call(G), K).

%modifikace = musim overit volne promene ale vse je nahore
%pro zeptani do databaze =..
slovnik(D, K, V) :- dynamic(D/2), G =.. [D,K,_], call(G), !, retract(G), N =.. [D,K,V], assert(N). 
%nebo
%slovnik(D, K, V) :- dynamic(D/2), G =.. [D,K,_], retract(G), !, N =.. [D,K,V], assert(N). 

%vlozeni
slovnik(D, K, V) :-  N =.. [D,K,V], assert(N).


g_size(3).


g_test(X:Y) :- g_size(S), X > 0, X < S+1, Y > 0, Y < S+1.



g_move(X1:Y1, X2:Y2) :- X2 is X1 - 1, Y2 is Y1 - 1, g_test(X2:Y2).
g_move(X1:Y1, X2:Y2) :- X2 is X1 - 1, Y2 is Y1 + 0, g_test(X2:Y2).
g_move(X1:Y1, X2:Y2) :- X2 is X1 - 1, Y2 is Y1 + 1, g_test(X2:Y2).
g_move(X1:Y1, X2:Y2) :- X2 is X1 + 0, Y2 is Y1 - 1, g_test(X2:Y2).
g_move(X1:Y1, X2:Y2) :- X2 is X1 + 0, Y2 is Y1 + 1, g_test(X2:Y2).
g_move(X1:Y1, X2:Y2) :- X2 is X1 + 1, Y2 is Y1 - 1, g_test(X2:Y2).
g_move(X1:Y1, X2:Y2) :- X2 is X1 + 1, Y2 is Y1 + 0, g_test(X2:Y2).
g_move(X1:Y1, X2:Y2) :- X2 is X1 + 1, Y2 is Y1 + 1, g_test(X2:Y2).


% L a R jsou seznami, P je pomocny seznam, T je pomocny promena
%Vrati to od konce
%g_one(X:Y, L, R) :- P =.. [L,R], lenght(P,T), T >= 4, P = R.
%Vrati to od zacatku
%not je \+
g_one(X:Y, L, R) :- P =.. [L,R], lenght(P,T), T >= 4, reverse(P,R).
g_one(X:Y, L, R) :- g_move(X:Y, XN:YN), \+ memberchk(XN:YN, L), g_one(XN:YN, L, R). 



g_all(R) :- g_one(2:2, [], R)
g_all(R) :- g_move(2:2, X:Y), g_one(X:Y, [], R).

%kolik pocet gest celkem
g_num(N) :- bagof(R, g_all(R), B), lenght(B,N).


cesty(XR, YR, XS, YS, XE, YE, N) :-
  XR > 0, YR > 1,
  assert(velikost(XR, YR)),
  testPoz(XS, YS), testPoz(XE, YE),
  findall(C, cesta(XS, YS, XE, YE, C), B),
  lenght(B,N),
  retractall(poz(_,_)),
  retract(velikost(_,_)).


testPoz(X,Y) :- velikost(XR, YR), X > 0, Y > 0, X =< XR, Y =< YR.

testPoz(_,_). %dummy - comment it out!

skok(X,Y,XN,YN) :- XN is X + 2, YN is Y + 1, testPoz(XN, YN).
skok(X,Y,XN,YN) :- XN is X + 2, YN is Y - 1, testPoz(XN, YN).
skok(X,Y,XN,YN) :- XN is X - 2, YN is Y + 1, testPoz(XN, YN).
skok(X,Y,XN,YN) :- XN is X - 2, YN is Y - 1, testPoz(XN, YN).
skok(X,Y,XN,YN) :- XN is X + 1, YN is Y + 2, testPoz(XN, YN).
skok(X,Y,XN,YN) :- XN is X + 1, YN is Y - 2, testPoz(XN, YN).
skok(X,Y,XN,YN) :- XN is X - 1, YN is Y + 2, testPoz(XN, YN).
skok(X,Y,XN,YN) :- XN is X - 1, YN is Y - 2, testPoz(XN, YN).


cesta(X,Y,X,Y,[X:Y]).
cesta(X,Y,X,Y,[X:Y]) :- !, fail.
cesta(X,Y,XE,YE,[X:Y|T]) :- 
  skok(X,Y,XN,YN),
  \+ poz(XN, YN),
  assert(poz(X,Y)),
  cesta(XN,YN, XE, YE, T).

cesta(X, Y, XE, YE, _) :- retract(poz(X,Y)), !, fail.


