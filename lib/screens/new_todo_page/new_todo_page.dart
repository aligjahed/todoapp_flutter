import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp_bloc/bloc/todo_bloc/todo_bloc.dart';
import 'package:todoapp_bloc/models/dto/new_todo_dto.dart';

class NewTodoPage extends StatelessWidget {
  const NewTodoPage({Key? key, required this.todoBloc}) : super(key: key);
  final TodoBloc todoBloc;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final Size screenSize = MediaQuery.of(context).size;
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Todo'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter a title',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please fill the title";
                  }

                  return null;
                },
              ),
              const Gap(30),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Enter a description',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                  ),
                ),
              ),
              const Gap(35),
              Container(
                width: screenSize.width,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      try {
                        final NewTodoDto todo = NewTodoDto(
                          title: titleController.text,
                          description: descriptionController.text,
                        );
                        todoBloc.add(AddTodo(todo));
                        Navigator.pop<NewTodoPage>(context);
                      } catch (err) {
                        print(err);
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
