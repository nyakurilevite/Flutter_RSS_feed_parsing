import 'package:flutter/material.dart';


class CategoriesList extends StatefulWidget {
  String category_name;
  CategoriesList({Key? key,required this.category_name}) : super(key: key);

  @override
  _State createState() => _State(this.category_name);
}

class _State extends State<CategoriesList> {
  String category_name;
  _State(this.category_name);





  @override
  Widget build(BuildContext context) {
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
                  category_name.substring(0,1),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
                ),
              )
          ),
          SizedBox(width: 10,),
          Text(category_name,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16
            ),
          ),
          Spacer(),
          Icon(Icons.chevron_right_outlined)
        ],
      ),

    );
  }

}