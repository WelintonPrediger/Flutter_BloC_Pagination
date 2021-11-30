class Post {
  final int id;
  final String title;
  final String body;

  Post.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        body = json['body'];
}
