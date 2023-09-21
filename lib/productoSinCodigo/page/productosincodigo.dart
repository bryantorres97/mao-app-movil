import 'package:app/Ingreso%20a%20bodega/services/guardar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Ingreso a bodega/page/nuevoIngreso.dart';

class productoSinCodigoPage extends StatefulWidget {
  const productoSinCodigoPage({super.key});

  @override
  State<productoSinCodigoPage> createState() => _productoSinCodigoPageState();
}

class _productoSinCodigoPageState extends State<productoSinCodigoPage> {
  guardarProducto gtxguardar = Get.put(guardarProducto());
  var descripcion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B37C9),
      ),
      body: Obx(
        () => gtxguardar.esperar.value == false
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      width: double.infinity,
                      child: Text(
                        "Ingrese Descripción",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: TextField(
                        controller: descripcion,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            filled: true,
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 165, 164, 164)),
                            hintText: "Descripcion..",
                            fillColor:
                                const Color.fromARGB(179, 231, 230, 230)),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          gtxguardar.esperar.value = true;
                          gtxguardar.descripcion.value = descripcion.text;
                          if (descripcion.text == "") {
                            descripcionVavcia(context);
                            gtxguardar.esperar.value = false;
                          } else {
                            var r =
                                await gtxguardar.guardarProductWithoutCode();

                            if (r == 400) {
                              teamnodisponible(context);
                            } else {
                              if (r >= 200 && r < 300) {
                                guardadoconexito(context);
                                gtxguardar.esperar.value = false;
                              } else {
                                errorGuardado(context);
                                gtxguardar.esperar.value = false;
                              }
                              gtxguardar.esperar.value = false;
                            }
                          }
                           gtxguardar.esperar.value = false;
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
                ),
              )
            : Container(
                child: Center(
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }
}
