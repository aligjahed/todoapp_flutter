class EditTodoDto {
  EditTodoDto({
    required this.id,
    required this.title,
    this.description,
    this.isDone,
  });

  final String id;
  final String title;
  final String? description;
  final bool? isDone;
}
