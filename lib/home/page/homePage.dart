import 'package:app/Ingreso%20a%20bodega/page/listaProductos.dart';
import 'package:app/Ingreso%20a%20bodega/page/nuevoIngreso.dart';
import 'package:app/Ingreso%20a%20bodega/routes/routes.dart';
import 'package:app/Ingreso%20a%20bodega/services/ingresoBodegaService.dart';
import 'package:app/configuracion/page/configuracion.dart';
import 'package:app/configuracion/services/configseervice.dart';
import 'package:app/home/services/homeService.dart';
import 'package:app/login/services/loginService.dart';
import 'package:app/productoSinCodigo/page/productosincodigo.dart';
import 'package:app/registro/pages/registro.dart';
import 'package:app/registro/services/registro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import 'package:qrscan/qrscan.dart' as scanner;

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  loginservice gtxloginservice = Get.put(loginservice());
  configuracionService gtxconfig = Get.put(configuracionService());
homeservice gtxhomeservice=Get.put(homeservice());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Obx(()=>gtxhomeservice.esperar.value==false?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              "Bienvenido " + gtxloginservice.nombre.value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Seleccione una opción",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
              onPressed: () async {
                gtxhomeservice.esperar.value=true;
                if (gtxconfig.llenarformularioconfiguracion.value == false) {
                  mensajeLLenarConfiguracion(context);
                } else {
                  //   String cameraScanResult = await scanner.scan();

                  var barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                  print("*****batrcode****");
                  print(barcodeScanRes.toString());
                  if (barcodeScanRes.toString() == "-1") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => homePage()));
                  } else {
                    print("*****el codigo de barra es**");
                    print(barcodeScanRes.toString());
                    ingresoBodegaService gtxcb =
                        Get.put(ingresoBodegaService());
                    gtxcb.codigoBarra.value = barcodeScanRes.toString();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => nuevoIngresoPage()));
                  }

                  // await scanner.scan().then((valor) {
                  //   print("el valor que biuscamos es ");

                }
                gtxhomeservice.esperar.value=false;
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF3B37C9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Ingreso con Código de Barra",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
          TextButton(
              onPressed: () async {
                gtxhomeservice.esperar.value=true;
                if (gtxconfig.llenarformularioconfiguracion.value == false) {
                  mensajeLLenarConfiguracion(context);
                } else {
                  // ingresoBodegaService gtxibs = Get.put(ingresoBodegaService());
                  // var r = await gtxibs.getProducts();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => listaProductosPage()));
                }
                gtxhomeservice.esperar.value=false;
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF3B37C9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Ingresar Manualmente",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
          TextButton(
              onPressed: () async {
                gtxhomeservice.esperar.value=true;
                 if (gtxconfig.llenarformularioconfiguracion.value == false) {
                  mensajeLLenarConfiguracion(context);
                } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => productoSinCodigoPage()));
              }
              gtxhomeservice.esperar.value=false;
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF3B37C9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Producto sin código",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
              Obx(()=>gtxloginservice.canDelete.value=="true"?
          TextButton(
              onPressed: () async {
                gtxhomeservice.esperar.value=true;
                //registrosServices gtxregistro = Get.put(registrosServices());
                // var r = await gtxregistro.getInventarios();
                 if (gtxconfig.llenarformularioconfiguracion.value == false) {
                  mensajeLLenarConfiguracion(context);
                } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => registroPage()));
               } 
               gtxhomeservice.esperar.value=false;
               },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF3B37C9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Registro",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )):Container()),
          
          TextButton(
              onPressed: () {
                gtxhomeservice.esperar.value=true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => configuracionPage()));
                        gtxhomeservice.esperar.value=false;
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF3B37C9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Configuración",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
     
     
       
          TextButton(
              onPressed: () {
                gtxhomeservice.esperar.value=true;
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                gtxhomeservice.esperar.value=false;
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF3B37C9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Salir",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
        ],
      ):Container(child: Center(child: CircularProgressIndicator(),)),)
    
    
    
    );
  }
}

void mensajeLLenarConfiguracion(context) {
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
                    'Primero Configure la Aplicación',
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
