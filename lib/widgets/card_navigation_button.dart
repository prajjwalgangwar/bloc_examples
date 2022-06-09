
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardNavigationButton extends StatelessWidget{
  final String name;
  Widget navigate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=> navigate);
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,

        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            letterSpacing: 2
          ),
        )
      ),
    );
  }

  CardNavigationButton(
      {required this.name,
       required this.navigate,
      required this.color,});
}