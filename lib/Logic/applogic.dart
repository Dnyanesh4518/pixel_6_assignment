import 'dart:convert';
import 'dart:io';
import 'package:pixel_6/models/UserList.dart';
import 'package:http/http.dart' as http;

class AppLogic {
  static Future<UserList?> getUserList(int limit) async {
    // This will try to fetch data from api with default limit of 10 records
    try {
      var response =
          await http.get(Uri.parse("https://dummyjson.com/users?limit=$limit"));
      if (response.statusCode == 200) {
        // This will assign the data from json response to the model which is created based on demo api response
        return UserList.fromJson(jsonDecode(response.body));
      }
    } on SocketException catch (e) {
      throw Exception();
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
