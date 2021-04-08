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
arco(cerbantes,juanVi�as,5).
arco(cervantes,pacayas,8).
arco(juanVi�as,turrialba,4).
arco(turrialba,pacayas,18).
arco(turrialba,cachi,40).
arco(pacayas,cervantes,8).
arco(pacayas,cartago,13).
arco(pacayas,tresRios,15).
% Funci�n encargada de a�adir elementos a una lista.
% Forma: (lista inicial, elemento que se desea a�adir, lista obtenida).
concatenar([],Lista,Lista).
concatenar([Head|Lista1],Lista2, [Head|Lista3]):-concatenar(Lista1,Lista2,Lista3).
%Funci�n que toma el tiempo de viaje de la lista dada por el grafo
%Sintaxis horaTransito(Lista de lugares, km, tiempo, presa)
horaTransito([],Tiempo,Tiempo).
horaTransito([_|[Hora|_]],Tiempo):-horaTransito([],Tiempo,Hora).
% Funci�n que toma el tiempo de viaje en presa de la lista dada por el
% grafo
% Sintaxis horaTransito(Lista de lugares, km, tiempo, presa)
horaPresa([],Hora,Hora).
horaPresa([_|[Hora|_]],Presa):-horaPresa([],Presa,Presa1), Presa1 is Hora*2.
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

