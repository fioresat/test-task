import 'package:flutter/material.dart';
import 'package:test_task/screen/detailed_screen/detailed_screen.dart';
import 'package:test_task/screen/main_screen/main_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const MainScreen(),
       // initialRoute: '/main_screen',
        routes: {
          '/main_screen': (context) => const MainScreen(),
          '/detailed_screen': (context) => const DetailedScreen(),
        });
  }
}
