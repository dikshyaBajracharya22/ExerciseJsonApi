class Notes {
  final int id;
  final String title;
  final String body;

  Notes({required this.id, required this.title, required this.body});

  factory Notes.jsonn(Map<String, dynamic> jsonn) {
    return Notes(id: jsonn["id"], title: jsonn["title"], body: jsonn["body"]);
  }
}
