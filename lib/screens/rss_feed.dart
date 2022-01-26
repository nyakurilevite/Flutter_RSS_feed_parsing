import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:webfeed/webfeed.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:posts/screens/view_rss_feed.dart';






class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  /*static BannerAd myBanner = BannerAd(
    adUnitId: InterstitialAd.testAdUnitId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );*/
  bool isAdVisible=true;
  bool isLoading=false;
  late RssFeed rss=RssFeed();


 @override
  void initState() {
  loadData();
    super.initState();
  }

   loadData() async {
    try {
      setState(() {
        isLoading=true;
      });

      // This is an open REST API endpoint for testing purposes
      const API = 'https://adeptosdebancada.com/rssfeed?content=articles';
      final  response = await get(Uri.parse(API));
      var channel = RssFeed.parse(response.body);
      setState(() {
        rss=channel;
        isLoading=false;
      });
    } catch (err) {
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
   const transitionType=ContainerTransitionType.fadeThrough;

    return Scaffold(
        appBar: AppBar(
          title: const Text('ADEPTOS'),
          actions:<Widget>[
            ElevatedButton(onPressed: () => loadData(),
             child: Row(
              children: [
                Icon(Ionicons.refresh_circle),
                Text('Refresh')
              ],
            ))
          ],
          centerTitle: true,
        ),
        body:Stack(
          children: [
            isLoading==false?
            ListView.builder(
                             itemCount: rss.items!.length,
                             itemBuilder: (BuildContext context, index) {
                               final item = rss.items![index];
                               final feedItems={
                                 'title':item.title,
                                 'content':item.content!.value,
                                 'creator':item.dc!.creator,
                                 'image':item.media!.contents![0].url,
                                 'link':item.link,
                                 'pubDate':item.pubDate,
                                 'author':item.dc!.creator
                               };
                               print(feedItems);
                               return InkWell(
                                 onTap:() => Navigator.pushReplacement(context,
                                     MaterialPageRoute(builder:
                                         (context) => ViewRssScreen(RssFeed: feedItems)
                                     )
                                 ),
                                 child: ListTile(
                                   leading:  Image(image: CachedNetworkImageProvider(
                                       item.media!.contents![0].url.toString())),
                                   title: Text(item.title.toString()),
                                   subtitle:Row(
                                     children: [
                                       Icon(Ionicons.time_outline),
                                       Text(DateFormat('MMM dd').format(
                                           DateTime.parse(
                                               item.pubDate.toString()))),
                                       Spacer(),
                                       Icon(Ionicons.person_outline),
                                       Text(item.dc!.creator.toString())
                                     ],
                                   ) ,
                                 )
                               );
                             }

                         )
                :
            Center(child: CircularProgressIndicator(),),

          ],
        ) ,

    );
  }
}
