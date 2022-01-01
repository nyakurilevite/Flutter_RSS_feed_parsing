import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ViewPost extends StatefulWidget {
  final data;
  ViewPost({Key? key,required this.data}) : super(key: key);

  @override
  _State createState() => _State(this.data);
}

class _State extends State<ViewPost> {
  final data;
  _State(this.data);
  bool liked=false;

  favouritePost() async{
    setState(() {
      liked=liked==true?false:true;
    });
  }



  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.parse(data['created_at']);
    String formattedDate = DateFormat('MMM dd').format(dateTime);
    final double height =  MediaQuery.of(context).size.height;
    final double width =  MediaQuery.of(context).size.width;
    if(data["anonymous"]==1)
      {
        data['name']='Anonymous';
      }

    return Container(
      height: MediaQuery.of(context).size.height,
      child:ListView(
        children: [
          Row(
            children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.blue,
                  ),
                  child:  Center(
                    child: Text(
                      data["name"].substring(0,1),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),
                  )
              ),
              SizedBox(width: 20,),
              Text(data["name"],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
              Spacer(),
              Text(formattedDate,
                style: const TextStyle(
                    fontSize: 14
                ),
              ),
              IconButton(onPressed: ()=>favouritePost(), icon: liked==true?Icon(Icons.favorite_outline_rounded):Icon(Icons.favorite,color: Colors.red,)),
            ],
          ),
          Container(height: 40, child: Divider()),
          Center(
            child: Container(
              child: Text(data['contents'],
                style: const TextStyle(
                    fontSize:16,
                    fontStyle: FontStyle.normal
                ),
              ),
            ),
          )
        ],
      )

    );
  }

}