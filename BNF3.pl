:- module(oracion, [oracion/2]).
%-------Predicado que verifica la estructura de la oracion-----------
oracion(S0,S):-ciudad(S0,S).
oracion(S0,S):-sintagma_preposicional(S0,S).
oracion(S0,S):-sintagma_verbal(S0,S).
oracion(S0,S):- pronombre(S0,S1),sintagma_verbal(S1,S).
%-----------------Predicados para BNF------------------
sintagma_nominal(S0,S):- determinante(G?nero,S0,S1),lugar(G?nero,S1,S).
sintagma_nominal(S0,S):- ciudad(S0,S).
%sintagma_verbal(S0,S):- verbo(S0,S).
%sintagma_verbal(S0,S):- verbo(S0,S1),sintagma_nominal(S1,S).
sintagma_verbal(S0,S):- verbo(S0,S1),sintagma_preposicional(S1,S).
sintagma_preposicional(S0,S):-enlace(S0,S1),sintagma_nominal(S1,S).
%-------------------Base de datos para BNF------------------
determinante(masculino,[el|S],S).
determinante(femenino,[la|S],S).
determinante(masculino,[al|S],S).

%determinante(plural,[los|S],S).
%determinante(plural,[las|S],S).

%-----------Nombres------------------
pronombre([yo|S],S).
pronombre([me|S],S).

ciudad([heredia|S],S).
ciudad([guanacaste|S],S).

ciudad([sanJose|S],S).
ciudad([corralillo|S],S).
ciudad([tresRios|S],S).
ciudad([musgoVerde|S],S).
ciudad([cartago|S],S).
ciudad([pacayas|S],S).
ciudad([cervantes|S],S).
ciudad([paraiso|S],S).
ciudad([juanVi?as|S],S).
ciudad([turrialba|S],S).
ciudad([cachi|S],S).
ciudad([orosi|S],S).


lugar(masculino,[supermercado|S],S).
lugar(femenino,[tienda|S],S).
lugar(masculino,[restaurante|S],S).
lugar(masculino,[cine|S],S).
lugar(femenino,[pulperia|S],S).
lugar(masculino,[hospital|S],S).
lugar(femenino,[farmacia|S],S).
lugar(femenino,[clinica|S],S).
lugar(masculino,[gimnasio|S],S).
lugar(masculino,[parque|S],S).
lugar(femenino,[municipalidad|S],S).
lugar(masculino,[banco|S],S).
lugar(masculino,[mall|S],S).
lugar(femenino,[plaza|S],S).
lugar(masculino,[centro|S],S).
lugar(masculino,[comercial|S],S).
lugar(masculino,[registro|S],S).
lugar(femenino,[carniceria|S],S).
lugar(femenino,[verduleria|S],S).
lugar(masculino,[aeropuerto|S],S).
lugar(femenino,[piscina|S],S).
lugar(femenino,[ferreteria|S],S).
lugar(masculino,[automercado|S],S).
lugar(masculino,[cajero|S],S).

%-----------Verbos--------------------
verbo([estoy|S],S).
verbo([voy|S],S).
verbo([encuentro|S],S).
verbo([dirijo|S],S).
%-----------Enlaces--------------------
enlace([en|S],S).
enlace([para|S],S).
enlace([a|S],S).
enlace([de|S],S).
enlace([hacia|S],S).
enlace([hasta|S],S).
enlace([mediante|S],S).
enlace([por|S],S).
enlace([desde|S],S).



%oracion([yo,estoy,en,cartago],[]).
%oracion(S,[]).
