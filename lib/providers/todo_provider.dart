import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoProvider extends ChangeNotifier {
  // List<TodoModel> todos = [];
  List<Map<String, dynamic>> todos = [
    // {'id': 1, 'isDone': true, 'title': 'Wash Dishes'},
    // {'id': 2, 'isDone': true, 'title': 'Cook Food'},
    // {'id': 3, 'isDone': false, 'title': 'Read Book'},
    // {'id': 4, 'isDone': false, 'title': 'Work on project'},
    // {'id': 5, 'isDone': false, 'title': 'Eat food'}
  ];
  // final todoStr = json.encode(todos{});
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future populateTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("todos") != null) {
      prefs.getStringList("todos")!.forEach((todo) {
        Map<String, dynamic> decodedTodo = json.decode(todo);
        todos.add(decodedTodo);
        // final encodePref = json.encode(prefs.getStringList("todos")!);
      });
      notifyListeners();
    }

    // todos.addAll(encodePref);
  }

  addTodo(Map<String, dynamic> todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todos.add(todo);
    // final todoStr = json.encode(todos);
    final stringTodo = todos.map((todo) => json.encode(todo)).toList();
    prefs.setStringList("todos", stringTodo);
    notifyListeners();
  }

  deleteTodo(todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todos.remove(todo);
    // todos.removeWhere((todo) => todo['id'] == 'id');
    // final todoStr = json.encode(todos);
    // prefs.setStringList("todos", json.decode(todoStr) as List<String>);
    final stringTodo = todos.map((todo) => json.encode(todo)).toList();
    prefs.setStringList("todos", stringTodo);
    notifyListeners();
  }

  setDone(todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todo["isDone"] = !todo["isDone"];
    final stringTodo = todos.map((todo) => json.encode(todo)).toList();
    prefs.setStringList("todos", stringTodo);
    // final todoStr = json.encode(todos);
    // prefs.setStringList("todos", json.decode(todoStr));
    notifyListeners();
  }
}

/* class TodoModel {
  final String? title;
  final String? description;
  final bool isDone;

  TodoModel({this.title, this.description, this.isDone = false});
} */
