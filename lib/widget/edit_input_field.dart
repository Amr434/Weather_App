import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditField extends StatelessWidget {
  final    String hint;
  final String label;
  final TextEditingController controller;

  const EditField({Key? key, required this.hint, required this.controller, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var size=MediaQuery.of(context).size;
    return  Container(
      width: double.infinity,
      height: size.height*.08,
      padding: EdgeInsets.only(left: size.width*.04),
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1,
            color: Colors.grey,

          ),

      ),
      child: TextFormField(
        controller: controller,
         cursorColor: Colors.white,

        decoration: InputDecoration(
          labelText: label,
             labelStyle: TextStyle(
               color: Get.isDarkMode?Colors.grey:Colors.black45
             ),
             hintText: hint,
            border: InputBorder.none,

        ),
      ),
    );
  }
}
