part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
  final List<TodoModel> allTodos;

  const TodoState({required this.allTodos});
}

class TodoInitial extends TodoState {
  TodoInitial() : super(allTodos: <TodoModel>[]);
}

class TodosLoading extends TodoState{
  const TodosLoading({required super.allTodos});
}

class TodosLoaded extends TodoState {
  final List<TodoModel> todos;

  const TodosLoaded({required this.todos}) : super(allTodos: todos);
}
