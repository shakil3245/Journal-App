import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  const customButton({
    super.key,required this.buttonName,
  });

  final buttonName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: Text(buttonName,style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
    );
  }
}