import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  Alert({required this.message, required this.type });
  final String message;
  final String type;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
          decoration:  BoxDecoration(
            //borderRadius: const BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10)),
            color: (type=='success')?Colors.green:(type=='info')?Colors.blueAccent:(type=='danger')?Colors.redAccent:Colors.yellowAccent,
          ),
          child:Center(
              child:Row(
                children: [
                  /*IconButton(
                      icon:  const Icon(Icons.close),
                      onPressed: () {

                      },
                      color: Colors.blue,
                    ),*/
                  SizedBox(width: width*0.2),
                  const Icon(Icons.info_outline_rounded),
                  const SizedBox(width: 10,),
                  Text(message,
                      style: const TextStyle(fontSize: 15,color:Colors.white)),
                ],
              )),

          width:width,
          height:50
      ),
    );
  }
}


