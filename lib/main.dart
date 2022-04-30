import 'package:flutter/material.dart';
import 'package:store_challenge/src/view/create_view.dart';
import 'package:store_challenge/src/view/favorites_view.dart';
import 'package:store_challenge/src/view/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      routes: {
        '/list': (context) => const ListProductsView(),
        '/create': (context) => CreateView(),
        '/favorites': (context) => FavoritesView(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListProductsView(),
    );
  }
}
