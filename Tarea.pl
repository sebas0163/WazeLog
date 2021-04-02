:-use_module(bnf).
%----------base de datos(Lugares) y el grafo con toda la info-----------
lugar(cartago).
lugar(guanacaste).
lugar(heredia).
arco(cartago,heredia,2).
arco(cartago,guanacaste,6).

%------Funcion que transforma un string en una lista de palabras--------

%transformar(string, lista con las palabras del string)
transformar(C, [H|T]) :-
  sub_atom(C, PosEspacio, _, _, ' '),
  sub_atom(C, 0, PosEspacio, _, H),
  P is PosEspacio + 1,
  sub_atom(C, P, _, 0, C1),
  transformar(C1, T).
transformar(P, [P]).

%-------Funcion que detecta si se menciona un lugar en la oracion-------

% detecta_lugar(lista con las palabras de la oracion, lugar mencionado en
% la oracion)
detecta_lugar([Elem|_],Elem):-lugar(Elem).
detecta_lugar([_|Resto],Elem):- detecta_lugar(Resto, Elem).

%--------------------Función principal----------------------------------
wazelog():-
    write("Bienvenido a WazeLog la mejor lógica de llegar a su destino.Por Favor indíqueme donde se encuentra. \n"),
    read(Osalida),transformar(Osalida, Lista),oracion(Lista,[]),detecta_lugar(Lista,Lugarsalida),
    write("Cuál es su destino? \n"),
    read(Odestino),transformar(Odestino, Lista1),detecta_lugar(Lista1,Lugardestino),
    arco(Lugarsalida,Lugardestino,Tiempo),
    write("El tiempo estimado de duración es: "),write(Tiempo),write(" horas").

