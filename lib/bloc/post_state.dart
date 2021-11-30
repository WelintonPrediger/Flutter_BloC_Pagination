part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> listPosts;

  final int page;

  PostLoaded({required this.listPosts, required this.page});
}

class PostErrorMessage extends PostState {

  final String message;

  PostErrorMessage({required this.message});
}
