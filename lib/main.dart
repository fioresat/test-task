import 'package:flutter/material.dart';
import 'package:test_task/consts/service_strings.dart';
import 'package:test_task/screen/detailed_screen/detailed_screen.dart';
import 'package:test_task/screen/main_screen/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/service/fetch_helper.dart';

import 'bloc/reddit_posts_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: BlocProvider(
          create: (context) => RedditPostsBloc(
            fetchHelper: FetchHelper(),
          ),
          child: const MainScreen(),
        ),
        routes: {
          ServiceStrings.mainScreenRoute: (context) => const MainScreen(),
          ServiceStrings.detailedScreenRoute: (context) => const DetailedScreen(),
        });
  }
}
