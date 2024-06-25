import 'dart:convert';
import 'package:dummy_project/utilities/common.dart';
import 'package:http/http.dart' as http;
import 'package:dummy_project/model/user_model.dart';

class ApiService{
  static Future<List<User>> fetchUsersInfo() async{
    final response = await http.get(Uri.parse(Common.url));

    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);

      UserInfo userInfo = UserInfo.fromJson(jsonResponse);
      return userInfo.users;
    }else{
      throw Exception('Error');
    }
  }
}