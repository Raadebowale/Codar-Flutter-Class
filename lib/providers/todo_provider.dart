import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  List<Map<String, dynamic>> todos = [];

  final db = FirebaseFirestore.instance;
  final String todoCollection = 'Todos';

  Future<void> populateTodos() async {
    final fbTodos = await db.collection(todoCollection).get();
    fbTodos.docs.forEach((doc) {
      todos.add(doc.data()); // Use 'data()' to get the document data
    });
    notifyListeners();
  }

  void addTodo(Map<String, dynamic> todo) async {
    await db.collection(todoCollection).add(
        todo); // Wait for the document to be added before notifying listeners
    todos.add(todo);
    notifyListeners();
  }

  void deleteTodo(Map<String, dynamic> todo) async {
    todos.remove(todo);
    await db
        .collection(todoCollection)
        .doc(todo['id'])
        .delete(); // Use 'id' to get the document ID
    notifyListeners();
  }

  void setDone(Map<String, dynamic> todo) async {
    todo['isDone'] = !todo['isDone'];
    await db
        .collection(todoCollection)
        .doc(todo['id'])
        .update(todo); // Use 'id' to get the document ID
    notifyListeners();
  }
}

/*class TodoProvider extends ChangeNotifier {
  // List<TodoModel> todos = [];
  List<Map<String, dynamic>> todos = [
    /* {'id': 1, 'isDone': true, 'title': 'Wash Dishes'},
    {'id': 2, 'isDone': true, 'title': 'Cook Food'},
    {'id': 3, 'isDone': false, 'title': 'Read Book'},
    {'id': 4, 'isDone': false, 'title': 'Work on project'},
    {'id': 5, 'isDone': false, 'title': 'Eat food'} */
  ];
  final db = FirebaseFirestore.instance;
  final String todoCollection = 'Todos';

  Future populateTodos() async {
    // db.collection(todoCollection).get();
    final fbTodos = await db.collection(todoCollection).get();
    fbTodos.docs.forEach((doc) {
      todos.add(doc.get('name'));
    });
    /* final todoList = fbTodos.docs;
    for (var todo in todoList) {
      todos.add(todo.get('name'));
    } */
    notifyListeners();
  }


  addTodo(Map<String, dynamic> todo) async {
    todos.add(todo);

    db.collection(todoCollection).add(todo);

    notifyListeners();
  }

  deleteTodo(todo) async {
    // todos.removeWhere((todo) => todo['id'] == id);
    todos.remove(todo);
    db.collection(todoCollection).doc(todo.key).delete();

    /* db.collection(todoCollection).doc()  
    .collection("messages").doc(snapshot.data.documents[todo][id])
    .delete(); */

    /* Firestore.instance.collection("chats").document("ROOM_1")  
    .collection("messages").document(snapshot.data.documents[index]["id"])
    .delete(); */
    notifyListeners();
  }

  setDone(todo) async {
    todo['isDone'] = !todo['isDone'];
    db.collection(todoCollection).doc(todo.key).update(todo);
    notifyListeners();
  }
}*/
  
  
  /* Future populateTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.getStringList("todos") ??
    if (prefs.getStringList("todos") != null) {
      prefs.getStringList("todos")!.forEach((todo) {
        final Map<String, dynamic> decodedTodo = json.decode(todo);
        todos.add(decodedTodo);
      });
      notifyListeners();
    }

    // final encodePref = json.encode(prefs.getStringList("todos")!);
    // todos.addAll(encodePref);
  }

  addTodo(Map<String, dynamic> todo) async {
    todos.add(todo);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final todoList = todos.map((todo) => json.encode(todo)).toList();
    // final todoStr = json.encode(todos);
    prefs.setStringList("todos", todoList);
    notifyListeners();
  }

  deleteTodo(todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todos.remove(todo);
    // todos.removeWhere((todo) => todo['id'] == 'id');
    // final todoStr = json.encode(todos);
    final todoList = todos.map((todo) => json.encode(todo)).toList();
    prefs.setStringList("todos", todoList);
    notifyListeners();
  }

  setDone(todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todo["isDone"] = !todo["isDone"];
    // final todoStr = json.encode(todos);
    final todoList = todos.map((todo) => json.encode(todo)).toList();
    prefs.setStringList("todos", todoList);
    notifyListeners();
  }
 */

/* class TodoModel {
  final String? title;
  final String? description;
  final bool isDone;

  TodoModel({this.title, this.description, this.isDone = false});
} */
