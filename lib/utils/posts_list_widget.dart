import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PostsList extends StatefulWidget {
  final data;
  PostsList({Key? key,required this.data}) : super(key: key);

  @override
  _State createState() => _State(this.data);
}

class _State extends State<PostsList> {
  final data;
  _State(this.data);



  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.parse(data['created_at']);
    String formattedDate = DateFormat('MMM dd').format(dateTime);
    final double height =  MediaQuery.of(context).size.height;
    final double width =  MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        /*boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0,3), // changes position of shadow
                          ),
                        ],*/
      ),
      child: Row(
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
                  data["title"].substring(0,1),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
                ),
              )
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(data["title"].length>30?data["title"].substring(0,30)+'...':data["title"],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
              Text(data["contents"].length>30?data["contents"].substring(0,30)+'...':data["contents"],
                style: const TextStyle(
                    fontSize: 14
                ),
              ),
              Row(
                children: [
                  Container(
                    width:width*0.6,
                    child: Row(
                      children: [
                        Icon(Icons.account_circle_outlined,size:14),
                        Text(data["name"],
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width:width*0.2,
                    alignment:Alignment.center,
                    child: Row(
                      children: [
                        Icon(Icons.access_alarms_outlined,size:12),
                        Text(formattedDate,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  )


                ],
              ),
          ]),
        ],
      ),

    );
  }

}