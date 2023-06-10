import 'package:exam_notes/src/ui/addProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.initialRoute}) : super(key: key);
  final String initialRoute;

  final _routes = [
    GoRoute(path: "/home", builder: (context, state) => const Home()),
    GoRoute(path: "/addProduct", builder: (context, state) => AddProduct())
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: MaterialApp.router(
            routerConfig:
                GoRouter(initialLocation: initialRoute, routes: _routes)));
  }
}
