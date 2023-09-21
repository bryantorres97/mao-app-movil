import 'dart:convert';

import 'package:app/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
class horarioService extends GetxController{
  
enviroment gtxEnv=Get.put(enviroment());


  Future<dynamic> enviartoken() async {
    
      final url = Uri.parse('https://bus.crediya.fin.ec/enroll/send-token');

      var response = await http
      .post(url,
          body: ({"ci": "0503646556"}));
      print("la respuesta del login");
      print(response.body.toString());
    
     
        String body = utf8.decode(response.bodyBytes);

        final jsonData = jsonDecode(body);

        print(" exito");
        print(jsonData.toString());
      
       
     

      return response.statusCode;
    }
}