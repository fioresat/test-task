import 'package:flutter/material.dart';
import 'package:test_task/consts/service_strings.dart';
import 'package:test_task/service/reddit_service.dart';
import 'package:test_task/screen/widget/reddit_post_card.dart';
import 'package:test_task/storage/screen_arguments.dart';
import 'package:test_task/storage/reddit_post.dart';
import 'package:test_task/storage/reddit_post_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _redditService = RedditService();
  late final _redditPostRepository = RedditPostsRepository();

  late var _redditPosts = _redditPostRepository.redditPosts;

  @override
  void initState() {
    super.initState();
    _create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ServiceStrings.appName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
          itemCount: _redditPosts.length,
          itemBuilder: (_, int index) {
            var redditPostIndexed = _redditPosts[index];
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
        ),
      ),
    );
  }

  void _create() async {
    final dataDecoded = await _redditService.getRedditPost();
    _createData(dataDecoded);
    setState(() {
      _redditPosts = _redditPostRepository.redditPosts;
    });
  }

  void _createData(redditData) {
    setState(() {
      if (redditData != null) {
        addNewPost(redditData);
        print(ServiceStrings.created);
      } else {
        print(ServiceStrings.creationException);
      }
    });
  }

  Future<void> _pullRefresh() async {
    final dataDecoded = await _redditService.getRedditPost();
    _updateData(dataDecoded);
    print(_redditPosts.length);
    setState(() {
      _redditPosts = _redditPostRepository.redditPosts;
    });
  }

  void _updateData(redditData) {
    int max = indexUpdate(redditData);
    if (max < 25 && max >= 0) {
      for (int i = max; i >= 0; i--) {
        _redditPostRepository.removePost(i);
      }
      addNewPost(redditData); // add 25 posts from json
      print(ServiceStrings.updated);
    } else if (max == -1) {
      addNewPost(redditData);
      print(ServiceStrings.updated);
    } else {
      print(ServiceStrings.updateException);
    }
  }

  void addNewPost(redditData) {
    for (int j = redditData['data']['children'].length - 1; j >= 0; j--) {
      var data = redditData['data']['children'][j]['data'];
      _redditPostRepository.addNewPost(RedditPost(
          ups: data['ups'],
          selftext: data['selftext'].toString(),
          title: data['title'].toString(),
          picture: data['thumbnail'].toString(),
          nameID: data['name'].toString()));
    }
  }

  int indexUpdate(redditData) {
    int max = 25;

    for (int i = redditData['data']['children'].length - 1; i >= 0; i--) {
      var data = redditData['data']['children']
          [redditData['data']['children'].length - 1]['data'];

      if (_redditPosts[i].nameID == data['name'].toString()) {
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
