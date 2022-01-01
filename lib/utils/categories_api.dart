import 'dart:convert';

import '../model/categories.dart';
import '../utils/url.dart';
import 'package:http/http.dart';

class CategoriesApi {

  var url= apiUrl.API_URL;

  static Future<List> loadData() async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      const API = 'http://post-entries.herokuapp.com/api/categories';

      final  response = await get(Uri.parse(API));
      posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }

    return posts;
  }

  Future<List<Category>> getPostById(String id) async {
    final response = await get(Uri.parse(url+'categories/'+id)
    );

    List<dynamic> body = jsonDecode(response.body);
    List<Category> category = body.map((dynamic item) => Category.fromJson(item)).toList();
    return category;
  }

  Future<String> createCategory(Category category) async {
    Map data = {
      'categories_name': category.categories_name,
    };

    final Response response = await post(Uri.parse(
        url+'categories/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    String statuscode="${response.statusCode}";
    return statuscode;
  }

}