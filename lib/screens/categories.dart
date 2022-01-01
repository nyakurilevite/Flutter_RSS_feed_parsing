import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/categories_api.dart';
import '../utils/categories_list.dart';
import '../screens/posts.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';


import 'package:http/http.dart';



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


 @override
  void initState() {
    //myBanner.load();
    super.initState();
  }

  //final AdWidget adWidget = AdWidget(ad: myBanner);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Categories'),
          centerTitle: true,
        ),
        body:Stack(
          children: [
            FutureBuilder(
                future: CategoriesApi.loadData(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) => Card(
                      margin: const EdgeInsets.all(10),
                      child:GestureDetector(
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder:
                                  (context) => PostsScreen(cat_id: snapshot.data![index]['id'].toString())
                              )
                          ),
                          child:CategoriesList(category_name: snapshot.data![index]['category_name'])
                      )
                  ),
                )
                    : Center(
                  child: CircularProgressIndicator(),
                )),
            Visibility(
              visible: isAdVisible,
                child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.73),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(
                            color: Colors.black,
                            width: 1
                        )
                    ),
                    child:ListView(
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            IconButton(
                              icon:  const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  isAdVisible=isAdVisible==true?false:true;
                                });
                              },
                              color: Colors.blue,
                            ),

                          ],
                        ),
                        const Center(
                          child:Text(
                            'Place  Ad here',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                fontSize: 20
                            ),
                          ),
                          //padding:EdgeInsets.all(10),
                        )
                      ],
                    )
                )
            )

          ],
        ) ,

    );
  }
}
