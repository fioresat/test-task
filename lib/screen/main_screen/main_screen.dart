import 'package:flutter/material.dart';
import 'package:test_task/bloc/reddit_posts_bloc.dart';
import 'package:test_task/consts/service_strings.dart';
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
    context.read<RedditPostsBloc>().add(
      const LoadRedditPostsEvent(
        url: ServiceStrings.baseUrl,
      ),
    );
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
      body: BlocBuilder<RedditPostsBloc, RedditPostsState>(
        builder: (context, state) {
          if (state is RedditPostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RedditPostsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RedditPostsBloc>().add(
                  const RefreshRedditPostsEvent(
                    url: ServiceStrings.baseUrl,
                  ),
                );
              },
              child: MainScreenWidget(
                  redditPostList: state.redditPosts,
                ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
