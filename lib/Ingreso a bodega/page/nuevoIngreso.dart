import 'package:app/Ingreso%20a%20bodega/page/listaProductos.dart';
import 'package:app/Ingreso%20a%20bodega/services/guardar.dart';
import 'package:app/Ingreso%20a%20bodega/services/ingresoBodegaService.dart';
import 'package:app/configuracion/services/configseervice.dart';
import 'package:app/home/page/homePage.dart';
import 'package:app/login/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class nuevoIngresoPage extends StatefulWidget {
  const nuevoIngresoPage({super.key});

  @override
  State<nuevoIngresoPage> createState() => _nuevoIngresoPageState();
}

class _nuevoIngresoPageState extends State<nuevoIngresoPage> {
  String percha = "Seleccionar";
  var cantidadtxt = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
  }
  guardarProducto gtxguardar = Get.put(guardarProducto());
  loginservice gtxlogin = Get.put(loginservice());

  ingresoBodegaService gtxibs = Get.put(ingresoBodegaService());
  configuracionService gtxCongi = Get.put(configuracionService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B37C9),
      ),
      body: Obx(
        () => gtxguardar.esperar.value == false
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Text(
                            "Producto: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Obx(() => Text(gtxibs.codigoBarra.value,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          color: Colors.grey[200],
                          child: TextButton(
                              onPressed: () async {
                                var r = await gtxibs.getProducts();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            listaProductosPage()));
                              },
                              child: Container(
                                child: Icon(Icons.search_rounded),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: cantidadtxt,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 165, 164, 164)),
                          hintText: "Ingrese cantidad",
                          fillColor: const Color.fromARGB(179, 231, 230, 230)),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        gtxguardar.esperar.value = true;
                        if (cantidadtxt.text == "" || cantidadtxt.text == "0" ) {
                          cantidadErronea(context);
                          gtxguardar.esperar.value = false;
                        } else {
                          gtxguardar.codigoBarra.value =
                              gtxibs.codigoBarra.value;
                          gtxguardar.percha.value =
                              gtxCongi.perchaSeleccionada.value;
                          gtxguardar.cantidad.value = cantidadtxt.text.trim();
                          gtxguardar.userId.value = gtxlogin.id.value;
                          

                          print(
                              "codigo de barra" + gtxguardar.codigoBarra.value);
                          print("percha" + gtxguardar.percha.value);
                          print("cantidad" + gtxguardar.cantidad.value);
                          print("userid" + gtxguardar.userId.value);
                          var r = await gtxguardar.guardarP();
                          print("codigo peticion guardado");
                          print(r.toString());
                          gtxguardar.esperar.value = false;
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
                          }}
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
                child: Center(
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }
}

void guardadoconexito(context) {
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
                    'Guardado con exito',
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => homePage()));
                    },
                    child: const Text('Aceptar')),
              ],
            )
          ],
        );
      });
}
void teamnodisponible(context) {
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
                    'Team no disponible',
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => homePage()));
                    },
                    child: const Text('Aceptar')),
              ],
            )
          ],
        );
      });
}
void descripcionVavcia(context) {
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
                    'LLene descripción',
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

void errorGuardado(context) {
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
                    'Error al guardar',
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => homePage()));
                    },
                    child: const Text('Aceptar')),
              ],
            )
          ],
        );
      });
}

void cantidadErronea(context) {
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
                    'Error al ingresar Cantidad',
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

void seleccionePercha(context) {
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
                    'Seleccione Percha',
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
