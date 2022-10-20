import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_bloc/bloc/todo_bloc/todo_bloc.dart';
import 'package:todoapp_bloc/screens/home_page/home_page_body.dart';

import '../../widgets/bottom_sheets/new_todo_bottomed.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("To-Do App"),
      ),
      body: const HomePageBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            isDismissible: false,
            isScrollControlled: true,
            builder: (buildContext) => NewTodoBottomed(
              todoBloc: BlocProvider.of<TodoBloc>(context),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
