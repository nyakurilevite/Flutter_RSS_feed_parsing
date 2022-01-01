import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:posts/screens/categories.dart';
import 'package:posts/screens/view_post.dart';
import '../utils/post_api.dart';
import '../utils/posts_list_widget.dart';
import '../model/posts.dart';
import '../utils/alert.dart';
import 'package:http/http.dart';



class PostsScreen extends StatefulWidget {
  final String cat_id;
  const PostsScreen({Key? key, required this.cat_id}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<PostsScreen> createState() => _PostsScreenState(this.cat_id);
}

class _PostsScreenState extends State<PostsScreen> {

   String cat_id;
  _PostsScreenState(this.cat_id);
  bool isVisible=false;
  bool checkedValue=false;
  bool _isAlertVisible=false;
   TextEditingController emailController = TextEditingController();
   TextEditingController nameController = TextEditingController();
   TextEditingController titleController = TextEditingController();
   TextEditingController contentsController = TextEditingController();
   TextEditingController anonymousController = TextEditingController();
   var _isLoadingText='Submit';
   var _alertMessage=Alert(message:'Please wait...',type:'success');


  _openPopUp() async
  {
    setState(() {
      isVisible=isVisible==true?false:true;
    });
  }

   SubmitPostEntry() async{

     setState(() {
       _isLoadingText = 'Please wait ...';
       _showAlert(false);
     });
     final data = Posts(
       email: emailController.text,
       name: nameController.text,
       title: titleController.text,
       contents:contentsController.text,
       anonymous:checkedValue,
       category_id:this.cat_id
     );

     var sentData = await PostsApi.createPost(data);
     var getData = jsonDecode(sentData);
     print(getData);
     if (getData == 200) {
       _isLoadingText = 'Submit';
       setState(() {
         _isAlertVisible = true;
       });
       _showAlert(false);
       _alertMessage =
           Alert(message: 'New post entry is successfully created', type: 'success');
       clearForm();
     }
     else
       {
         _isLoadingText = 'Submit';
         setState(() {
           _isAlertVisible = true;
         });
         _showAlert(false);
         _alertMessage =
             Alert(message: 'Failed to send post entry', type: 'danger');
       }
   }

   _showAlert(status) async
   {
     Future.delayed(const Duration(seconds:7),(){
       if(mounted){
         setState(() {
           _isAlertVisible=status;
         });
       }
     });
   }
   clearForm(){
    setState(() {
      emailController.text='';
      nameController.text='';
      titleController.text='';
      contentsController.text='';
    });
   }

   Widget _createPostPanel()
   {
     return Visibility (
         visible: isVisible?true:false,
         child:Container(
           // Provide an optional curve to make the animation feel smoother.
           margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
           decoration: const BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.only(
               topRight: Radius.circular(30.0),
               topLeft: Radius.circular(30.0),
             ),
             boxShadow: [
               BoxShadow(
                 color: Colors.blueAccent,
                 blurRadius: 25.0, // soften the shadow
                 spreadRadius: 5.0, //extend the shadow
                 offset: Offset(
                   15.0, // Move to right 10  horizontally
                   15.0, // Move to bottom 10 Vertically
                 ),
               )
             ],
           ),
           child: ListView(
             padding:const EdgeInsets.only(top: 10) ,
             children:  [
               Row(
                 children: [
                   IconButton(
                     icon:  const Icon(Icons.close),
                     onPressed: () {
                       setState(() {
                         isVisible=isVisible==true?false:true;
                       });
                     },
                     color: Colors.blue,
                   ),
                   const Spacer(),
                   const Text(
                     'Create post entry',
                     style: TextStyle(
                         color: Colors.blue,
                         fontWeight: FontWeight.w200,
                         fontSize: 25),

                   ),
                   Spacer(),
                 ],
               ),
               Container(
                   height:MediaQuery.of(context).size.height*0.6 ,
                 child: ListView(
                   children: <Widget>[
                     Container(

                       padding: const EdgeInsets.all(10),
                       child: TextField(
                         decoration: const InputDecoration(
                           prefixIcon: Icon(Icons.account_circle_outlined),
                           border: OutlineInputBorder(
                           ),
                           labelText: 'Enter your names',

                         ),
                         controller: nameController,

                       ),
                     ),
                     Container(

                       padding: const EdgeInsets.all(10),
                       child: TextField(
                         decoration: const InputDecoration(
                           prefixIcon: Icon(Icons.alternate_email ),
                           border: OutlineInputBorder(
                           ),
                           labelText: 'Enter your email',

                         ),
                         controller: emailController,

                       ),
                     ),
                     Container(

                       padding: const EdgeInsets.all(10),
                       child: TextField(
                         decoration: const InputDecoration(
                           prefixIcon: Icon(Icons.short_text_outlined ),
                           border: OutlineInputBorder(
                           ),
                           labelText: 'Enter contents title',

                         ),
                         controller: titleController,

                       ),
                     ),
                      Container(

                       padding: const EdgeInsets.all(10),
                        child: TextField(
                       keyboardType: TextInputType.multiline,
                       textInputAction: TextInputAction.newline,
                       minLines: 1,
                       maxLines: 7,
                       decoration: const InputDecoration(
                         prefixIcon: Icon(Icons.short_text_outlined ),
                         border: OutlineInputBorder(
                         ),
                         labelText: 'Enter post contents',
                       ),
                          controller: contentsController,
                     )),
                     Container(
                         child:Row(
                           children: <Widget>[
                           SizedBox(width: 10,),
                          Text('Anonymous: ',style: TextStyle(fontSize: 17.0), ),
                          Checkbox(
                          checkColor: Colors.greenAccent,
                          activeColor: Colors.red,
                          value: checkedValue,
                           onChanged: (newValue) {
                            setState(() {
                            checkedValue = newValue!;
                            });
                          },
                          ),
                        ],
                      )


                     ),
                     SizedBox(
                         width: 100,
                         height: 100,
                         child:Row(
                           mainAxisAlignment:MainAxisAlignment.start,
                         children: [
                           MaterialButton(
                             height: 40.0,
                             minWidth: MediaQuery.of(context).size.width*0.45,
                             color: Theme.of(context).primaryColor,
                             textColor: Colors.white,
                             child: new Text("Clear"),
                             onPressed: () => clearForm(),
                             splashColor: Colors.redAccent,
                           ),
                           Spacer(),
                           MaterialButton(
                             height: 40.0,
                             minWidth:MediaQuery.of(context).size.width*0.45,
                             color: Theme.of(context).primaryColor,
                             textColor: Colors.white,
                             child: Text(_isLoadingText),
                             onPressed: () => SubmitPostEntry(),
                             splashColor: Colors.redAccent,
                           )
                         ],
                         ) ),],
                 )
               )


             ],
           ),
         )
     );
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Select Posts'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => FirstScreen(title: '')
                )
            );
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: PostsApi.loadPosts(cat_id),
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
                        child:PostsList(data: snapshot.data![index])
                    )
                ),
              )
                  : Center(
                child: CircularProgressIndicator(),
              )),
          _createPostPanel(),
          Container(
           // padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.94),
            child:Visibility(
                visible:_isAlertVisible,
                child: _alertMessage
            )
          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()=>_openPopUp(),
        tooltip: 'Increment',
        child: isVisible==true?Icon(Icons.close):Icon(Icons.add),
      ),

    );
  }
}
