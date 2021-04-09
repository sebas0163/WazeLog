:- module(bdyg, [ciudad/1,lugar/1,arco/3]).

/*
 Definicion de las ciudades
ciudad(nombre de la ciudad).
*/

ciudad(cartago).
ciudad(sanJose).
ciudad(corralillo).
ciudad(tresRios).
ciudad(musgoVerde).
ciudad(pacayas).
ciudad(cervantes).
ciudad(paraiso).
ciudad(juanViñas).
ciudad(turrialba).
ciudad(cachi).
ciudad(orosi).
/*
Definicion de los lugares
lugar(nombre del lugar)
*/
lugar(restaurante).
lugar(supermercado).
lugar(tienda).
lugar(pulperia).
lugar(cine).
lugar(farmacia).
lugar(hospital).
lugar(clinica).
lugar(gimnasio).
lugar(parque).
lugar(municipalidad).
lugar(banco).
lugar(plaza).
lugar(mall).
lugar(centro).
lugar(comercial).
lugar(registro).
lugar(carniceria).
lugar(verduleria).
lugar(aeropuerto).
lugar(piscina).
lugar(ferreteria).
lugar(automercado).
lugar(cajero).

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



