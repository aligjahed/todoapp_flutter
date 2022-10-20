part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  AddTodo(this.todo);
  final NewTodoDto todo;
}
class EditTodo extends TodoEvent {
  EditTodo(this.todo);
  final EditTodoDto todo;
}
class TodoIsDone extends TodoEvent {
  TodoIsDone(this.id);
  final String id;
}
class RemoveTodo extends TodoEvent {
  RemoveTodo(this.id);
  final String id;
}
