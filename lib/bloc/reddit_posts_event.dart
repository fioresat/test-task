part of 'reddit_posts_bloc.dart';

@immutable
abstract class RedditPostsEvent {
  const RedditPostsEvent();
}

@immutable
class LoadRedditPostsEvent implements RedditPostsEvent {
  final String url;

  const LoadRedditPostsEvent({required this.url}) : super();
}

@immutable
class RefreshRedditPostsEvent implements RedditPostsEvent {
  final String url;

  const RefreshRedditPostsEvent({required this.url}) : super();
}