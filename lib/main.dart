import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_bloc/bloc/todo_bloc/todo_bloc.dart';
import '/screens/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TodoBloc())
        ],
        child: const HomePage(),
      ),
    );
  }
}
