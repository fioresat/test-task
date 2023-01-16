import 'fetch_helper.dart';
import 'dart:async';

class RedditService {
  Future<dynamic> getRedditPost() async {
    FetchHelper fetchData = FetchHelper();
    var decodedData = await fetchData.getData();
    return decodedData;
  }
}