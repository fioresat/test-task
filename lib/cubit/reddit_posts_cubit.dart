import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task/consts/service_strings.dart';
import 'package:test_task/model/reddit_post.dart';
import 'package:test_task/storage/reddit_post_repository.dart';

part 'reddit_posts_state.dart';

class RedditPostsCubit extends Cubit<RedditPostsState> {
  final RedditPostsRepository _redditPostsRepository;

  RedditPostsCubit(this._redditPostsRepository) : super(const RedditPostsLoaded([]));

  Future<void> getRedditPosts() async {
    final redditData =
    await _redditPostsRepository.getRedditPost();
    if (redditData != null) {
      for (int j = redditData['data']['children'].length - 1; j >= 0; j--) {
        var data = redditData['data']['children'][j]['data'];
        _redditPostsRepository.addNewPost(
          RedditPost.fromJson(data),
        );
      }
      print(ServiceStrings.created);
    } else {
      print(ServiceStrings.creationException);
    }
    final List<RedditPost> redditPosts = _redditPostsRepository.redditPosts;
    emit(RedditPostsLoaded(redditPosts));
  }

  Future<void> refreshRedditPosts() async {
    final redditData = await _redditPostsRepository.getRedditPost();

    int max = indexUpdate(redditData);
    if (max < 25 && max >= 0) {
      for (int i = max; i >= 0; i--) {
        _redditPostsRepository.removePost(i);
      }
      for (int j = redditData['data']['children'].length - 1; j >= 0; j--) {
        var data = redditData['data']['children'][j]['data'];
        _redditPostsRepository.addNewPost(
          RedditPost.fromJson(data),
        );
      }

    } else if (max == -1) {
      for (int j = redditData['data']['children'].length - 1; j >= 0; j--) {
        var data = redditData['data']['children'][j]['data'];
        _redditPostsRepository.addNewPost(
          RedditPost.fromJson(data),
        );
      }

    } else {
      print(ServiceStrings.updateException);
    }
    final List<RedditPost> redditPosts = _redditPostsRepository.redditPosts;
    emit(RedditPostsLoaded(redditPosts));
  }


  int indexUpdate(redditData) {
    int max = 25;

    for (int i = redditData['data']['children'].length - 1; i >= 0; i--) {
      var data = redditData['data']['children']
      [redditData['data']['children'].length - 1]['data'];

      if (_redditPostsRepository.redditPosts[i].nameID == data['name'].toString()) {
        max = i;
        //all posts before this id should be saved, all post after should be updated
        i = -2; // to stop the cycle
      } else {
        max = -1; // all posts are new
      }
    }
    return max;
  }
}
