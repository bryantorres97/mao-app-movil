import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../enviroment.dart';

class loginservice extends GetxController {
  var canDelete="".obs;
  enviroment gtxEnv = Get.put(enviroment());
  var nombre = "".obs;
  var apellido = "".obs;
  var id="".obs;
  var email="".obs;
  var stage="".obs;

  Future<dynamic> loginUserPassword(String user, String contreasenia) async {
    
      final url = Uri.parse('${gtxEnv.url}/api/auth/login');

      var response = await http.post(url,
          body: ({"email": user, "password": contreasenia}));
      print("la respuesta del login");
      print(response.body.toString());
    
      if (response.statusCode >= 200 && response.statusCode < 300) {
        String body = utf8.decode(response.bodyBytes);

        final jsonData = jsonDecode(body);

        print("login con exito");
        String auxnombre=jsonData["user"]["name"];
         id.value=jsonData["user"]["_id"];
        var reco=auxnombre.split(" ");
        nombre.value=reco[0];
        email.value=jsonData["user"]["email"];
        
        stage.value=jsonData["user"]["stage"];
        canDelete.value=jsonData["user"]["canDelete"].toString();

       // apellido.value=reco[2];
       print("puede borrrrrrrrrraaaaarrrrrrrr");
       print(canDelete.value);
      } else {
        print("no se pudo logear");
       
      }

      return response.statusCode;
    }
  
}
