:-module(logica,[inversa/2,mejorRuta/2]).
:-use_module(bdyg).

/*
Descripción: Función encargada de añadir elementos a una lista.
Sintaxis:(lista inicial, elemento que se desea añadir, lista
obtenida).
Autor:Sebastián Moya
*/
concatenar([],Lista,Lista).
concatenar([Head|Lista1],Lista2, [Head|Lista3]):-concatenar(Lista1,Lista2,Lista3).
/*
Descripción: Función que retorna la inversa de una lista
Sintaxis: (Lista, inversa de la lista).
Autor:Sebastián Moya*/
inversa(Lista1,Lista2):-inversa(Lista1,Lista2,[]).
inversa([],Lista,Lista).
inversa([Head|Tail],Lista2,Nueva):- inversa(Tail, Lista2, [Head|Nueva]).

/*
Descripción: Función que toma el tiempo de viaje de la lista dada por el grafo
Sintaxis horaTransito(Lista de lugares, km, tiempo, presa)
*/
horaTransito([],Tiempo,Tiempo).
horaTransito([_|[Hora|_]],Tiempo):-horaTransito([],Tiempo,Hora).
/*
Descirpción: Función que toma el tiempo de viaje en presa de la lista
dada por el grafo.
Sintaxis: horaTransito(Lista de lugares, km, tiempo,
presa)
Autor:Sebastián Moya
*/
horaPresa([],Hora,Hora).
horaPresa([_|[Hora|_]],Presa):-horaPresa([],Presa,Presa1), Presa1 is Hora*2.
/*
Descripción: Función que toma el kilometraje de cada Dijkstra.
Sintaxis kilometraje(Lista con la ruta más cercana, Km)
Autor:Sebastián Moya
*/
kilometraje([],Km,Km).
kilometraje([_|[Km|_]],Result):- kilometraje([],Result,Km).
/*
Descripción: Función que suma el tiempo normal en carretera por cada
Dijkstra
Sintaxis: sumarTiempo(Lista de rutas Dijkstra, Suma del tiempo).
Autor:Sebastián Moya
*/
sumarTiempo([],0).
sumarTiempo([Head|Tail],Suma):-horaTransito(Head,Tiempo), sumarTiempo(Tail,Result), Suma is Result + Tiempo.
/*
Descripción: Función que suma el tiempo en presa en carretera por cada
Dijkstra
sintaxis: sumarPresa(Lista de rutas Dijkstra, Suma del tiempo).
Autor:Sebastián Moya
*/
sumarPresa([],0).
sumarPresa([Head|Tail],Suma):-horaPresa(Head,Tiempo), sumarPresa(Tail,Result), Suma is Result + Tiempo.

/*
Descripción: Función que toma cada lugar obtenido por el Dijkstra y lo
transforma en una lista
Sintaxis ordenarLugares(resultado del dijkstra, Lista de lugares).
Autor:Sebastián Moya
*/
ordenarLugares([],Lista,Lista).
ordenarLugares([[Head|_]|Tail],Lugares,Lista):-concatenar(Lista,Head,Total),ordenarLugares(Tail,Lugares,Total).
ordenarLugares(Dijkstra,Lugares):-ordenarLugares(Dijkstra, Lugares,[]).
/*
Descripción: Función que suma el kilometraje de cada Dijkstra
Sintaxis: sumaKm(resultado de los dijkstra, Kilometraje total de la
ruta)
Autor:Sebastián Moya
*/
sumaKm([],0).
sumaKm([Head|Tail],Total):-kilometraje(Head,Km), sumaKm(Tail, Suma),Total is Suma + Km.
/*
Descripción: Función encargada de acomodar los elementos del dijkstra,
realizar las sumas de los tiempos y kilometros.
Sintaxis: acomodar(Resultado del Dijkstra, Lista ordenada).
Autor:Sebastián Moya
*/
acomodar([],Ruta,Ruta).
acomodar(Dijkstra,Resultado):-ordenarLugares(Dijkstra,Lugares),sumaKm(Dijkstra,Km),sumarTiempo(Dijkstra, Tiempo),sumarPresa(Dijkstra,Presa),
    acomodar([],Resultado, [Lugares,Km, Tiempo,Presa]).
/*
Descripción: Función que elimina el primer elemento de la lista de
lugares del dijkstra
Sintaxis quitar(Dijkstra,Dijkstra sin el primer lugar)
Autor:Sebastián Moya
*/
quitar([],Lista,Lista).
quitar([[_|Tail1]|Tail],Lista2):-quitar([],Lista2,[Tail1|Tail]).
/*
Descripción: Función que calcula el dijkstra por secciones, segun una
lista de lugares
Sintaxis(Lista de lugares en orden,lista con el Dijkstra para cada par
de ciudades).
Autor:Sebastián Moya
*/
calcularRuta([_|[]],Resultado,Resultado,false).
calcularRuta([Head|[Elem|Tail]],Resultado,Resultado1,false):- camino(Head,Elem,Dijkstra1),
  quitar(Dijkstra1,Dijkstra),
  calcularRuta([Elem|Tail],Resultado,[Dijkstra|Resultado1],false).
calcularRuta([Head|[Elem|Tail]],Resultado,Resultado1):- camino(Head,Elem,Dijkstra),
  calcularRuta([Elem|Tail],Resultado,[Dijkstra|Resultado1],false).
calcularRuta(Lugares,Resultado):-calcularRuta(Lugares,Resultado,[]).
/*
Descripción: Función que toma una lista de lugares y calcula mejor
ruta para trnasitar, junto con su tiempo, km, y tiempo en presas
sintaxis: (Lista de lugares ordenados, lista con cuatro elementos:
(lista de los lugares por visitar,km,tiempo total,tiempo en presa))
Autor:Sebastián Moya
*/

mejorRuta([],Ruta,Ruta).
mejorRuta(Lugares,Ruta):-calcularRuta(Lugares,Dijkstra1),
  inversa(Dijkstra1,Dijkstra),
  acomodar(Dijkstra,Resultado),
  mejorRuta([],Ruta,Resultado).


% ======================Algoritmo de Dijkstra=========================
% Este algoritmo fue basado en el código de Colin Barker de la pagina
%http://colin.barker.pagesperso-orange.fr/lpa/dijkstra.htm

% funcion la cual llama a path para poder obtener una lista que contiene
% el camino que se debe seguir para llegar a un punto de inicio a uno
% final y el kilometraje total
% Forma: camino(cartago, cachi,X).
camino(Inicio,Fin,Respuesta):-path(Inicio,Fin,Path,Dist),Respuesta=[Path,Dist].


%dijkstra(Vertex0, Ss) is true if Ss
% is a list of structures s(Vertex, Dist, Path) containing the shortest
% Path from Vertex0 to Vertex, the distance of the path being Dist. The
% graph is defined by e/3. e.g. dijkstra(penzance, Ss)
dijkstra(Vertex, Ss):-
  create(Vertex, [Vertex], Ds),
  dijkstra_1(Ds, [s(Vertex,0,[])], Ss).

dijkstra_1([], Ss, Ss).
dijkstra_1([D|Ds], Ss0, Ss):-
  best(Ds, D, S),
  delete([D|Ds], [S], Ds1),
  S=s(Vertex,Distance,Path),
  reverse([Vertex|Path], Path1),
  merge(Ss0, [s(Vertex,Distance,Path1)], Ss1),
  create(Vertex, [Vertex|Path], Ds2),
  delete(Ds2, Ss1, Ds3),
  incr(Ds3, Distance, Ds4),
  merge(Ds1, Ds4, Ds5),
  dijkstra_1(Ds5, Ss1, Ss).

% Funcion inicial del dijkstra la cual con el lugar inicial y el final
% retorna la distancia y los puntos por los que se debe de pasar
% Forma: path(penzance, london, Path, Dist)
path(Vertex0, Vertex, Path, Dist):-
  dijkstra(Vertex0, Ss),
  member(s(Vertex,Dist,Path), Ss), !.



% create(Start, Path, Edges) is true if Edges is a list of structures s(Vertex,
%   Distance, Path) containing, for each Vertex accessible from Start, the
%   Distance from the Vertex and the specified Path.  The list is sorted by the
%   name of the Vertex.
create(Start, Path, Edges):-
  setof(s(Vertex,Edge,Path), e(Start,Vertex,Edge), Edges), !.
create(_, _, []).

% best(Edges, Edge0, Edge) is true if Edge is the element of Edges, a list of
%   structures s(Vertex, Distance, Path), having the smallest Distance.  Edge0
%   constitutes an upper bound.
best([], Best, Best).
best([Edge|Edges], Best0, Best):-
  shorter(Edge, Best0), !,
  best(Edges, Edge, Best).
best([_|Edges], Best0, Best):-
  best(Edges, Best0, Best).

shorter(s(_,X,_), s(_,Y,_)):-X < Y.

% delete(Xs, Ys, Zs) is true if Xs, Ys and Zs are lists of structures s(Vertex,
%   Distance, Path) ordered by Vertex, and Zs is the result of deleting from Xs
%   those elements having the same Vertex as elements in Ys.
delete([], _, []).
delete([X|Xs], [], [X|Xs]):-!.
delete([X|Xs], [Y|Ys], Ds):-
  eq(X, Y), !,
  delete(Xs, Ys, Ds).
delete([X|Xs], [Y|Ys], [X|Ds]):-
  lt(X, Y), !, delete(Xs, [Y|Ys], Ds).
delete([X|Xs], [_|Ys], Ds):-
  delete([X|Xs], Ys, Ds).

% merge(Xs, Ys, Zs) is true if Zs is the result of merging Xs and Ys, where Xs,
%   Ys and Zs are lists of structures s(Vertex, Distance, Path), and are
%   ordered by Vertex.  If an element in Xs has the same Vertex as an element
%   in Ys, the element with the shorter Distance will be in Zs.
merge([], Ys, Ys).
merge([X|Xs], [], [X|Xs]):-!.
merge([X|Xs], [Y|Ys], [X|Zs]):-
  eq(X, Y), shorter(X, Y), !,
  merge(Xs, Ys, Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]):-
  eq(X, Y), !,
  merge(Xs, Ys, Zs).
merge([X|Xs], [Y|Ys], [X|Zs]):-
  lt(X, Y), !,
  merge(Xs, [Y|Ys], Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]):-
  merge([X|Xs], Ys, Zs).

eq(s(X,_,_), s(X,_,_)).

lt(s(X,_,_), s(Y,_,_)):-X @< Y.

% incr(Xs, Incr, Ys) is true if Xs and Ys are lists of structures s(Vertex,
%   Distance, Path), the only difference being that the value of Distance in Ys
%   is Incr more than that in Xs.
incr([], _, []).
incr([s(V,D1,P)|Xs], Incr, [s(V,D2,P)|Ys]):-
  D2 is D1 + Incr,
  incr(Xs, Incr, Ys).


% funcion que revisa si el punto X y el punto Y estan en el arco y
% obtiene la distancia Z del arco
% e.g e(tres rios, san jose, X). retornaria la distancia entre tres rios
% y san jose
e(X, Y, Z):-arco(X, Y, Z).


