import 'package:app/Ingreso%20a%20bodega/services/ingresoBodegaService.dart';
import 'package:app/configuracion/services/configseervice.dart';
import 'package:app/esperar.dart';
import 'package:app/login/services/loginService.dart';
import 'package:app/registro/services/registro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  esperarService gtxesperar = Get.put(esperarService());
  var user = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => gtxesperar.esperar.value == false
          ? Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text("Version 1.2"),),

                      //logo
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        // ignore: prefer_const_constructors
                        child: Image(
                          width: 250,
                          height: 200,
                          alignment: Alignment.centerLeft,
                          image: const AssetImage('assets/logo.png'),
                        ),
                      ),
                      //documento

                      const SizedBox(height: 50),

                      //formularios

                      //CI
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: TextField(
                          controller: user,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 165, 164, 164)),
                              hintText: "Ingresa tu usuario",
                              fillColor:
                                  const Color.fromARGB(179, 231, 230, 230)),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: TextField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 165, 164, 164)),
                              hintText: "Ingresa tu contraseña",
                              fillColor:
                                  const Color.fromARGB(179, 231, 230, 230)),
                        ),
                      ),

                      //donde encuentro

                      TextButton(
                          onPressed: () async {
                            gtxesperar.esperar.value = true;
                            registrosServices gtxregistro=Get.put(registrosServices());
                           var respu=await gtxregistro.getContainersRegistro();
                            configuracionService gtxconfig=
                                Get.put(configuracionService());
                            var rsp = await gtxconfig.getContainers();
                            var rsp2 = await gtxconfig.getAuxiliares();
                            loginservice gtxlogin = Get.put(loginservice());
                            var r = await gtxlogin.loginUserPassword(
                                user.text.trim(), password.text.trim());
                            print(r.toString());
                            if (r >= 200 && r < 300) {
                              print("correcto");
ingresoBodegaService gtxibs = Get.put(ingresoBodegaService());
                  var rpt = await gtxibs.getProducts();
                              routesEnrollAccounts rutas =
                                  routesEnrollAccounts();
                              Navigator.push(context, rutas.routeHome);
                            } else {
                              errorLogin(context);
                              print("hubo un problema al autenticar");
                            }
                            gtxesperar.esperar.value = false;
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
                              "Ingresar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )),
    );
  }
}

void errorLogin(context) {
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
                    'Error en las credeenciales',
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
