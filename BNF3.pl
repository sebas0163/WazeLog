:- module(oracion, [oracion/2]).
/*
 Descripcion: Predicado que verifica la estructura de la oracion segun
 la base de datos que se define.Retorna true si la estructura cumple con
 lo establecido.
oracion(Lista con las palabras de la oracion,[])
*/
oracion(S0,S):-sintagma_nominal(S0,S).
oracion(S0,S):-sintagma_preposicional(S0,S).
oracion(S0,S):-sintagma_verbal(S0,S).
oracion(S0,S):- pronombre(S0,S1),sintagma_verbal(S1,S).
oracion(S0,S):- verbo(S0,S1),sintagma_verbal(S1,S).
oracion(S0,S):- verbo(S0,S1),sintagma_verbal(S1,S2),sintagma_preposicional(S2,S).
oracion(S0,S):- verbo(S0,S1),conjuncion(S1,S2),sintagma_verbal(S2,S).
oracion(S0,S):- verbo(S0,S1),conjuncion(S1,S2),sintagma_verbal(S2,S3),sintagma_preposicional(S3,S).
oracion(S0,S):- pronombre(S0,S1),verbo(S1,S2),sintagma_verbal(S2,S).
oracion(S0,S):- pronombre(S0,S1),verbo(S1,S2),sintagma_verbal(S2,S3),sintagma_preposicional(S3,S).
/**/
sintagma_nominal(S0,S):- ciudad(S0,S).
sintagma_nominal(S0,S):- determinante(Tipo,S0,S1),lugar(Tipo,S1,S).
sintagma_nominal(S0,S):- determinante(Tipo,S0,S1),nombre(Tipo,S1,S).
/**/
sintagma_verbal(S0,S):- verbo(S0,S).
sintagma_verbal(S0,S):- verbo(S0,S1),sintagma_nominal(S1,S).
sintagma_verbal(S0,S):- verbo(S0,S1),sintagma_preposicional(S1,S).
/**/
sintagma_preposicional(S0,S):-enlace(S0,S1),sintagma_nominal(S1,S).
%-------------------Base de datos para BNF------------------
determinante(masculino,[el|S],S).
determinante(femenino,[la|S],S).
determinante(masculino,[al|S],S).
determinante(singular,[mi|S],S).
determinante(masculino,[un|S],S).
determinante(femenino,[una|S],S).

%-----------Nombres------------------
pronombre([yo|S],S).
pronombre([me|S],S).
pronombre([se|S],S).

nombre(singular,[ubicacion|S],S).
nombre(singular,[posicion|S],S).
nombre(singular,[localizacion|S],S).

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
ciudad([juanVi�as|S],S).
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
verbo([esta|S],S).
verbo([voy|S],S).
verbo([encuentro|S],S).
verbo([encuentra|S],S).
verbo([dirijo|S],S).
verbo([ubica|S],S).
verbo([queda|S],S).
verbo([es|S],S).
verbo([gustaria|S],S).
verbo([quisiera|S],S).
verbo([quiero|S],S).
verbo([necesito|S],S).
verbo([ocupo|S],S).
verbo([dirijo|S],S).
verbo([ir|S],S).
verbo([pasar|S],S).
verbo([tengo|S],S).
verbo([desplazo|S],S).
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

conjuncion([que|S],S).

%oracion([yo,estoy,en,cartago],[]).
%oracion(S,[]).
