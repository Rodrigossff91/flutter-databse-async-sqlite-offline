import 'package:flutter/material.dart';
import 'package:flutter_database_async/cadastro.dart';
import 'package:flutter_database_async/splash_screen.dart';

import 'list_async.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/cadastro': (context) => const Cadastro(),
        '/listAsync': (context) => const ListAsync()
      },
      initialRoute: '/',
      title: 'Flutter Database Async',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
