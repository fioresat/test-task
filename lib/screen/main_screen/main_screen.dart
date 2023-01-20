import 'package:flutter/material.dart';
import 'package:test_task/consts/service_strings.dart';
import 'package:test_task/cubit/reddit_posts_cubit.dart';
import 'package:test_task/screen/widget/mains_screen_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RedditPostsCubit>(context).getRedditPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ServiceStrings.appName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh:
            BlocProvider.of<RedditPostsCubit>(context).refreshRedditPosts,
        child: BlocBuilder<RedditPostsCubit, RedditPostsState>(
          builder: (context, state) {
            if (state is RedditPostsLoaded) {
              return MainScreenWidget(
                redditPostList: state.redditPosts,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
