element(X,[X|_],1).
element(X,[_|Q],Rang):- element(X,Q,N),
						Rang is N+1.
element(T,[T|Q]).
element(T,[Y|Q]):-element(T,Q).

append([], Y, Y).
append([X1|X2], Y, [X1|L]):- append(X2, Y, L).

%afficher une grille
changerligne([]):-nl,write('------------------------'),nl.
afficher([]).
afficher([X1,X2,X3|R]) :-afficher2(X1),nl,afficher2(X2),nl,afficher2(X3),changerligne([]),afficher(R).
afficher2([]).
afficher2([A1,A2,A3|B]) :- tab(1), write(A1), tab(1), write(A2), tab(1), write(A3), tab(1), write('|'), afficher2(B).

/*resoudreligne([],[]).
resoudreligne([T|Q],[T1|Q1]):- number(T), >(T,0), <(T,10), T1 is T, resoudreligne(Q,Q1).
resoudreligne([T|Q],[T1|Q1]):- \+number(T), member(T1,[1,2,3,4,5,6,7,8,9]),resoudreligne(Q,Q1).
resoudreligne2(X,Y):-resoudreligne(X,Y), verifierligne(Y).
%ex resoudreligne2([1,2,3,_,5,6,7,_,9],X).
resoudrelignes([],[]).
resoudrelignes([T|Q],[T1|Q1]):-resoudreligne2(T,T1),resoudrelignes(Q,Q1).

verifiercols([T1,T2,T3,T4,T5,T6,T7,T8,T9]):-groupcol(T1,T2,T3,T4,T5,T6,T7,T8,T9).
groupcol([],[],[],[],[],[],[],[],[]).
groupcol([T1|Q1],[T2|Q2],[T3|Q3],[T4|Q4],[T5|Q5],[T6|Q6],[T7|Q7],[T8|Q8],[T9|Q9]):-R=[T1,T2,T3,T4,T5,T6,T7,T8,T9]
,verifierligne(R),groupcol(Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9).

different([]).
different([H|T]):-
				\+element(H,T),
				different(T).

verifierlignes([]).
verifierlignes([T|Q]):-verifierligne(T),verifierlignes(Q).

verifierligne([]).
verifierligne([T|Q]):- \+element(T,Q), verifierligne(Q).*/

verifier9x9([T|Q]):-length([T|Q],9),verifier9([T|Q]).
verifier9([]).
verifier9([T|Q]):-length(T,9),verifier9(Q).

%valider une grille qui n'est meme pas tout remplit
valid([]).
valid([Head|Tail]):-
    fd_all_different(Head),
    %different(Head),
    valid(Tail).

%
ajouter(_,[],_).
ajouter(Tous,[H|T],List):-
    member(H,List),
    valid(Tous),
    ajouter(Tous,T,List).

resolution(Grille):-
				resoudreSudoku(Grille),
				afficher(Grille),
				write('M:menu principal'),nl,
				read(Menu),
				Menu = M,
				startSudoku.

%remplacer un element dans la liste
remp2(0,P,[T|Q],X,R,N4):-
	remp(P,T,X,R,[T,Q],[],N4).
remp2(P1,P,[T|Q],X,R,N4):-
	P1>0,P11 is P1-1,
	append(R,[T],N),
	remp2(P11,P,Q,X,N,N4).
remp(0,[T|Q],X,R,[T1,Q1],R2,N4):-
	append(R2,[X],N),
	append(N,Q,N2),
	append(R,[N2],N3),
	append(N3,Q1,N4).
remp(P,[T|Q],X,R,[T1,Q1],R2,N4):-
	P>0,
	P2 is P-1,
	append(R2,[T],N),
	remp(P2,Q,X,R,[T1,Q1],N,N4).

resoudreSudoku(Grille):-
				verifier9x9(Grille),
				Grille2 = [T11,T12,T13,T14,T15,T16,T17,T18,T19,						
						T21,T22,T23,T24,T25,T26,T27,T28,T29,
						T31,T32,T33,T34,T35,T36,T37,T38,T39,
						T41,T42,T43,T44,T45,T46,T47,T48,T49,
						T51,T52,T53,T54,T55,T56,T57,T58,T59,
						T61,T62,T63,T64,T65,T66,T67,T68,T69,
						T71,T72,T73,T74,T75,T76,T77,T78,T79,
						T81,T82,T83,T84,T85,T86,T87,T88,T89,
						T91,T92,T93,T94,T95,T96,T97,T98,T99], 
				Grille =[[T11,T12,T13,T14,T15,T16,T17,T18,T19],						
						[T21,T22,T23,T24,T25,T26,T27,T28,T29],
						[T31,T32,T33,T34,T35,T36,T37,T38,T39],
						[T41,T42,T43,T44,T45,T46,T47,T48,T49],
						[T51,T52,T53,T54,T55,T56,T57,T58,T59],
						[T61,T62,T63,T64,T65,T66,T67,T68,T69],
						[T71,T72,T73,T74,T75,T76,T77,T78,T79],
						[T81,T82,T83,T84,T85,T86,T87,T88,T89],
						[T91,T92,T93,T94,T95,T96,T97,T98,T99]], 		
						
						L1 = [T11,T12,T13,T14,T15,T16,T17,T18,T19],
						L2 = [T21,T22,T23,T24,T25,T26,T27,T28,T29],
						L3 = [T31,T32,T33,T34,T35,T36,T37,T38,T39],
						L4 = [T41,T42,T43,T44,T45,T46,T47,T48,T49],
						L5 = [T51,T52,T53,T54,T55,T56,T57,T58,T59],
						L6 = [T61,T62,T63,T64,T65,T66,T67,T68,T69],
						L7 = [T71,T72,T73,T74,T75,T76,T77,T78,T79],
						L8 = [T81,T82,T83,T84,T85,T86,T87,T88,T89],
						L9 = [T91,T92,T93,T94,T95,T96,T97,T98,T99],
						
						C1 = [T11,T21,T31,T41,T51,T61,T71,T81,T91],
						C2 = [T12,T22,T32,T42,T52,T62,T72,T82,T92],
						C3 = [T13,T23,T33,T43,T53,T63,T73,T83,T93],
						C4 = [T14,T24,T34,T44,T54,T64,T74,T84,T94],
						C5 = [T15,T25,T35,T45,T55,T65,T75,T85,T95],
						C6 = [T16,T26,T36,T46,T56,T66,T76,T86,T96],
						C7 = [T17,T27,T37,T47,T57,T67,T77,T87,T97],
						C8 = [T18,T28,T38,T48,T58,T68,T78,T88,T98],
						C9 = [T19,T29,T39,T49,T59,T69,T79,T89,T99],

						B1 = [T11,T12,T13,T21,T22,T23,T31,T32,T33],
						B2 = [T14,T15,T16,T24,T25,T26,T34,T35,T36],
						B3 = [T17,T18,T19,T27,T28,T29,T37,T38,T39],
						B4 = [T41,T42,T43,T51,T52,T53,T61,T62,T63],
						B5 = [T44,T45,T46,T54,T55,T56,T64,T65,T66],
						B6 = [T47,T48,T49,T57,T58,T59,T67,T68,T69],
						B7 = [T71,T72,T73,T81,T82,T83,T91,T92,T93],
						B8 = [T74,T75,T76,T84,T85,T86,T94,T95,T96],
						B9 = [T77,T78,T79,T87,T88,T89,T97,T98,T99],

						%valid([B1,B2,B3,B4,B5,B6,B7,B8,B9]),

						%valid([L1,L2,L3,L4,L5,L6,L7,L8,L9,C1,C2,C3,C4,C5,C6,C7,C8,C9,B1,B2,B3,B4,B5,B6,B7,B8,B9]).
						Tous = [L1,L2,L3,L4,L5,L6,L7,L8,L9,C1,C2,C3,C4,C5,C6,C7,C8,C9,B1,B2,B3,B4,B5,B6,B7,B8,B9],
						ajouter(Tous,Grille2,[1,2,3,4,5,6,7,8,9]).
						

trou(ListeChange,0):-afficher(ListeChange).
trou(ListeOrigine,Max):-
	random(0,9,M),
	random(0,9,N),
	%write(M),nl,
	%write(N),nl,
	remp2(M,N,ListeOrigine,'_',[],ListeChange),
	Max2 is Max -1,
	trou(ListeChange,Max2).
%ex remp2(2,1,[[1,2,3],[4,5,6],[7,8,9]],10,[]).
%ex remp2(5,4,[[_,6,_,5,9,3,_,_,_],[9,_,1,_,_,_,5,_,_],[_,3,_,4,_,_,_,9,_],[1,_,8,_,2,_,_,_,4],[4,_,_,3,_,9,_,_,1],[2,_,_,_,1,_,6,_,9],[_,8,_,_,_,6,_,2,_],[_,_,4,_,_,_,8,_,7],[_,_,_,7,8,5,_,1,_]],10,[]).
%generer une grille
generer(Dif):-
		random(1,10,A),
		random(1,10,B),
		random(1,10,C),
		random(1,10,D),
		random(1,10,E),
		random(1,10,F),
		random(1,10,G),
		random(1,10,H),
		random(1,10,I),
		ListeOrigine = [[A,_,_,_,_,_,_,_,_],[_,_,_,B,_,_,_,_,_],[_,_,_,_,_,_,C,_,_],[_,D,_,_,_,_,_,_,_],[_,_,_,_,E,_,_,_,_],[_,_,_,_,_,_,_,F,_],[_,_,G,_,_,_,_,_,_],[_,_,_,_,_,H,_,_,_],[_,_,_,_,_,_,_,_,I]],
		%afficher(ListeOrigine),
		resoudreSudoku(ListeOrigine),
		trou(ListeOrigine,Dif),
		write('S:la solution'),nl,
		%write('2:Veuillez jouer?'),nl,
		read(Choice2),
		Choice2 = S,
		afficher(ListeOrigine),
		write('M:Menu Principal'),nl,
		read(Choice3),
		Choice3 = M,
		startSudoku.
jouer(2,ListeChange,ListeOrigine):-play(ListeChange).
% Jeu
startSudoku:-
		nl,
		write('================================================================================='),nl,
		write('||Jeu de Sudoku ---fait par De Adam LANDEREETHE et Yi YOU, un projet pour IA02 ||'),nl,
		write('================================================================================='),nl,
		write('Choissisez:'),nl,
		write('1: Entrez une grille pour voir la solution'),nl,
		write('2: Jouez avec une grille généré par le programme'),nl,
		write('3: bye'),nl,
		read(Choice), Choice>0, Choice =<3,

		aller(Choice).

aller(1):-
		write('Entrez une grille avec sous-liste:'),nl,
		read(Grille),
		resolution(Grille).


aller(2):-
		write('Veuillez choisir la difficulté: '),nl,
		write('1: facile;'),nl,
		write('2: difficile;'),nl,
		write('3: enfer;'),nl,
		read(Diff), Diff >0, Diff =< 3,
		write('take that'),nl,
		start(Diff).

aller(3):-nl,
		write('==========='),nl,
		write('||Bye Bye||'),nl,
		write('===========').

start(1):-	generer(20).			
start(2):-  generer(35).
start(3):-  generer(60).

/*play(ListeChange):- afficher(ListeChange),
					write('quelle ligne:'),nl,
					read(Ligne),
					write('quelle colonne:'),nl,
					read(Colonne),
					write('quelle valeur:'),nl,
					read(Valeur),
					remp2(Ligne-1,Colonne-1,ListeOrigine,Valeur,[],ListeChange2),
					write('1: Continue'),nl,
					write('2: Solution'),nl,
					read(Choice4),
					Choice = 1,
					play(ListeChange2).*/











