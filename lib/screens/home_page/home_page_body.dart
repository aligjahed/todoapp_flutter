import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todoapp_bloc/models/todo_model.dart';

import '../../bloc/todo_bloc/todo_bloc.dart';
import '../../widgets/bottom_sheets/edit_todo_bottomed.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodosLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is TodoInitial) {
          return const Center(
            child: Text('No Todos yet'),
          );
        }

        if (state is TodosLoaded) {
          return ListView.builder(
            itemCount: state.allTodos.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.allTodos[index].title,
                                  style: const TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                const Gap(5),
                                Text(
                                  state.allTodos[index].description!.isNotEmpty
                                      ? state.allTodos[index].description!
                                      : "no description",
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0),
                                      ),
                                    ),
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    builder: (builderContext) => EditTodoBottomed(
                                      todoBloc:
                                          BlocProvider.of<TodoBloc>(context),
                                      reqTodo: state.allTodos[index],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.purple,
                                    size: 30,
                                  ),
                                ),
                                const Gap(10),
                                GestureDetector(
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    BlocProvider.of<TodoBloc>(context).add(
                                      RemoveTodo(
                                        state.allTodos[index].id.toString(),
                                      ),
                                    );
                                  },
                                ),
                                const Gap(10),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30,
                                )
                              ],
                            ),
                          ],
                        ),
                        const Gap(10),
                        Text(
                          state.allTodos[index].editedAt.toString().isNotEmpty
                              ? 'Created at: ${state.allTodos[index].createdAt.toString()}'
                              : 'Edited at: ${state.allTodos[index].editedAt.toString()}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
