% Aristas del Grafo
% Con la forma (Punto de salida, Punto de llegada)
arco(tresRios, sanJose,8).
arco(tresRios,pacayas,15).
arco(sanJose,corralillo,22).
arco(sanJose,cartago,20).
arco(corralillo,musgoVerde,6).
arco(corralillo,sanJose, 22).
arco(musgoVerde,corralillo,6).
arco(musgoVerde,cartago,10).
arco(cartago,musgoVerde,10).
arco(cartago,paraiso,10).
arco(cartago,sanJose,20).
arco(cartago,tresRios,8).
arco(cartago,pacayas,13).
arco(paraiso,cervantes,4).
arco(paraiso,orosi,8).
arco(paraiso,cachi,10).
arco(orosi,paraiso,8).
arco(orosi,cachi,12).
arco(cachi,paraiso,10).
arco(cachi, orosi, 12).
arco(cachi,cervantes,7).
arco(cachi,turrialba,40).
arco(cervantes,cachi,7).
arco(cerbantes,juanViñas,5).
arco(cervantes,pacayas,8).
arco(juanViñas,turrialba,4).
arco(turrialba,pacayas,18).
arco(turrialba,cachi,40).
arco(pacayas,cervantes,8).
arco(pacayas,cartago,13).
arco(pacayas,tresRios,15).
% Función encargada de añadir elementos a una lista.
% Forma: (lista inicial, elemento que se desea añadir, lista obtenida).
concatenar([],Lista,Lista).
concatenar([Head|Lista1],Lista2, [Head|Lista3]):-concatenar(Lista1,Lista2,Lista3).
%Función que toma el tiempo de viaje de la lista dada por el grafo
%Sintaxis horaTransito(Lista de lugares, km, tiempo, presa)
horaTransito([],Tiempo,Tiempo).
horaTransito([_|[Hora|_]],Tiempo):-horaTransito([],Tiempo,Hora).
% Función que toma el tiempo de viaje en presa de la lista dada por el
% grafo
% Sintaxis horaTransito(Lista de lugares, km, tiempo, presa)
horaPresa([],Hora,Hora).
horaPresa([_|[Hora|_]],Presa):-horaPresa([],Presa,Presa1), Presa1 is Hora*2.
% Función que toma el kilometraje de cada Dijkstra.
% Sintaxis kilometraje(Lista con la ruta más cercana, Km)
kilometraje([],Km,Km).
kilometraje([_|[Km|_]],Result):- kilometraje([],Result,Km).
% Función que suma el tiempo normal en carretera por cada Dijkstra
% sintaxis sumarTiempo(Lista de rutas Dijkstra, Suma del tiempo).
sumarTiempo([],0).
sumarTiempo([Head|Tail],Suma):-horaTransito(Head,Tiempo), sumarTiempo(Tail,Result), Suma is Result + Tiempo.
% Función que suma el tiempo en presa en carretera por cada Dijkstra
% sintaxis sumarPresa(Lista de rutas Dijkstra, Suma del tiempo).
sumarPresa([],0).
sumarPresa([Head|Tail],Suma):-horaPresa(Head,Tiempo), sumarPresa(Tail,Result), Suma is Result + Tiempo.

% Función que toma cada lugar obtenido por el Dijkstra y lo transforma
% en una lista
% Sintaxis ordenarLugares(resultado del dijkstra, Lista de lugares).
ordenarLugares([],Lista,Lista).
ordenarLugares([[Head|_]|Tail],Lugares,Lista):-concatenar(Lista,Head,Total),ordenarLugares(Tail,Lugares,Total).
ordenarLugares(Dijkstra,Lugares):-ordenarLugares(Dijkstra, Lugares,[]).

%Función que suma el kilometraje de cada Dijkstra
% Sintaxis sumaKm(resultado de los dijkstra, Kilometraje total de la
% ruta)
sumaKm([],0).
sumaKm([Head|Tail],Total):-kilometraje(Head,Km), sumaKm(Tail, Suma),Total is Suma + Km.

% Función encargada de acomodar los elementos del dijkstra, realizar las
% sumas de los tiempos y kilometros
% Sintaxis acomodar(Resultado del Dijkstra, Lista ordenada).
acomodar([],Ruta,Ruta).
acomodar(Dijkstra,Resultado):-ordenarLugares(Dijkstra,Lugares),sumaKm(Dijkstra,Km),sumarTiempo(Dijkstra, Tiempo),sumarPresa(Dijkstra,Presa),
    acomodar([],Resultado, [Lugares,Km, Tiempo,Presa]).
% dijkstra(Vertex0, Ss) is true if Ss is a list of structures s(Vertex, Dist,
%   Path) containing the shortest Path from Vertex0 to Vertex, the distance of
%   the path being Dist.  The graph is defined by e/3.
% e.g. dijkstra(penzance, Ss)
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
%e.g. path(penzance, london, Path, Dist)
path(Vertex0, Vertex, Path, Dist):-
  dijkstra(Vertex0, Ss),
  member(s(Vertex,Dist,Path), Ss), !.

% funcion la cual llama a path para poder obtener una lista que contiene
% el camino que se debe seguir para llegar a un punto de inicio a uno
% final y el kilometraje total
% eg. camino(cartago, cachi,X).
camino(Inicio,Fin,Respuesta):-path(Inicio,Fin,Path,Dist),Respuesta=[Path,Dist].

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
e(X, Y, Z):-arco(Y, X, Z).


