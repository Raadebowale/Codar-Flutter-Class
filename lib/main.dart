import 'package:flutter/material.dart';

import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

import 'home.dart';

void main() async {
  /*  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final db = FirebaseFirestore.instance;
  db
      .collection('Users')
      .add({
        'name': 'Rasheed',
        'age': 70,
        'isActive': true,
      })
      .then((value) => log('Added Data to Firebase'))
      .catchError((onError) {
        log(onError.toString());
      }); */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo',
        home: Home(),
      ),
    );
  }
}
