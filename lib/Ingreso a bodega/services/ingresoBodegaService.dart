import 'dart:convert';

import 'package:app/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ingresoBodegaService extends GetxController {
  var codigoBarra = "".obs;
 var listaPercha=[""].obs;
 var perchaSeleccionada="".obs;
 var listaNombresProductos=[""].obs;
 var jsonProductos=[].obs;
 var listaux=[""].obs;
  ingresoBodegaService();
  enviroment gtxEnv = Get.put(enviroment());
  Future<dynamic> getProducts() async {
    listaNombresProductos.clear();
    final url = Uri.parse('${gtxEnv.url}/api/products');

    var response = await http.get(url
       );

    if (response.statusCode == 200 || response.statusCode == 201) {
      String body = utf8.decode(response.bodyBytes);
      print("la lista de productos son");
      print(body);

      final jsonData = jsonDecode(body);
      for(int i=0;i<jsonData.length;i++){
        if(jsonData[i]["code"]==""){}else{
        listaNombresProductos.add(jsonData[i]["code"]);
        }
      }


      return response.statusCode;
    }
  }
  // Future<dynamic>  getProductosbbyname(String name) async {
    
  //   for(int i=0;i<listaNombresProductos.length;i++){
  //     if(listaNombresProductos[i]==name){
  //       print("entroooo");
  //       listaux.clear();
  //       listaux.add(listaNombresProductos[i]);
  //       listaNombresProductos=listaux;
  //     }
  //     print("la lista es ");
  //     print(listaNombresProductos.toString());
  //   }
    
  //     }
  
}
