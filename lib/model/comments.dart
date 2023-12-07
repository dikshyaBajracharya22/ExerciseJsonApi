class Comments {
  final int id;
  final String name;
  final String email;
  final String body;

  Comments(
      {required this.id,
      required this.name,
      required this.email,
      required this.body});

  factory Comments.jsonn(Map<String, dynamic> jsonn) {
    return Comments(
        id: jsonn["id"],
        name: jsonn["name"],
        email: jsonn["email"],
        body: jsonn["body"]);
  }
}
