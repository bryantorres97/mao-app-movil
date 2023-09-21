import 'dart:convert';

import 'package:app/configuracion/services/configseervice.dart';
import 'package:app/login/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../enviroment.dart';

class guardarProducto extends GetxController {
  var esperar = false.obs;
  var codigoBarra = "".obs;
  var percha = "".obs;
  var cantidad = "".obs;
  var userId = "".obs;
  var fase = "".obs;
   var descripcion="".obs;
  guardarProducto();

  enviroment gtxEnv = Get.put(enviroment());
  configuracionService gtxxconfig = Get.put(configuracionService());
  loginservice gtxlogin = Get.put(loginservice());
  Future<dynamic> guardarP() async {
     print("datos a guardar");
   
    print(gtxxconfig.perchaSeleccionada.value,);
    print(gtxxconfig.contenedorSeleccionado.value,);
    print(codigoBarra.value);
    print(gtxxconfig.cedula1.value);
    print(gtxxconfig.cedula2.value);
    print(gtxlogin.id.value,);
    print( cantidad.value);
    final url = Uri.parse('${gtxEnv.url}/api/inventory');

   

    var response = await http.post(url,
        body: ({ 
          
          "hangerCode": gtxxconfig.perchaSeleccionada.value,
          "containerCode": gtxxconfig.contenedorSeleccionado.value,
          "productCode": codigoBarra.value,
          "productDescription": "",
          "assistentCi1": gtxxconfig.cedula1.value,
          "assistentCi2": gtxxconfig.cedula2.value,
          "assistentCi3":gtxxconfig.cedula3.value!,
          "userId": gtxlogin.id.value,
          "quantity": cantidad.value 
        }));
        print("la respuesta del guardado es ");
        print(response.body.toString());
print("bryyyaaaaannnnnnnnn");
        print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      print("guardado********");
      print(body);
      final jsonData = jsonDecode(body);

      return response.statusCode;
    }
    return response.statusCode;
  }
  Future<dynamic> guardarProductWithoutCode() async {
    
    final url = Uri.parse('${gtxEnv.url}/api/inventory');

   

    var response = await http.post(url,
        body: ({ 
          
          "hangerCode": gtxxconfig.perchaSeleccionada.value,
          "containerCode": gtxxconfig.contenedorSeleccionado.value,
          "productCode": "",
          "productDescription":descripcion.value ,
          "assistentCi1": gtxxconfig.cedula1.value,
          "assistentCi2": gtxxconfig.cedula2.value,
          "assistentCi3":gtxxconfig.cedula3.value!,
          "userId": gtxlogin.id.value,
          "quantity": "" 
        }));
        print("la respuesta del guardado es ");
        print(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      print("guardado********");
      print(body);
      final jsonData = jsonDecode(body);

      return response.statusCode;
    }
    return response.statusCode;
  }
}
