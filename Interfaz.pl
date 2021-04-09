:-use_module(bnf3).
:-use_module(bdyg).
:-use_module(logica).
/*
 Funci�n principal.
 Unifica todos los hechos y reglas definidos para permitir la comunicacion entre el usuario y el sistema
 */
wazelog():-
    write("Bienvenido a WazeLog la mejor l�gica de llegar a su destino.\n Por Favor ind�queme donde se encuentra. \n"),
    oracion_valida(Lugarsalida),
    write("perfecto \n"),
    write("Cu�l es su destino? \n"),
    oracion_valida(Lugardestino),
    write("perfecto \n"),
    repeat,
    write("�Desea agregar un destino intermedio?\nIndique si o no, por favor.\n"),
    read(Afirmacion),
    intermedio(Intermedios,[],Afirmacion),
    inversa([Lugardestino|Intermedios],Rutas1),
    mejorRuta([Lugarsalida|Rutas1],Ruta),
    write("Su ruta ser�a la siguiente: "),
    respuestaLugares(Ruta),
    respuestaTiempos(Ruta),
    write("\n �Muchas gracias por usar WazeLog!").

/*
Autor:Juan Pablo Carrillo
Descripcion: transforma un string en una lista de palabras.
Sintaxis:transformar(string, lista con las palabras del string)
*/
transformar(C, [H|T]) :-
  sub_atom(C, PosEspacio, _, _, ' '),
  sub_atom(C, 0, PosEspacio, _, H),
  P is PosEspacio + 1,
  sub_atom(C, P, _, 0, C1),
  transformar(C1, T).
transformar(P, [P]).

/*
 Autor:Juan Pablo Carrillo
 Descripcion: verifica si se menciona una ciudad en la oracion
 ingresada por el usuario.
 Sintaxis: verifica_ciudad(lista con las palabras de la oracion, ciudad
 mencionada en la oracion)
*/
verifica_ciudad([Elem|_],Elem):-
    ciudad(Elem).
verifica_ciudad([_|Resto],Elem):-
    verifica_ciudad(Resto, Elem).

/*
 Autor:Juan Pablo Carrillo
 Descripcion: verifica si se menciona un lugar en la oracion ingresada
 por el usuario.
 Sintaxis: verifica_lugar(lista con las palabras de la oracion,
 lugar mencionado en la oracion)
*/
verifica_lugar([Elem|_],Elem):-
    lugar(Elem).
verifica_lugar([_|Resto],Elem):-
    verifica_lugar(Resto, Elem).

/*
Mensaje presentado cuando el usuario ingresa una oracion mal estructurada o sin sentido para el contexto del programa
*/
mensaje_error:-write("Disculpe, no se le entiende, podr�a ser mas especifico?\n
Recuerde indicar solo un lugar a la vez e indicarlo de forma clara.\n
Importante: Si ya indic� el lugar de forma clara entonces es que nuestro servicio no est� disponible para la ubicaci�n indicada.\n
Ingrese de nuevo el lugar: \n").


/*
  Autor:Juan Pablo Carrillo
  Descripci�n: recibe una oracion, verifica que esta sea valida y
  devuelve la ciudad que se identifique en la oraci�n.
  Sintaxis: oracion_valida(Lugar identificado en la oracion)
  */
oracion_valida(Lugar):-
    read(Oracion),
    transformar(Oracion, Lista),
    oracion(Lista,[]),
    verificador_de_lugaryciudad(Lista,Lugar),!.
oracion_valida(Lugar):-mensaje_error,oracion_valida(Lugar).

/*
 Autor:Juan Pablo Carrillo
 Descripci�n: Se encarga de verificar que en la lista de palabras
 de la oracion dada, se encuentre un nombre ciudad o lugar.
 sintaxis: Verificador_de_lugaryciudad(Lista de palabras,Ciudad
 encontrada en las palabras)
*/
verificador_de_lugaryciudad(Lista,Ciudad):-
  verifica_ciudad(Lista,Ciudad),
  !.
verificador_de_lugaryciudad(Lista,Ciudad):-
  verifica_lugar(Lista,Lugar),
  write("Cual "),write(Lugar),write(" ser�a?\n"),
  read(_),
  write("Podr�a indicarme ahora d�nde se ubica este lugar?\n"),
  oracion_valida(Ciudad).

/*
Descripci�n: funipon que solicita los lugares intermedios al usuario y
los guarda en una lista.
Sintaxis: intermedio(Lista con los lugares intermedios, Lista vacia,
afirmcaci�n(condicional que decide si se sigue solictando m�s lugares))
Autor: Sebasti�n Moya
*/
intermedio([],Lista,Lista).
intermedio(Lista,Lista1,no):-
  write("entendido\n"),
  intermedio([],Lista,Lista1).
intermedio(Lista,Lista1,si):-
  write("�Cual es su destino intermedio?\n"),
  oracion_valida(Lugar),
  repeat,
  write("�Desea agregar alg�n otro destino intermedio?\nIndique si o no, por favor.\n"),
  read(Afirmacion),
  intermedio(Lista,[Lugar|Lista1],Afirmacion).
/*
Descripci�n: funci�n que escribe en consola los lugares de la ruta
Sintaxis: respuestaLugares(Lista con los lugares,0).
Autor: Sebasti�n Moya
*/
respuestaLugares([],0).
respuestaLugares([Head|Tail],0):-
  write(Head),
  write(", "),
  respuestaLugares(Tail,0).
respuestaLugares([Head|_]):-
  respuestaLugares(Head,0).
/*
Descripci�n: Funci�n que escribe en consola el tiempo, el kilometraje y
el tiempo en presa del viaje.
Sintaxis: respuestaTiempos(Lista resultado de la ruta)
Autor: Sebasti�n Moya Monge.
 */
respuestaTiempos([_|[Km|[Tiempo|[Presa|_]]]]):-
  write("debe recorrer una distancia de "),
  write(Km),
  write(" km. \nEl tiempo estimado de viaje es de "),
  write(Tiempo),
  write(" minutos sin presa, con presa el tiempo estimado ser�a de "),
  write(Presa),
  write(" minutos").
