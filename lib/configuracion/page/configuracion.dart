import 'package:app/Ingreso%20a%20bodega/services/ingresoBodegaService.dart';
import 'package:app/configuracion/services/configseervice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class configuracionPage extends StatefulWidget {
  const configuracionPage({super.key});

  @override
  State<configuracionPage> createState() => _configuracionPageState();
}

class _configuracionPageState extends State<configuracionPage> {
  String contenedor = "Seleccionar";
  String percha = "Seleccionar";
  String aux1 = "Seleccionar";
  String aux2 = "Seleccionar";
  String aux3 = "Seleccionar";
  configuracionService gtxConfiguracionService =
      Get.put(configuracionService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3B37C9),
        ),
        body: Obx(
          () => gtxConfiguracionService.esperar.value == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        "Seleccione Bodega",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Container(
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
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide.none),
                          ),
                        ),
                        hint: Text(
                          contenedor,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        items: gtxConfiguracionService.listaContenedores
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                        onChanged: (x) async {
                          gtxConfiguracionService.esperar.value = true;
                          setState(() {
                            contenedor = x!;
                          });
                          // var r = await gtxConfiguracionService.buscarPercha();
                          gtxConfiguracionService.contenedorSeleccionado.value =
                              x!;
                          gtxConfiguracionService
                              .llenarformularioconfiguracion.value = true;
                          gtxConfiguracionService.esperar.value = false;
                          var r = await gtxConfiguracionService.getPerchas();
                          gtxConfiguracionService.esperar.value = false;
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Seleccione Percha",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Obx(() => Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
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
                            hint: Text(percha,
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            items: gtxConfiguracionService.listaPerchas
                                .map((item) {
                              return DropdownMenuItem<dynamic>(
                                value: item.toString(),
                                child: Text(item.toString()),
                              );
                            }).toList(),
                            onChanged: (x) {
                              gtxConfiguracionService.esperar.value = true;
                              setState(() {
                                percha = x.toString();
                              });
                              gtxConfiguracionService.perchaSeleccionada.value =
                                  x.toString();
                              gtxConfiguracionService.esperar.value = false;
                            },
                          ),
                        )),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Seleccione Auxiliar",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Container(
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
                        isExpanded: true,
                        underline: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide.none),
                          ),
                        ),
                        hint: Text(aux1,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        items:
                            gtxConfiguracionService.listaAuxiliares.map((item) {
                          return DropdownMenuItem<dynamic>(
                            value: item["ci"],
                            child: Text(item["fullName"]),
                          );
                        }).toList(),
                        onChanged: (x) {
                          gtxConfiguracionService.esperar.value = true;

                          // setState(() {

                          //   aux1 = x.toString();
                          // });
                          for (int i = 0;
                              i <
                                  gtxConfiguracionService
                                      .listaAuxiliares.length;
                              i++) {
                            if (gtxConfiguracionService.listaAuxiliares[i]
                                    ["ci"] ==
                                x) {
                              setState(() {
                                aux1 = gtxConfiguracionService
                                    .listaAuxiliares[i]["fullName"];
                              });
                            } else {
                              print("no selecciono usuario");
                            }
                          }
                          gtxConfiguracionService.cedula1.value = x.toString();
                          gtxConfiguracionService.esperar.value = false;
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Seleccione Auxiliar 2",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Container(
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
                        isExpanded: true,
                        underline: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide.none),
                          ),
                        ),
                        hint: Text(aux2,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        items:
                            gtxConfiguracionService.listaAuxiliares.map((item) {
                          return DropdownMenuItem<String>(
                            value: item["ci"],
                            child: Text(item["fullName"]),
                          );
                        }).toList(),
                        onChanged: (x) {
                          gtxConfiguracionService.esperar.value = true;
                          for (int i = 0;
                              i <
                                  gtxConfiguracionService
                                      .listaAuxiliares.length;
                              i++) {
                            if (gtxConfiguracionService.listaAuxiliares[i]
                                    ["ci"] ==
                                x) {
                              setState(() {
                                aux2 = gtxConfiguracionService
                                    .listaAuxiliares[i]["fullName"];
                              });
                            } else {
                              print("no selecciono usuario");
                            }
                            gtxConfiguracionService.cedula2.value =
                                x.toString();
                            print(x);
                            gtxConfiguracionService.esperar.value = false;
                          }
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Seleccione Auxiliar 3",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Container(
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
                        isExpanded: true,
                        underline: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide.none),
                          ),
                        ),
                        hint: Text(
                          aux3,
                          style: TextStyle(color: Colors.white),
                        ),
                        items:
                            gtxConfiguracionService.listaAuxiliares.map((item) {
                          return DropdownMenuItem<String>(
                            value: item["ci"],
                            child: Text(item["fullName"]),
                          );
                        }).toList(),
                        onChanged: (x) {
                          gtxConfiguracionService.esperar.value = true;
                         

                          for (int i = 0;
                              i <
                                  gtxConfiguracionService
                                      .listaAuxiliares.length;
                              i++) {
                            if (gtxConfiguracionService.listaAuxiliares[i]
                                    ["ci"] ==
                                x) {
                              setState(() {
                                aux3 = gtxConfiguracionService
                                    .listaAuxiliares[i]["fullName"];
                              });
                            } else {
                              print("no selecciono usuario");
                            }
                          }

                          gtxConfiguracionService.cedula3.value = x.toString();
                          print(x);
                          gtxConfiguracionService.esperar.value = false;
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          gtxConfiguracionService.esperar.value = true;
                       
                          if (contenedor == "Seleccionar" ||
                              percha == "Seleccionar") {
                            print("seleccione contenedor");
                            seleccioneCampos(context);
                            gtxConfiguracionService.esperar.value = false;
                          } else {
                            gtxConfiguracionService
                                .llenarformularioconfiguracion.value = true;
                            gtxConfiguracionService
                                .desaparecebotonesextra.value = true;
                            gtxConfiguracionService.esperar.value = false;
                            Navigator.pop(context);
                          }
                          gtxConfiguracionService.esperar.value = false;
                          //   }
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
                            "Guardar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                )
              : Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
        ));
  }
}

void seleccioneCampos(context) {
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
                    'Seleccione Todos los campos',
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

void miembrosiguales(context) {
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
                    'Auxiliares deben ser diferentes',
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
