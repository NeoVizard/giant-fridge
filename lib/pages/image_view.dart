import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giant_fridge/database.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageView extends StatelessWidget {
  ImageView({Key? key, required this.tweetData, required this.heroTag})
      : super(key: key);

  final TweetData tweetData;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.image),
        title: Text("GiantFridge"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Center(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.pop(context),
                      },
                      child: Hero(
                        tag: heroTag,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: const Offset(
                                  0.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Image.network(tweetData.media.url),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth * 0.25),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  tweetData.text.substring(
                                      0,
                                      tweetData.text
                                          .lastIndexOf('https://t.co/')),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () => launch(
                                      "https://twitter.com/u/status/${tweetData.id}"),
                                  icon: Icon(
                                    FontAwesomeIcons.twitterSquare,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
