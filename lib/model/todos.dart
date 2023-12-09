class Todos {
  final int id;
  final String title;
  final bool completed;

  Todos({required this.id, required this.title, required this.completed});

  factory Todos.jsoon(Map<String, dynamic> jsoon) {
    return Todos(
        id: jsoon["id"], title: jsoon["title"], completed: jsoon["completed"]);
  }
}
