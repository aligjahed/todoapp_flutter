import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todoapp_bloc/models/dto/edit_todo_dto.dart';
import 'package:todoapp_bloc/models/dto/new_todo_dto.dart';
import 'package:uuid/uuid.dart';

import '../../models/todo_model.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final uuid = const Uuid();

  TodoBloc() : super(TodoInitial()) {
    on<AddTodo>(_onAddTodo);
    on<EditTodo>(_onEditTodo);
    on<TodoIsDone>(_onFinishTodo);
    on<RemoveTodo>(_onRemoveTodo);
  }

  void _onAddTodo(AddTodo event, emit) {
    List<TodoModel> currentTodos = state.allTodos;

    try {
      emit(TodosLoading(allTodos: currentTodos));

      final TodoModel newTodo = TodoModel(
        id: uuid.v4(),
        title: event.todo.title,
        description: event.todo.description,
        isDone: false,
        createdAt: DateTime.now(),
      );

      currentTodos.add(newTodo);
      emit(TodosLoaded(todos: currentTodos));
    } catch (err) {
      if (state.allTodos.isNotEmpty) {
        TodosLoaded(todos: currentTodos);
      } else {
        TodoInitial();
      }
      print(err);
    }
  }

  void _onEditTodo(EditTodo event, emit) {
    List<TodoModel> currentTodos = state.allTodos;
    try {
      emit(TodosLoading(allTodos: currentTodos));

      final reqIndex = currentTodos.indexWhere((e) => e.id == event.todo.id);

      currentTodos[reqIndex].title = event.todo.title;
      currentTodos[reqIndex].description = event.todo.description;
      currentTodos[reqIndex].isDone = event.todo.isDone;
      currentTodos[reqIndex].editedAt = DateTime.now();

      if (state.allTodos.isNotEmpty) {
        emit(TodosLoaded(todos: currentTodos));
      } else {
        emit(TodoInitial());
      }
    } catch (err) {
      TodosLoaded(todos: currentTodos);
      print(err);
    }
  }

  void _onFinishTodo(event, emit) {
    List<TodoModel> currentTodos = state.allTodos;
    try {
      emit(TodosLoading(allTodos: currentTodos));

      final reqIndex = currentTodos.indexWhere((e) => e.id == event.todo.id);
      currentTodos[reqIndex].isDone = true;
      if (state.allTodos.isNotEmpty) {
        emit(TodosLoaded(todos: currentTodos));
      } else {
        emit(TodoInitial());
      }
    } catch (err) {
      TodosLoaded(todos: currentTodos);
      print(err);
    }
  }

  void _onRemoveTodo(RemoveTodo event, emit) {
    List<TodoModel> currentTodos = state.allTodos;
    try {
      emit(TodosLoading(allTodos: currentTodos));
      final reqIndex = currentTodos.indexWhere((e) => e.id == event.id);
      currentTodos.remove(currentTodos[reqIndex]);

      if (state.allTodos.isNotEmpty) {
        emit(TodosLoaded(todos: currentTodos));
      } else {
        emit(TodoInitial());
      }
    } catch (err) {
      TodosLoaded(todos: currentTodos);
      print(err);
    }
  }
}
