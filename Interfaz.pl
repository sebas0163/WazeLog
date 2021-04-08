:-use_module(bnf3).
:-use_module(bdyg).

%------Funcion que transforma un string en una lista de palabras--------

%transformar(string, lista con las palabras del string)
transformar(C, [H|T]) :-
  sub_atom(C, PosEspacio, _, _, ' '),
  sub_atom(C, 0, PosEspacio, _, H),
  P is PosEspacio + 1,
  sub_atom(C, P, _, 0, C1),
  transformar(C1, T).
transformar(P, [P]).

% -------Funcion que verifica si se menciona una ciudad en la
% oracion-------

% verifica_ciudad(lista con las palabras de la oracion, lugar mencionado
% en la oracion)
verifica_ciudad([Elem|_],Elem):-ciudad(Elem).
verifica_ciudad([_|Resto],Elem):- verifica_ciudad(Resto, Elem).

% -------Funcion que verifica si se menciona un lugar en la
% oracion-------

% verifica_lugar(lista con las palabras de la oracion, lugar mencionado
% en la oracion)
verifica_lugar([Elem|_],Elem):-lugar(Elem).
verifica_lugar([_|Resto],Elem):- verifica_lugar(Resto, Elem).

%--------------------Función principal----------------------------------
wazelog():-
    write("Bienvenido a WazeLog la mejor lógica de llegar a su destino.Por Favor indíqueme donde se encuentra. \n"),
    oracion_valida(Lugarsalida),
    write("Cuál es su destino? \n"),
    oracion_valida(Lugardestino),
    arco(Lugarsalida,Lugardestino,Tiempo),
    write("El tiempo estimado de duración es: "),write(Tiempo),write(" horas \n"),
    write("Perfecto, ¿Tiene algún destino intermedio? \n").

/*intermedia(Ciudadintermedia):- write("Perfecto, ¿Tiene algún destino intermedio? \n"),
  read(Ociudadintermedia),
  transformar(Ociudadintermedia, Lista_i),
  oracion(Lista_i,[]),
  verifica_ciudad(Lista_i,Ciudadintermedia).

test:- repeat, write("Please enter a number"),nl,read(X),X>=21,write("The number is greater than 21").

origen:- repeat,write("Disculpe,el mensaje no se entiende,podría ser mas claro?\n Indiqueme de nuevo donde se encuentra \n"),read(Osalida),transformar(Osalida, Lista),oracion(Lista,[]),verifica_ciudad(Lista,Lugarsalida),write(Lugarsalida),repeat,write("Disculpe,el mensaje no se entiende,podría ser mas claro?\n Indiqueme de nuevo cual es su destino \n"),read(Odestino),transformar(Odestino, Lista1),oracion(Lista1,[]),verifica_ciudad(Lista1,Lugardestino),write(Lugardestino).
error(Lista):- oracion(Lista,[]),verifica_ciudad(Lista,X).*/

mensaje_error:-write("Disculpe,no se le entiende, podría ser mas especifico \n").

/*verificador(Lista2,Lugar):-
    oracion(Lista2,[]),
    verifica_ciudad(Lista2,Lugar),
    write("perfecto \n").
verificador(Listaprueba,Lugarencontrado):-
  not(oracion(Listaprueba,[])),
  !,
  Lugarencontrado is 1,
  mensaje_error,!,
  fail.
verificador(Listaprueba,Lugarencontrado):-
  not(verifica_ciudad(Listaprueba,Lugarencontrado)),
  mensaje_error,!,
  fail.*/

oracion_valida(Lugar):-
    read(Oracion),
    transformar(Oracion, Lista),
    oracion(Lista,[]),
    verificador_de_lugaryciudad(Lista,Lugar),
    write("perfecto \n"),!.
oracion_valida(Lugar):-mensaje_error,oracion_valida(Lugar).

verificador_de_lugaryciudad(Lista,Ciudad):-verifica_ciudad(Lista,Ciudad).
verificador_de_lugaryciudad(Lista,Ciudad):-verifica_lugar(Lista,Lugar), write("Cual "),write(Lugar),write("?\n"), read(_),write("Dónde se ubica este?\n"),oracion_valida(Ciudad).
