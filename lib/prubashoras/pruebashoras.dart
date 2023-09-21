import 'package:app/prubashoras/pruebasServi%20.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class pruebbahorasPage extends StatelessWidget {
  const pruebbahorasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () async {
          horarioService gtxhorario = Get.put(horarioService());
           gtxhorario.enviartoken();
          print("+++++++++++");
    
        },
        child: Text("enviar token"),
      ),
    );
  }
}
