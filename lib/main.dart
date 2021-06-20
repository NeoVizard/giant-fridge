import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giant_fridge/pages/image_view.dart';
import 'package:giant_fridge/pages/test_view.dart';
import 'package:page_transition/page_transition.dart';
import 'database.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GiantFridge',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        fontFamily: 'Lobster',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<TopTweetList> tweetData;
  final int tweetCount = 7;
  final String lorem200 =
      "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Doloribus sequi architecto officiis dolorum quaerat fugiat odit maiores ullam iusto rerum. Sit iusto error maxime odio, aspernatur, iure saepe ab repellendus id exercitationem, molestiae perspiciatis. Quibusdam provident odit iste ad fugit fugiat adipisci repellendus vel voluptatem nam est quas, harum corrupti animi placeat perferendis ipsa ut distinctio amet pariatur. Aperiam error commodi reiciendis aspernatur, ullam consequuntur quas sit illo facilis pariatur, officiis, natus ratione quia reprehenderit cum voluptate quam voluptatibus similique exercitationem molestiae non. Magni vitae sapiente, vero corporis saepe quidem quos ut delectus placeat omnis quod ad distinctio aperiam tempora totam consequatur eos, obcaecati expedita perspiciatis voluptas culpa. Porro beatae quis molestias praesentium voluptatum facere reiciendis ullam assumenda omnis? Facilis, adipisci possimus nemo voluptas ad deserunt cum nulla quisquam, veritatis laudantium consectetur qui unde rerum veniam culpa minima dicta, nostrum et quae. Inventore voluptatibus corrupti quas sit eligendi cum delectus explicabo veniam tempora numquam consectetur reprehenderit nemo dolore labore ex animi rerum cupiditate nam molestias nesciunt, esse doloribus assumenda laudantium? Ullam molestiae temporibus provident consequatur sit qui magni, necessitatibus tenetur in saepe distinctio amet, soluta libero nostrum possimus dicta illo ab voluptatum exercitationem debitis! Provident autem suscipit deleniti aliquam deserunt?";

  @override
  void initState() {
    super.initState();
    tweetData = fetchTweetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.image),
        title: Center(
            child: Text(
          'GiantFridge',
          style: TextStyle(fontSize: 32),
        )),
        // actions: [
        //   IconButton(
        //       onPressed: () => {
        //             Navigator.push(
        //               context,
        //               PageTransition(
        //                 child: TestView(),
        //                 type: PageTransitionType.fade,
        //               ),
        //             ),
        //           },
        //       icon: Icon(Icons.image_search))
        // ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/bg2.png'),
        //     fit: BoxFit.cover,
        //     alignment: Alignment.topCenter,
        //   ),
        // ),
        child: FutureBuilder(
          future: tweetData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data as TopTweetList;
              List<Container> imageList = [];
              var rng = new Random();
              for (var i = 0; i < tweetCount; i++) {
                imageList.add(Container(
                  width: () {
                    switch (i) {
                      case 0:
                      case 1:
                        return MediaQuery.of(context).size.width * 0.3;
                      case 2:
                        return MediaQuery.of(context).size.width * 0.5;
                      default:
                        return MediaQuery.of(context).size.width * 0.3;
                    }
                  }(),
                  height: () {
                    switch (i) {
                      case 0:
                      case 1:
                        return MediaQuery.of(context).size.height * 0.4;
                      case 2:
                        return MediaQuery.of(context).size.height * 0.4;
                      default:
                        return MediaQuery.of(context).size.height * 0.4;
                    }
                  }(),
                  color: Color.fromARGB(0, 255, 0, 0),
                  child: Transform.rotate(
                    angle: pi / 18 * rng.nextDouble() - pi / 36,
                    child: Center(
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
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: ImageView(
                                  tweetData: data.topTweets[i],
                                  heroTag: 'imageHero$i',
                                ),
                                type: PageTransitionType.fade,
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'imageHero$i',
                            child: Image.network(
                              data.topTweets[i].media.url,
                              scale: 1,
                              repeat: ImageRepeat.noRepeat,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
                // Containers for spacing
                switch (i) {
                  case 2:
                    imageList.add(Container(height: 150.0));
                    break;
                  case 4:
                    imageList.add(Container(width: 1.0, height: 1.0,));
                    break;
                  case 6:
                    imageList.add(Container(height: 50.0));
                    break;
                  default:
                }
              }

              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg2.png'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  height: 2000,
                  padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Wrap(
                              children: imageList,
                              alignment: WrapAlignment.spaceEvenly,
                              runSpacing: 20.0,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            // color: Colors.black,
                            child: Column(
                              children: [
                                Text(
                                  "GiantFridge",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 48.0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Text(
                                    "$lorem200",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      wordSpacing: 2.0,
                                      leadingDistribution:
                                          TextLeadingDistribution.proportional,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // FOOTER
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.teal,
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Contact Us",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.question),
                                  Text(
                                    "About Us",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.github),
                                  Text(
                                    "GitHub",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.twitter),
                                  Text(
                                    "Twitter",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Text("LOADING");
            }
          },
        ),
      ),
    );
  }
}
