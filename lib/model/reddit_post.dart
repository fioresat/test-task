
class RedditPost {

  int id;
  String nameID;
  String title;
  String picture;
  int ups;
  String selftext;

  RedditPost( {
    this.id = 0,
    required this.nameID,
    required this.ups,
    required this.selftext,
    required this.title,
    required this.picture,
  });
}