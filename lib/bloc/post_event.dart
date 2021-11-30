part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class FetchPost extends PostEvent {
  final List<Post> oldListPosts;
  final bool isFirstFetch;

  FetchPost({required this.oldListPosts, this.isFirstFetch = false});
}
