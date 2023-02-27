import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:test_task/model/reddit_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchHelper {
  // Future<List<RedditPost>> getRedditPosts(String url) async {
  //   return HttpClient()
  //       .getUrl(Uri.parse(url))
  //       .then((request) => request.close())
  //       .then((response) => response.transform(utf8.decoder).join())
  //       .then((stringData) =>
  //           json.decode(stringData)['data']['children'] as List<dynamic>)
  //       .then((redditData) =>
  //           redditData.map((e) => RedditPost.fromJson(e['data'])).toList());
  // }

  Future<List<RedditPost>> getRedditPosts(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      String stringData = await response.transform(utf8.decoder).join();
      prefs.setString('cache', (stringData));
      List<dynamic> redditData =
          json.decode(stringData)['data']['children'] as List<dynamic>;
      List<RedditPost> redditPost =
          redditData.map((e) => RedditPost.fromJson(e['data'])).toList();
      return redditPost;
    } on SocketException catch (_) {
      List<dynamic> redditData = json.decode(prefs.getString('cache')!)['data']
          ['children'] as List<dynamic>;
      List<RedditPost> redditPost =
          redditData.map((e) => RedditPost.fromJson(e['data'])).toList();
      return redditPost;
    }
  }
}
