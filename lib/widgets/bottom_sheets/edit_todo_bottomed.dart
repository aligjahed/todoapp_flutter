import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp_bloc/bloc/todo_bloc/todo_bloc.dart';
import 'package:todoapp_bloc/models/dto/new_todo_dto.dart';
import 'package:uuid/uuid.dart';

import '../../models/dto/edit_todo_dto.dart';
import '../../models/todo_model.dart';

class EditTodoBottomed extends StatefulWidget {
  const EditTodoBottomed(
      {super.key, required this.todoBloc, required this.reqTodo});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TodoBloc todoBloc;
  final TodoModel reqTodo;

  @override
  State<EditTodoBottomed> createState() => _EditTodoBottomedState();
}

class _EditTodoBottomedState extends State<EditTodoBottomed> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController ;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.reqTodo.title);
    descriptionController = TextEditingController(text: widget.reqTodo.description);
  }

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    final Size screenSize = MediaQuery
        .of(context)
        .size;

    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Todo',
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
              key: EditTodoBottomed._formKey,
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
                          borderSide: BorderSide(
                              color: Colors.purple, width: 2),
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
                        if (EditTodoBottomed._formKey.currentState!.validate()) {
                          try {
                            final EditTodoDto newTodo = EditTodoDto(
                              id: widget.reqTodo.id,
                              title: titleController.text,
                              description: descriptionController.text,
                            );

                            widget.todoBloc.add(EditTodo(newTodo));

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
    );
  }
}
