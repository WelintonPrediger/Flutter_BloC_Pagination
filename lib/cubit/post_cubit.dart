// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:pagination_app/data/data_export.dart';
// import 'package:pagination_app/data/models/post.dart';
//
// part 'post_state.dart';
//
// class PostCubit extends Cubit<PostState> {
//   PostCubit() : super(PostInitial());
//
//   int page = 1;
//   final PostRepository repository = PostRepository();
//
//   void loadPosts() {
//     if (state is PostsLoading) return;
//
//     final currentState = state;
//     var oldPosts = <Post>[];
//
//     if (currentState is PostsLoaded) {
//       oldPosts = currentState.posts;
//     }
//
//     emit(PostsLoading(oldPosts: oldPosts, isFirstFetch: page == 1));
//
//     repository.fetchPosts(page).then((newPosts) {
//       page++;
//
//       final posts = (state as PostsLoading).oldPosts;
//       posts.addAll(newPosts);
//
//       emit(PostsLoaded(posts: posts));
//     });
//   }
// }
