import 'package:app/Ingreso%20a%20bodega/services/ingresoBodegaService.dart';
import 'package:app/configuracion/services/configseervice.dart';
import 'package:app/registro/services/registro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class registroPage extends StatefulWidget {
  const registroPage({super.key});

  @override
  State<registroPage> createState() => _registroPageState();
}

class _registroPageState extends State<registroPage> {
  String contenedor = "Seleccionar";
  String percha = "Seleccionar";
  var codeProducttxt=TextEditingController();

  
  registrosServices gtxregistro=Get.put(registrosServices());
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B37C9),
      ),
      body: Obx(() => gtxregistro.esperar.value == false
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Seleccione Bodega",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF3B37C9),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton(
                      underline: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide.none),
                        ),
                      ),
                      hint: Text(
                        contenedor,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      items: gtxregistro.listaContenedores.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (x) async {
                        gtxregistro.esperar.value = true;
                        setState(() {
                          contenedor = x!;
                        });
                        // var r = await gtxregistro.buscarPercha();
                        // gtxregistro.contenedorSeleccionado.value = x!;
                        gtxregistro.llenarformularioconfiguracion.value = true;
                        gtxregistro.esperar.value = false;
                        gtxregistro.contenedorSeleccionado.value = x!;
                        await gtxregistro.getPerchasRegistro();
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Seleccione Percha",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Obx(() => Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF3B37C9),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButton(
                          underline: Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide.none),
                            ),
                          ),
                          hint: Text(
                            percha,
                            style: TextStyle(color: Colors.white),
                          ),
                          items: gtxregistro.listaPerchas.map((item) {
                            return DropdownMenuItem<dynamic>(
                              value: item.toString(),
                              child: Text(item.toString()),
                            );
                          }).toList(),
                          onChanged: (x) {
                            setState(() {
                              percha = x.toString();
                            });
                            gtxregistro.perchaSeleccionada.value = x.toString();
                          },
                        ),
                      )),
                       Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller:codeProducttxt
                   
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        gtxregistro.esperar.value = true;
                        gtxregistro.productCode.value=codeProducttxt.text;
                        
                        
                        if (contenedor == "Seleccionar" ||
                            percha == "Seleccionar") {
                          Seleccioneitems(context);
                        } else {
                          gtxregistro.esperar.value = true;

                          var r =
                              await gtxregistro.getInventariosbyPArameters();
                          print("invemtario");
                          print(r.toString());
                          gtxregistro.esperar.value = false;
                        }
                        gtxregistro.esperar.value = false;
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color(0xFF3B37C9),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          "Buscar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Obx(
                    () => gtxregistro.ListProductsInventario.length == 0
                        ? Container(
                            child: Center(
                              child: Text("No hay Datos"),
                            ),
                          )
                        : Container(
                            child: Column(
                            children: [
                              for (int i = 0;
                                  i < gtxregistro.ListProductsInventario.length;
                                  i++)
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 80,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 229, 229, 230),
                                    border: Border.all(
                                        color: Color.fromARGB(255, 33, 33, 33)),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                            Column(
                                              children: [
                                                Container(
                                                  child: Text("Bodega"),
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    overflow: TextOverflow.fade,
                                                    gtxregistro
                                                      .ListProductsInventario[i]
                                                          ["containerCode"]
                                                      .toString()),
                                                ),
                                              ],
                                            ),
                                            Column(children: [
                                              Container(
                                                child: Text("Percha"),
                                              ),
                                              Container(
                                                child: Text(gtxregistro
                                                    .ListProductsInventario[i]
                                                        ["hangerCode"]
                                                    .toString()),
                                              )
                                            ]),
                                         
                                            Column(
                                              children: [
                                                Container(
                                                  child: Text("Producto"),
                                                ),
                                                Container(
                                                  width: 70,
                                                  child: Text(
                                                    overflow: TextOverflow.fade,
                                                    gtxregistro
                                                      .ListProductsInventario[i]
                                                          ["product"]["code"]
                                                      .toString()),
                                                ),
                                              ],
                                            ),
                                               Column(children: [
                                              Container(
                                                child: Text("cantidad"),
                                              ),
                                              Container(
                                                width: 50,
                                                child: Text(
                                                   overflow: TextOverflow.fade,
                                                  gtxregistro
                                                    .ListProductsInventario[i]
                                                        ["quantity"]
                                                    .toString()),
                                              )
                                            ]),
                                            GestureDetector(
                                              onTap: () async {
                                                gtxregistro.esperar.value = true;
                                                gtxregistro.idInventary
                                                    .value = gtxregistro
                                                        .ListProductsInventario[
                                                    i]["_id"];
                                                var respuesta = gtxregistro
                                                    .deleteInventary();
                                                var r = await gtxregistro
                                                    .getInventariosbyPArameters();
                                                print("###delete");
                                                print(respuesta.toString());
                                                gtxregistro.esperar.value = false;
                                              },
                                              child: Container(
                                                
                                                child: Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: Colors.red,
                                                  size: 24.0,
                                                  semanticLabel:
                                                      'Text to announce in accessibility modes',
                                                ),
                                              ),
                                            )
                                          ]))
                                    ],
                                  ),
                                )
                            ],
                          )),
                  ),
                ],
              ),
            )
          : Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))),
    );
  }
}

void Seleccioneitems(context) {
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
                    'Seleccione todos los Items',
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
