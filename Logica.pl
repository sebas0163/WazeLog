% Aristas del Grafo
% Con la forma (Punto de salida, Punto de llegada, km, tiempo sin presa,
% tiempo en presa)
arco(cartago,lima,3,8,15).
arco(cartago,taras,3,10,15).
arco(taras,tresRios, 8,25, 30).
arco(lima, tresRios, 9, 25, 20).
arco(tresRios, curridabat, 5, 10, 20).
arco(curridabat,sanPedro, 5, 10, 15).
arco(curridabat,zapote, 2, 5, 10).
arco(sanPedro,sanJose, 2, 10, 15).
arco(zapote, sanJose, 3, 15, 15).
% Funci�n que calcula si existe una ruta entre dos nodos.
% La forma es (nodo de salida, nodo de llegada).
ruta(X,Y):-arco(X,Y,_,_,_),write(X),write(Y).
ruta(X,Y):-arco(X,Z,_,_,_), ruta(Z,Y).
% Funci�n encargada de a�adir elementos a una lista.
% Forma: (lista inicial, elemento que se desea a�adir, lista obtenida).
concatenar([],Lista,Lista).
concatenar([Head|Lista1],Lista2, [Head|Lista3]):-concatenar(Lista1,Lista2,Lista3).
%Funci�n que toma el tiempo de viaje de la lista dada por el grafo
%Sintaxis horaTransito(Lista de lugares, km, tiempo, presa)
horaTransito([],Tiempo,Tiempo).
horaTransito([_|[_|[Hora|_]]],Tiempo):-horaTransito([],Tiempo,Hora).
% Funci�n que toma el tiempo de viaje en presa de la lista dada por el
% grafo
% Sintaxis horaTransito(Lista de lugares, km, tiempo, presa)
horaPresa([],Hora,Hora).
horaPresa([_|[_|[_|[Hora|_]]]],Presa):-horaPresa([],Presa,Hora).
% Funci�n que toma el kilometraje de cada Dijkstra.
% Sintaxis kilometraje(Lista con la ruta m�s cercana, Km)
kilometraje([],Km,Km).
kilometraje([_|[Km|_]],Result):- kilometraje([],Result,Km).
% Funci�n que suma el tiempo normal en carretera por cada Dijkstra
% sintaxis sumarTiempo(Lista de rutas Dijkstra, Suma del tiempo).
sumarTiempo([],0).
sumarTiempo([Head|Tail],Suma):-horaTransito(Head,Tiempo), sumarTiempo(Tail,Result), Suma is Result + Tiempo.
% Funci�n que suma el tiempo en presa en carretera por cada Dijkstra
% sintaxis sumarPresa(Lista de rutas Dijkstra, Suma del tiempo).
sumarPresa([],0).
sumarPresa([Head|Tail],Suma):-horaPresa(Head,Tiempo), sumarPresa(Tail,Result), Suma is Result + Tiempo.

% Funci�n que toma cada lugar obtenido por el Dijkstra y lo transforma
% en una lista
% Sintaxis ordenarLugares(resultado del dijkstra, Lista de lugares).
ordenarLugares([],Lista,Lista).
ordenarLugares([[Head|_]|Tail],Lugares,Lista):-concatenar(Lista,Head,Total),ordenarLugares(Tail,Lugares,Total).
ordenarLugares(Dijkstra,Lugares):-ordenarLugares(Dijkstra, Lugares,[]).

%Funci�n que suma el kilometraje de cada Dijkstra
% Sintaxis sumaKm(resultado de los dijkstra, Kilometraje total de la
% ruta)
sumaKm([],0).
sumaKm([Head|Tail],Total):-kilometraje(Head,Km), sumaKm(Tail, Suma),Total is Suma + Km.

% Funci�n encargada de acomodar los elementos del dijkstra, realizar las
% sumas de los tiempos y kilometros
% Sintaxis acomodar(Resultado del Dijkstra, Lista ordenada).
acomodar([],Ruta,Ruta).
acomodar(Dijkstra,Resultado):-ordenarLugares(Dijkstra,Lugares),sumaKm(Dijkstra,Km),sumarTiempo(Dijkstra, Tiempo),sumarPresa(Dijkstra,Presa),
    acomodar([],Resultado, [Lugares,Km, Tiempo,Presa]).
