import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:posts/utils/view_post_widget.dart';
import '../screens/posts.dart';
import '../utils/post_api.dart';
import '../utils/posts_list_widget.dart';
import 'package:http/http.dart';



class ViewPostScreen extends StatefulWidget {
  final String cat_id;
  final String post_id;
  final String post_title;
  const ViewPostScreen({Key? key, required this.cat_id, required this.post_id,required this.post_title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState(this.cat_id,this.post_id,this.post_title);
}

class _ViewPostScreenState extends State<ViewPostScreen> {

  String cat_id;
  String post_id;
  String post_title;
  _ViewPostScreenState(this.cat_id,this.post_id,this.post_title);
  String resp='';

  String id='';
  String name='';
  String title='';
  String contents='';
  String created_at='';
  int anonymous=0;
  bool isAdVisible=true;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(post_title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => PostsScreen(cat_id: cat_id)
                )
            );
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: PostsApi.viewPost(post_id),
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ? ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) => Card(
                    margin: const EdgeInsets.all(10),
                    child:GestureDetector(
                        onTap: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder:
                                (context) => ViewPostScreen(cat_id:cat_id,post_id:snapshot.data![index]['id'].toString(),post_title:snapshot.data![index]['title'])
                            )
                        ),
                        child:ViewPost(data: snapshot.data![index])
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
      )

    );
  }
}
