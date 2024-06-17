import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:painc/DashboardActivity/PainIntensityInsertionActivity.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/Utils/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
class PainLocation_Insertion extends GetxController{

  ScreenshotController frontscreenshotController = ScreenshotController();
  Uint8List frontimageFile;
  Uint8List backimageFile;
  void insertdata() async{
    frontscreenshotController.capture().then((Uint8List image) {
        frontimageFile = image;
        update();
    }).catchError((onError) {
      print(onError);
    });
    var request = http.MultipartRequest("POST", Uri.parse(ApiSheet.painlocation_imgupload));
    var multipartFile = http.MultipartFile.fromBytes(
      'image', (frontimageFile.buffer.asUint8List()),
      filename: 'anatomy.jpg', // use the real name if available, or omit
    );
    var headers = {'Authorization': 'Bearer ${Constant.token}'};
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    request.fields['imageofor'] = 'back';
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responsestring = String.fromCharCodes(responseData);
    print(responsestring);
  }
}

