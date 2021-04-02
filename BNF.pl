:- module(oracion, [oracion/2]).

%---Predicado que verifica si la oracion esta bien escrita----
oracion(S0,S):-sintagma_nominal(S0,S).
oracion(S0,S):-sintagma_preposicional(S0,S).
oracion(S0,S):-sintagma_verbal(S0,S).
oracion(S0,S):- sintagma_nominal(S0,S1),sintagma_verbal(S1,S).
%-----------------Predicados para BNF------------------
%sintagma_nominal(S0,S):- determinante(Tipo,S0,S1),nombre(Tipo,S1,S).
sintagma_nominal(S0,S):- nombre(singular,S0,S).
sintagma_verbal(S0,S):- verbo(S0,S).
sintagma_verbal(S0,S):- verbo(S0,S1),sintagma_nominal(S1,S).
sintagma_verbal(S0,S):- verbo(S0,S1),sintagma_preposicional(S1,S).
sintagma_preposicional(S0,S):-enlace(S0,S1),sintagma_nominal(S1,S).
%-------------------Base de datos para BNF------------------
%determinante(singular,[el|S],S).
%determinante(singular,[la|S],S).
%determinante(plural,[los|S],S).
%determinante(plural,[las|S],S).

nombre(singular,[yo|S],S).
nombre(singular,[me|S],S).
nombre(singular,[cartago|S],S).
nombre(singular,[heredia|S],S).
nombre(singular,[guanacaste|S],S).
verbo([estoy|S],S).
verbo([voy|S],S).
verbo([encuentro|S],S).
verbo([dirijo|S],S).
enlace([en|S],S).
enlace([para|S],S).
%oracion([yo,estoy,en,cartago],[]).
%oracion(S,[]).

