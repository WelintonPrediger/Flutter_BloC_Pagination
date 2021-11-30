import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pagination_app/data/data_export.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  int page;
  final PostRepository _postRepository;

  PostBloc(this.page, this._postRepository) : super(PostInitial()) {

    on<PostEvent>((event, emit) {});

    on<FetchPost>((event, emit) {
      page++;
      return _fetchPosts(event, emit);
    });

  }

  Future<void> _fetchPosts(FetchPost event, Emitter<PostState> emit) async {
    log('Current Page: $page');
    emit(PostLoading());
    final posts = event.oldListPosts;
    final newPosts = await _postRepository.fetchPosts(page);
    posts.addAll(newPosts);
    emit(PostLoaded(listPosts: posts, page: page));

  }
}


