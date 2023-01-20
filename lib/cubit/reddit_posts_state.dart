part of 'reddit_posts_cubit.dart';

@immutable
abstract class RedditPostsState {
  const RedditPostsState();
}



class RedditPostsLoaded extends RedditPostsState {
  final List<RedditPost> redditPosts;
  const RedditPostsLoaded(this.redditPosts);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RedditPostsLoaded && o.redditPosts == redditPosts;
  }

  @override
  int get hashCode => redditPosts.hashCode;
}


