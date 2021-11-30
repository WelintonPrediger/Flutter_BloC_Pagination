import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_app/bloc/post_bloc.dart';
import 'package:pagination_app/cubit/post_cubit.dart';
import 'package:pagination_app/data/data_export.dart';
import 'package:pagination_app/data/services/post_services.dart';
import 'package:pagination_app/views/views_export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagination App Flutter Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => PostBloc(0, PostRepository(PostService())),
        child: PostPage(),
      ),
      /// Cubit bloc
      // home: BlocProvider(
      //   create: (context) => PostCubit(),
      //   child: PostPage(),
      // ),
    );
  }
}
