

import 'package:flutter/material.dart';

class CardTodolist extends StatelessWidget {

  final String title;
  final String desc;

  const CardTodolist({super.key , required this.title , required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
     height: 300,
     decoration: BoxDecoration(
       color: Colors.red,
           borderRadius: BorderRadius.circular(12.0)
     ),
      child: Column(
        children: [
          // task ui
          Text(title),
          Text(desc)
        ],
      ),
    );
  }
}
