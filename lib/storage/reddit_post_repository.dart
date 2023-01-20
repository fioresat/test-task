import 'package:test_task/model/reddit_post.dart';
import 'package:test_task/service/fetch_helper.dart';

class RedditPostsRepository {
  final _redditPosts = <RedditPost>[];

  Future<dynamic> getRedditPost() async {
    FetchHelper fetchData = FetchHelper();
    var decodedData = await fetchData.getData();
    return decodedData;
  }

  List<RedditPost> get redditPosts => _redditPosts;

  void addNewPost(RedditPost redditPost) {
    _redditPosts.insert(0, redditPost);
  }

  void removePost(int index) {
    _redditPosts.removeAt(index);
  }
}
