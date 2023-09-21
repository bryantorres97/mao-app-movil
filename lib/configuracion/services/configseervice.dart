import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../enviroment.dart';

class configuracionService extends GetxController {
  var desaparecebotonesextra=false.obs;
  var esperar = false.obs;
  var llenarformularioconfiguracion = false.obs;
  var listaContenedores = [""].obs;

  var containerSelected="".obs;
  var listaPerchas = [].obs;
  var listaAuxiliares = [].obs;

  var contenedorSeleccionado = "".obs;
  var perchaSeleccionada = "".obs;
  var aux1="".obs;
  var aux2="".obs;
  var jsonaux=[];
  var cedula1="".obs;
  var cedula2="".obs;
  var cedula3="".obs;

  enviroment gtxEnv = Get.put(enviroment());



  Future<dynamic> getContainers() async {
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
  Future<dynamic> getPerchas() async {
    listaPerchas.clear();
    final url = Uri.parse('${gtxEnv.url}/api/containers/${contenedorSeleccionado.value}/hangers');
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
  
  
  
  Future<dynamic> getAuxiliares() async {
    listaAuxiliares.clear();
    final url = Uri.parse('${gtxEnv.url}/api/assistants');
    listaPerchas.clear();
    var response = await http.get(url);
    print("la respuesta d e asistentes");
    print(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
     // jsonaux=jsonData.toList();
     
      for (int i = 0; i < jsonData.length; i++) {
        listaAuxiliares.add(jsonData[i]);

        
      }
      print("************ Lista auxiliares  con exito************");
      print(listaAuxiliares.toString());
      print(listaAuxiliares[0]["fullName"].toString());
    
     
    } else {
      print("no se pudo logear");
    }

    return response.statusCode;
  }
}
