part of 'reddit_posts_bloc.dart';

@immutable
abstract class RedditPostsState {
  const RedditPostsState();
}

class RedditPostsInitial extends RedditPostsState {}

class RedditPostsLoading extends RedditPostsState {}

class RedditPostsLoaded extends RedditPostsState {
  final List<RedditPost> redditPosts;

  const RedditPostsLoaded({required this.redditPosts});
}
