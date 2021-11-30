import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_app/bloc/post_bloc.dart';
import 'package:pagination_app/data/models/post.dart';

class PostPage extends StatelessWidget {
  PostPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  late List<Post> listPosts = [];
  bool isLoading = false;
  int page = 1;

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          /// call the cubit event
          // BlocProvider.of<PostCubit>(context).loadPosts();
          /// call the event bloc default
          BlocProvider.of<PostBloc>(context).add(FetchPost(oldListPosts: listPosts, isFirstFetch: page == 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    setupScrollController(context);

    /// screen with cubit
    // BlocProvider.of<PostCubit>(context).loadPosts();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Posts'),
    //   ),
    //   body: _postList(context),
    // );

    /// screen with Bloc
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: _postList(context),
    );
  }

  Widget _postList(context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {

        log('Current State: $state');

        if(state is PostInitial) {
          BlocProvider.of<PostBloc>(context).add(FetchPost(oldListPosts: listPosts, isFirstFetch: page == 1));

        } else if (state is PostLoading) {
          isLoading = true;

        } else if (state is PostLoaded) {
          isLoading = false;
          listPosts = state.listPosts;
          page = state.page;
        }

        return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < listPosts.length) {
                return _post(listPosts[index], context);
              } else {
                return _loadingIndicator();
              }
            },
            separatorBuilder: (context, index) {
              return Divider(color: Colors.grey[400]);
            },
            itemCount: listPosts.length + (isLoading ? 1 : 0));
      },
    );
  }

  /// Cubit bloc
  // Widget _postList(context) {
  //   return BlocBuilder<PostCubit, PostState>(
  //     builder: (context, state) {
  //       if (state is PostsLoading && state.isFirstFetch) {
  //         return _loadingIndicator();
  //       }
  //       List<Post> posts = [];
  //       bool isLoading = false;
  //
  //       if (state is PostsLoading) {
  //         posts = state.oldPosts;
  //         isLoading = true;
  //       } else if (state is PostsLoaded) {
  //         posts = state.posts;
  //       }
  //
  //       return ListView.separated(
  //           controller: scrollController,
  //           itemBuilder: (context, index) {
  //             if (index < posts.length) {
  //               return _post(posts[index], context);
  //             } else {
  //               Timer(const Duration(milliseconds: 30), () {
  //                 scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //               });
  //               return _loadingIndicator();
  //             }
  //           },
  //           separatorBuilder: (context, index) {
  //             return Divider(color: Colors.grey[400]);
  //           },
  //           itemCount: posts.length + (isLoading ? 1 : 0));
  //     },
  //   );
  // }

  Widget _loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  _scrollAuto() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  Widget _post(Post post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${post.id}. ${post.title}',
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(post.body)
        ],
      ),
    );
  }
}