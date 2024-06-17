import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:painc/Utils/routes.dart';
import 'package:painc/screens/LoginActivity.dart';
import 'Constants.dart';
import 'Utils.dart';

class ResponseClass {
  static Future<http.Response> callPostApi(
    Map<String, dynamic> jsonData,
    String api,
  ) async {
    final http.Response response = await http.post(
      Uri.parse(api),
      headers: <String, String>{
        'Accept': 'application/json',
        if (Constant.token != '') 'Authorization': 'Bearer ${Constant.token}',
      },
      body: jsonData,
    );
    print(api);
    print(response.statusCode);
    //print(Constant.token);
    if (response.statusCode == 401) {
      print('ERROR CODE 401 ##');
      // Utils.removeData();
      // Get.offAllNamed(Routes.login);
      // Navigator.popUntil(context, (route) => route.isFirst);
      // Navigator.pop(context);
      // Navigator.pushNamed(context, Routes.logInActivity);
    } else if (response.body.contains('\'id\' of non-object')) {
      // Utils.removeData();
      // Get.offAllNamed(Routes.login);
      // print('ERROR CODE 401 ##');
      // Utils.removeData();
      Utils.removeData();
      Get.offAll(Login());
      // Navigator.popUntil(context, (route) => route.isFirst);
      // Navigator.pop(context);
      // Navigator.pushNamed(context, Routes.logInActivity);
    }
    return response;
  }

  static Future<http.Response> callGetApi(String api) async {
    final http.Response response = await http.get(
      Uri.parse(api),
      headers: <String, String>{
        'Accept': 'application/json',
        if (Constant.token != '') 'Authorization': 'Bearer ${Constant.token}',
      },
    );
    //print('TOKEN GET API ${Constant.token}');
    print(api);
    //print(response.body);
    print(response.statusCode); //api ma unauthorise ave che aa kyare ave

    if (response.statusCode == 401) {
      print('ERROR CODE 401 ##');
      //Utils.removeData();
      //Get.offAllNamed(Routes.login);
      Utils.removeData();
      Get.offAll(Login());
       //Navigator.popUntil(context, (route) => route.isFirst);
       //Navigator.pop(context);
       //Navigator.pushNamed(context, Routes.login);
    } else if (response.body.contains('\'id\' of non-object')) {
      print('ERROR CODE 401 ##');
      // Utils.removeData();
      // Navigator.popUntil(context, (route) => route.isFirst);
      // Navigator.pop(context);
      // Navigator.pushNamed(context, Routes.logInActivity);
    }

    return response;
  }

  static Future<http.Response> deleteAlbum(int id, String api) async {
    final http.Response response = await http.delete(
      Uri.parse('$api/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${Constant.token}',
        'Content-Type': 'application/json'
      },
    );
    return response;
  }
  static Future callMultipartpost(
      var multipartFile,
      Map<String, dynamic> jsonData,
      String api,
      ) async {
    var request = await http.MultipartRequest('POST',
      Uri.parse(api),
    );
    var headers = {
    'Accept': 'application/json',
    if (Constant.token != '') 'Authorization': 'Bearer ${Constant.token}',
    };
    request.headers.addAll(headers);
    request.fields.addAll(jsonData);
    request.files.add(multipartFile);
    print(api);
    return request;
  }
}
