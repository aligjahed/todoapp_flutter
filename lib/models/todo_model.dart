class TodoModel {
  TodoModel({
    required this.id,
    required this.title,
    this.description,
    this.isDone,
    required this.createdAt,
    this.editedAt,
  });

  String id;
  String title;
  String? description;
  bool? isDone = false;
  DateTime createdAt;
  DateTime? editedAt;
}
