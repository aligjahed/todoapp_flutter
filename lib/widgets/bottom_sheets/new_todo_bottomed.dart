import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp_bloc/bloc/todo_bloc/todo_bloc.dart';
import 'package:todoapp_bloc/models/dto/new_todo_dto.dart';
import 'package:uuid/uuid.dart';

class NewTodoBottomed extends StatefulWidget {
  const NewTodoBottomed({super.key, required this.todoBloc});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TodoBloc todoBloc;

  @override
  State<NewTodoBottomed> createState() => _NewTodoBottomedState();
}

class _NewTodoBottomedState extends State<NewTodoBottomed> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    final Size screenSize = MediaQuery.of(context).size;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: SizedBox(
        height: 350,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Todo',
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // titleController.text = '';
                      // descriptionController.text = '';
                    },
                    child: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Form(
                key: NewTodoBottomed._formKey,
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
                          return 'Please fill this field';
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
                    const Gap(30),
                    Container(
                      width: screenSize.width,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (NewTodoBottomed._formKey.currentState!.validate()) {
                            try {
                              final NewTodoDto newTodo = NewTodoDto(
                                title: titleController.text,
                                description: descriptionController.text,
                              );

                              print(newTodo.title);
                              widget.todoBloc.add(AddTodo(newTodo));

                              Navigator.pop(context);
                              // titleController.text = '';
                              // descriptionController.text = '';
                            } catch (err) {
                              print(err);
                            }
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
