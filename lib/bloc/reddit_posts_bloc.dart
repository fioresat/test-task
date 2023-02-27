import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task/model/reddit_post.dart';
import 'package:test_task/service/fetch_helper.dart';

part 'reddit_posts_event.dart';

part 'reddit_posts_state.dart';

class RedditPostsBloc extends Bloc<RedditPostsEvent, RedditPostsState> {
  final FetchHelper fetchHelper;

  RedditPostsBloc({
    required this.fetchHelper,
  }) : super(RedditPostsInitial()) {
    List<RedditPost> redditPosts = [];
    on<LoadRedditPostsEvent>((event, emit) async {
      emit(RedditPostsLoading());
      final url = event.url;
      redditPosts = await fetchHelper.getRedditPosts(url);
      emit(RedditPostsLoaded(redditPosts: redditPosts));
    });
    on<RefreshRedditPostsEvent>((event, emit) async {
      final url = event.url;
      List<RedditPost> uploadedRedditPosts =
          await fetchHelper.getRedditPosts(url);

      if (redditPosts.isNotEmpty &&
          redditPosts[0].title != uploadedRedditPosts[0].title) {
        redditPosts = uploadedRedditPosts;
        emit(RedditPostsLoaded(redditPosts: redditPosts));
      }
    });
  }
}
