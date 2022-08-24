import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jokes_for_geeks/models/api_response.dart';

// -------------Get Any Joke---------------
Future getAnyJoke(String uri) async {
  var url = Uri.parse(uri);
  ApiResponse api_response = ApiResponse();
  try{
    final response = await http.get(url);

    switch (response.statusCode) {
      case 404:
        api_response.error = "Not Found";
        break;

      case 200:
        api_response.data = jsonDecode(response.body);
        break;

      default:
        api_response.error = "Something went wrong";
        break;
    }
  } catch(e){
    api_response.error = "Something went wrong";
  }

  return api_response;
}

// -------------Get Category Joke---------------

Future getCategoryJoke(String category) async {
  var url = Uri.parse("https://v2.jokeapi.dev/joke/$category");
  ApiResponse api_response = ApiResponse();
  try{
    final response = await http.get(url);

    switch (response.statusCode) {
      case 404:
        api_response.error = "Not Found";
        break;

      case 200:
        api_response.data = jsonDecode(response.body);
        break;

      default:
        api_response.error = "Something went wrong";
        break;
    }
  } catch(e){
    api_response.error = "Something went wrong";
  }
}