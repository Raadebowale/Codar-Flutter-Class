import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

class TodoTasks extends StatelessWidget {
  // final int id;
  final String title;
  final bool isDone;
  final Map<String, dynamic> todo;
  // final Function doneSetter;
  // final Function deleteSetter;
  const TodoTasks(
      {super.key,
      // required this.id,
      required this.title,
      required this.isDone,
      required this.todo
      // required this.doneSetter,
      // required this.deleteSetter,
      });

  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<TodoProvider>(context);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      height: 60.0,
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        onTap: () {
          todoData.setDone(todo);
        },
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.teal,
            size: 25.0,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
            onPressed: () {
              todoData.deleteTodo(todo);
            },
            icon: Icon(
              Icons.close,
              size: 30.0,
              weight: 40.0,
              color: Colors.redAccent,
            )),
      ),
    );
  }
}
