import 'package:flutter/material.dart';
import 'package:test_task/model/reddit_post.dart';
import 'package:test_task/model/screen_arguments.dart';
import 'package:test_task/screen/widget/reddit_post_card.dart';

class MainScreenWidget extends StatelessWidget {
  final List<RedditPost> redditPostList;

  const MainScreenWidget({
    required this.redditPostList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: redditPostList.length,
      itemBuilder: (_, int index) {
        var redditPostIndexed = redditPostList[index];
        return RedditPostCard(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/detailed_screen',
              arguments: ScreenArguments(
                title: redditPostIndexed.title,
                ups: redditPostIndexed.ups,
                selftext: redditPostIndexed.selftext,
              ),
            );
          },
          redditPostIndexed: redditPostIndexed,
        );
      },
    );
  }
}
