import 'package:pagination_app/data/models/post.dart';
import 'package:pagination_app/data/services/post_services.dart';

class PostRepository {
  final PostService service;

  PostRepository(this.service);

  Future<List<Post>> fetchPosts(int page) async {
    final posts = await service.fetchPosts(page);
    return posts.map((post) => Post.fromJson(post)).toList();
  }
}
