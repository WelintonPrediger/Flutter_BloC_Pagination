import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

class PostService {
  static const fetchLimit = 15;
  final baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<dynamic>> fetchPosts(int page) async {

    try {
      final response =
          await get(Uri.parse(baseUrl + "?_limit=$fetchLimit&_page=$page"));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (error) {
      return [];
    }
  }
}
