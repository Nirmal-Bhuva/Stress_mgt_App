class Article_Model {
  final int id;
  final String title;
  final String content; //author;

  Article_Model(
      {required this.id,
      required this.title,
      required this.content /*author*/});

  factory Article_Model.fromJson(Map<String, dynamic> json) {
    return Article_Model(
      id: json['id'],
      title: json['title'],
      content /*author*/ : json['content'], //['author'],
    );
  }
}
