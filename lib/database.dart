import 'package:http/http.dart' as http;
import 'dart:convert';

class TweetImage {
  final String mediaKey;
  final String type;
  final String url;

  TweetImage({
    required this.mediaKey,
    required this.type,
    required this.url,
  });

  factory TweetImage.fromJson(Map<String, dynamic> json) {
    return TweetImage(
      mediaKey: json['media_key'],
      type: json['type'],
      url: json['url'],
    );
  }
}

class TweetData {
  final String id;
  // final List<TweetImage> images;
  final String text;
  final TweetImage media;

  TweetData({
    required this.id,
    required this.text,
    required this.media,
  });

  factory TweetData.fromJson(Map<String, dynamic> json) {
    // var imgs = json['images'];
    // List<TweetImage> newImages = [];
    // for (var i = 0; i<imgs.length; i++) {
    //   newImages.add(TweetImage.fromJson(imgs[i]));
    // }

    return TweetData(
      id: json['id'],
      text: json['text'],
      media: TweetImage.fromJson(json['media']),
    );
  }
}

class TopTweetList {
  final List<TweetData> topTweets;

  TopTweetList({
    required this.topTweets
  });

  factory TopTweetList.fromJson(Map<String, dynamic> json) {
    var tweets = json['top_tweets'];
    List<TweetData> newTweets = [];
    for (var i = 0; i<tweets.length; i++) {
      newTweets.add(TweetData.fromJson(tweets[i]));
    }
    // newTweets.shuffle();
    return TopTweetList(
      topTweets: newTweets,
    );
  }
}

Future<TopTweetList> fetchTweetData() async {
  final response = await http.get(Uri.parse(
      'https://giant-fridge-92b65-default-rtdb.firebaseio.com/data.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("FOUND DATA ${response.body}");
    var td = TopTweetList.fromJson(jsonDecode(response.body));
    print("td : $td");
    return TopTweetList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
