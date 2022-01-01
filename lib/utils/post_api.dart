import 'dart:convert';

import '../model/posts.dart';
import '../utils/url.dart';
import 'package:http/http.dart';

class PostsApi {

  var url= apiUrl.API_URL;

  static Future<List> loadPosts(cat_id) async {
    List postsList = [];
    try {
      // This is an open REST API endpoint for testing purposes
      var API = 'http://post-entries.herokuapp.com/api/posts?categories_id='+cat_id;

      final  response = await get(Uri.parse(API));

      postsList = json.decode(response.body);
      //print(postsList);
    } catch (err) {
      print(err);
    }

    return postsList;
  }

  static Future<List> viewPost(post_id) async {
    List postsList = [];
    try {
      // This is an open REST API endpoint for testing purposes
      var API = 'http://post-entries.herokuapp.com/api/posts/'+post_id;

      final  response = await get(Uri.parse(API));

      postsList = json.decode(response.body);

    } catch (err) {
      print(err);
    }

    return postsList;
  }

  static Future<String> createPost(Posts posts) async {
    Map data = {
      'name': posts.name,
      'email': posts.email,
      'title': posts.title,
      'contents':posts.contents,
      'categories_id':posts.category_id,
      'anonymous':posts.anonymous
    };

    print(data);

    final Response response = await post(Uri.parse(
        'http://post-entries.herokuapp.com/api/posts/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      body:jsonEncode(data),
    );

    String statuscode="${response.statusCode}";
      return statuscode;

  }

  Future<String> updatePost(Posts posts) async {
    Map data = {
      'id': posts.id,
      'name': posts.name,
      'email': posts.email,
      'title': posts.title,
      'contents':posts.contents,
      'categories_id':posts.category_id
    };

    final Response response = await post(Uri.parse(
        url+'posts/'+data['id']),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    String statuscode="${response.statusCode}";
    return statuscode;

  }

}