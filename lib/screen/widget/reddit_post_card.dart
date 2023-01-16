
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_task/consts/service_strings.dart';
import 'package:test_task/model/reddit_post.dart';

class RedditPostCard extends StatelessWidget {
  final RedditPost redditPostIndexed;
  final void Function() onTap;

  const RedditPostCard({
    required this.redditPostIndexed,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(15),
      color: Colors.white,
      child: ListTile(
        leading: redditPostIndexed.picture.contains(ServiceStrings.imageComparison)
            ? Container(
                width: widthScreen * 0.2,
                height: widthScreen * 0.2,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CachedNetworkImage(
                  imageUrl: redditPostIndexed.picture,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )
            : null,
        title: Text(
          redditPostIndexed.title,
          style: const TextStyle(fontSize: 22),
        ),
        onTap: onTap,
      ),
    );
  }
}
