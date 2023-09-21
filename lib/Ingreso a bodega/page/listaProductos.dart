import 'package:app/Ingreso%20a%20bodega/services/guardar.dart';
import 'package:app/Ingreso%20a%20bodega/services/ingresoBodegaService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import 'nuevoIngreso.dart';

class listaProductosPage extends StatefulWidget {
  const listaProductosPage({super.key});

  @override
  State<listaProductosPage> createState() => _listaProductosPageState();
}

class _listaProductosPageState extends State<listaProductosPage> {
  ingresoBodegaService gtxlistaproductos = Get.put(ingresoBodegaService());
  guardarProducto gtxguardar = Get.put(guardarProducto());
  var buscador = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(backgroundColor: Color(0xFF3B37C9),),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 40,
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text("El ultimo codigo ingresado es:"),),
              Container(child: Text(gtxlistaproductos.codigoBarra.value),),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text("Ingrese el codigo del producto",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(3, 3),
                              blurRadius: 6,
                            ),
                          ],
                          //shape: BoxShape.circle,
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Column(
                          children: [
                            Form(
                              child: SearchField(
                                controller: buscador,

                                suggestions:
                                    gtxlistaproductos.listaNombresProductos
                                        .map(
                                          (e) => SearchFieldListItem<dynamic>(
                                            e,
                                            item: e,
                                          ),
                                        )
                                        .toList(),
                                //suggestions: gtxAgenda.listaNombres,
                                searchStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                searchInputDecoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                maxSuggestionsInViewPort: 6,
                                itemHeight: 50,
                                onSubmit: (x) {
                                  debugPrint("el on tap es ");
                                  debugPrint(x.toString());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                  
                    child: TextButton(
                        onPressed: () async {
                          if (buscador.text == "") {
                            productovacio(context);
                          } else {
                            gtxlistaproductos.codigoBarra.value =
                                buscador.text.trim();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => nuevoIngresoPage()));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                            width: 100,
                            height: 40,
                           decoration: BoxDecoration(
                  color: Color(0xFF3B37C9),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                          child: Text("Agregar",style: TextStyle(color: Colors.white),),
                        )),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}

void productovacio(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'Ingrese Nombre',
                    maxLines: 22,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () async {
                      _dismissDialog(context);
                    },
                    child: const Text('Aceptar')),
              ],
            )
          ],
        );
      });
}

_dismissDialog(context) {
  Navigator.pop(context);
}
