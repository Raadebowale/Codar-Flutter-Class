import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

import 'todo_tasks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController addTask = TextEditingController();

  @override
  void initState() {
    initTodo();
    super.initState();
    log("In init state");
  }

  @override
  void dispose() {
    super.dispose();
    addTask.dispose();
  }

  initTodo() async {
    await Provider.of<TodoProvider>(context, listen: false).populateTodos();
    log("In todo method");
  }

  @override
  Widget build(BuildContext context) {
    log("In build method");
    final todoData = Provider.of<TodoProvider>(context);
    // todoData.populateTodos();
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal[100],
        actions: [
          CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(
                "https://hips.hearstapps.com/hmg-prod/images/gettyimages-1229892983-square.jpg?crop=1xw:0.75xh;center,top&resize=1200:*"),
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 30.0,
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(60.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Search tasks",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13.0,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "My Tasks",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoData.todos.length,
                itemBuilder: (context, index) {
                  final todo = todoData.todos[index];
                  // for (var todo in todoData)
                  return TodoTasks(
                    title: todo["title"],
                    isDone: todo["isDone"],
                    todo: todo,
                    // id: todo["id"],
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30, right: 15.0),
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset.zero,
                              blurRadius: 10.0,
                            )
                          ]),
                      child: TextField(
                        controller: addTask,
                        decoration: InputDecoration(
                          hintText: "Add new Tasks",
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13.0,
                          ),
                          border: InputBorder.none,
                          /* border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.0)) */
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        /* setState(() {
                          todoData.add({
                            "id": (todoData.length + 1),
                            "isDone": false,
                            "title": addTask.text
                          });
                        }); */
                        todoData.addTodo({
                          // "id": (todoData.todos.length + 1),
                          "isDone": false,
                          "title": addTask.text
                        });
                        addTask.clear();
                      },
                      child: Icon(
                        Icons.add,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 228, 205),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15.0),
                        shadowColor: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
