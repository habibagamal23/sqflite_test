import 'package:flutter/material.dart';

class CardTodolist extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback onDelete;

  const CardTodolist(
      {super.key,
      required this.title,
      required this.desc,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          // task ui
          Text(title),
          Text(desc),
          IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
