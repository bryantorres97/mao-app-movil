import 'dart:convert';

import 'package:app/enviroment.dart';
import 'package:app/login/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class registrosServices extends GetxController {
  var productCode="".obs;
  var esperar = false.obs;
  var llenarformularioconfiguracion = false.obs;
  var listaContenedores = [""].obs;

  var containerSelected = "".obs;
  var listaPerchas = [].obs;
  var listaAuxiliares = [].obs;

  var contenedorSeleccionado = "".obs;
  var perchaSeleccionada = "".obs;
  var faseSeleccionada = "".obs;
  var ListProductsInventario = [].obs;
  var idInventary = "".obs;


registrosServices();
  enviroment gtxEnv = Get.put(enviroment());
loginservice gtxlogin=Get.put(loginservice());
  Future<dynamic> getContainersRegistro() async {
    listaContenedores.clear();
    final url = Uri.parse('${gtxEnv.url}/api/containers');
    listaPerchas.clear();
    var response = await http.get(url);
    print("la respuesta del traer containers");
    print(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (int i = 0; i < jsonData.length; i++) {
        listaContenedores.add(jsonData[i]["code"]);
      }
      print("************8 Lista container  con exito************");
      print(listaContenedores.toString());
    } else {
      print("no se pudo logear");
    }

    return response.statusCode;
  }

  Future<dynamic> getPerchasRegistro() async {
    listaPerchas.clear();
    final url = Uri.parse(
        '${gtxEnv.url}/api/containers/${contenedorSeleccionado.value}/hangers');
    listaPerchas.clear();
    var response = await http.get(url);
    print("la respuesta del traer perchas");
    print(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (int i = 0; i < jsonData.length; i++) {
        listaPerchas.add(jsonData[i]["code"]);
      }
      print("************8 Lista container  con exito************");
      print(listaPerchas.toString());
    } else {
      print("no se pudo logear");
    }

    return response.statusCode;
  }

  Future<dynamic> getInventariosbyPArameters() async {
    ListProductsInventario.clear();
    final url = Uri.parse('${gtxEnv.url}/api/inventory/report-by-hanger');
    listaPerchas.clear();
    var response = await http.post(url,
        body: ({
          
          "hangerCode": perchaSeleccionada.value,
          "userId": gtxlogin.id.value,
          "productCode":productCode.value,
          "containerCode":contenedorSeleccionado.value
        }));
    print("inventario*********by hangers");
    print(perchaSeleccionada.value);
    print(faseSeleccionada.value);
    print(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (int i = 0; i < jsonData.length; i++) {
        ListProductsInventario.add(jsonData[i]);
      }
      print("********* inventario  con exito************");
      print(ListProductsInventario.toString());
    } else {
      print("no se pudo traer inventario");
    }

    return response.statusCode;
  }

  Future<dynamic> deleteInventary() async {
    ListProductsInventario.clear();
    final url = Uri.parse('${gtxEnv.url}/api/inventory/delete-by-id');
    listaPerchas.clear();
    var response = await http.post(url,
        body: ({
          "_id": idInventary.value,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      print("delete*********inventario");
      print(body);
      final jsonData = jsonDecode(body);

      print("********* inventario  con exito************");
      print(ListProductsInventario.toString());
    } else {
      print("no se pudo traer inventario");
    }

    return response.statusCode;
  }
}
