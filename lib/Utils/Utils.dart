import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painc/ApiClass/login.dart';
import 'package:painc/ApiClass/update.dart';
import 'package:painc/DashboardActivity/d.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/SharedPreference.dart';
import 'package:painc/Utils/getpref.dart';
class Utils{
  static var yellow = Color(0xffF1D427);
  static var darkblue = Color(0xff3F3D56);
  static var bottleclr = Color(0xff0ABAB5);
  static var lightbottleclr = Color(0xffE7F8F8);
  static var white = Color(0xffFFFFFF);
  static var black = Color(0xff000000);
  static var grey = Color(0xff5A5A5A);
  static var lightgrey1 = Color(0xFFA8A8A8);
  static var lightgrey2 = Color(0xFFF3F3F3);
  static var darkgrey = Color(0xff484646);
  static var red = Color(0xffE92200);
  static var hintclr = Color(0x442E2E2E);
  static var light = Color(0xffF5FFFF);
  static var green = Color(0xFF82E05D);
  static var orange = Color(0xFFFF9A3D);

  static getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  static getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static Widget imageAssets(String image, double width, double height) {
    return Image.asset(
      image,
      height: height,
      width: width,
      fit: BoxFit.fill,
    );
  }
  static svg(String path,double width, double height){
    return SvgPicture.asset(
      path,width: width,height: height,
    );
  }
  static Widget dot(Color clr,VoidCallback ontap){
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: clr
        ),
      ),
    );
  }
  static Widget sizeBoxHeight(double height) {
    return SizedBox(
      height: height,
    );
  }
  static Widget sizeBoxWidth(double width) {
    return SizedBox(
      width: width,
    );
  }
  static Widget dots(Color c1, VoidCallback tap1,Color c2,VoidCallback tap2, Color c3,VoidCallback tap3){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Utils.dot(c1,tap1),
        Utils.sizeBoxWidth(5.0),
        Utils.dot(c2,tap2),
        Utils.sizeBoxWidth(5.0),
        Utils.dot(c3,tap3),
      ],
    );
  }

  static whitetext(String text, size){
    return Text(text,
        style: TextStyle(
            color: Utils.white,
            fontSize: size,
            fontWeight: FontWeight.bold));
  }
  static btlclrboldtext(String text, size, ){
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Nunito',
            color: Utils.bottleclr,
            fontSize: size,
            ));
  }
  static semiboldtext(String text, size, Color color ){
    return Text(text,
        style: TextStyle(
          fontFamily: 'Nunito-SemiBold',
          color: color,
          fontSize: size,
        ));
  }
  static blackclrtext(String text, size){
    return Text(text,
        textAlign: TextAlign.center,
        style: Utils.googlenunitoreg(size, Utils.grey));
  }
  static darkbluetxt(String text, size){
    return Text(text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: 'Nunito',
            color: Color(0xFF3F3D56),
            fontSize: size,
            fontWeight: FontWeight.bold

        ));
  }
  static nunitolight(size, color){
    return  TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Nunito Light',
        );
        }
  static boldtxt(size,color){
    return  TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'Nunito',
    );
  }
  static semibold(String text, size,Color color){
    return Text(text,
        style: TextStyle(
            fontFamily: 'Nunito SemiBold',
            color: color,
            fontSize: size,
        ));
  }
  static greytxtstyl(){
    return  GoogleFonts.poppins(
      color: Color(0xFF7B7B7B),
      fontSize: 14,
    );
  }
  static btlclrstyl(){
    return  GoogleFonts.poppins(
      color: bottleclr,
      fontSize: 12,
    );
  }
  static latoheading(Color color,double size, FontWeight fontweight){
    return  GoogleFonts.lato(
      fontWeight: fontweight,
      color: color,
      fontSize: size,
    );
  }

  static drawermenuItem(String svg,String txt,VoidCallback ontap){
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SvgPicture.asset(
          svg,width: 18.0,height: 18.0,color: Color(0xFF3F3D56),
        ),
            Utils.sizeBoxWidth(20.0),
            Text(txt,style: googlenunitoreg(18.0,Utils.grey.withOpacity(0.6)))//Utils.semibold(txt,16.0, Utils.grey.withOpacity(0.6)),
          ],
        ),
      ),
    );
  }
  /*static googlenunitoreg(double size,Color color){
    return GoogleFonts.nunito(fontStyle: FontStyle.normal,fontSize: size, color: color);
  }*/
  static googlenunitoreg(double size,Color color){
    return TextStyle(fontFamily: 'Nunito Light',fontStyle: FontStyle.normal,fontSize: size, color: color);
  }
  static axistitle(Color color, String txt){
    return Row(
      children: [
        CircleAvatar(radius: 8,backgroundColor: color),
        Utils.sizeBoxWidth(10.0),
        Text(txt,style:Utils.boldtxt(16.0,Color(0xFF606060)))
      ],
    );
  }
  static reddot(BuildContext context, Color color) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return SvgPicture.asset(
      'assets/svg/tickdot.svg',height: 28.0,width:28.0,
      color: color,
    );
  }
  static roundbutton(width,height, String txt, Color color,VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Utils.semibold(txt,12.0, Utils.white),
      ),
    );
  }

  static DescriptorBox(String txt,Color txtcolor, Color boxcolor, VoidCallback ontap){
    return GestureDetector(
      onTap: ontap,
      child: Container(
        constraints:BoxConstraints(
          minHeight: 35.0,
          maxHeight: 70.0,
        ),

        height: 20,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),color: boxcolor),
        child: Utils.semibold(txt, 14.0, txtcolor),),
    );
  }
  static popuptext(BuildContext context,String title, TextEditingController controller,TextInputType textInputType){
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top:_height*.02,left: _width*.04,right: _width*.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utils.semibold(title, 14.0, Utils.darkblue),
          Utils.sizeBoxHeight(06.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _width*.03),
            height: _height*.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFf8f8f8)
            ),
            child: TextFormField(
              keyboardType: textInputType,
              controller: controller,
              style: Utils.boldtxt(12.0, Utils.lightgrey1),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
  static DateTime cdate = DateTime.parse(Timestamp.fromDate(DateTime.now()).toDate().toString());
  static timesofdiff(int days,int houres,int minutes,int seconds) {
    if (days <= 1) {
      if (houres <= 1) {
        if (minutes <= 1) {
// if (seconds <= 60) {
// print('seconds ${seconds}');
// return '${seconds.toString()} seconds';
          return '${1} Minutes ago';
// }
        } else {
          return '${minutes.toString()} Minutes ago';
        }
      } else {
// print(days);
        if(houres <= 24){
// print('Houres ${houres}');
          return '${houres.toString()} Hours ago';
        }else{
          return '${days.toString()} Days ago';
        }

      }
    }
      else {
      if (days <= 30){
        return '${days.toString()} Days ago';
      } else{
        var month = days / 30;
        if (month <= 12) {
          return '${month.round()} Month ago';
        } else{
          var year = month / 12;
          return '${year.round()} Year ago';
        }
      }
    }
  }
  static String diff(Timestamp startDate) {
    var date = DateTime.fromMillisecondsSinceEpoch(startDate.millisecondsSinceEpoch);
    final birthday = DateTime(date.year, date.month, date.day, date.hour, date.minute, date.second);
    final date2 = DateTime.now();

    final difference = date2.difference(birthday).inDays;
    if (difference >= 365) {
      return '${(difference / 365).floor()} Years ago';
    }
    if (difference >= 30) {
      return '${(difference / 30).floor()} Months ago';
    }
    if (difference > 1) {
      return '$difference Days ago';
    }
    final differenceHour = date2.difference(birthday);
    if (differenceHour.inHours >= 1) {
      return '${differenceHour.inHours} Hours ago';
    }
    if (differenceHour.inMinutes >= 1) {
      return '${differenceHour.inMinutes} Minutes ago';
    }
    // if (differenceHour.inMinutes >= 1) {
    return '${differenceHour.inSeconds} Seconds ago';
    // }
  }
  static toast(String title, String msg, Color clr){
    return Get.snackbar(title, msg,borderRadius: 10.0,
        margin: EdgeInsets.all(10.0),padding: EdgeInsets.all(20.0),backgroundColor:clr,colorText: Utils.white);
  }
  static simptoast(String msg,Color txtclr,Color toastclr){
    return Fluttertoast.showToast(gravity: ToastGravity.TOP,msg: msg,textColor: txtclr,fontSize: 15.0,backgroundColor: toastclr);
  }
  static void removeData() async {
    Constant.token = '';
    Constant.name = '';
    Constant.profilepic = '';
    GetPref.token = '';
    GetPref.removeValues(GetPref.loginData);
    d().clean();
    // if (await SharedPreference.containsKey(SharedPreference.loginData)) {
    //   SharedPreference.removeValues(SharedPreference.loginData);
    // }
    // if (await SharedPreference.containsKey(SharedPreference.justInstalled)) {
    //   SharedPreference.removeValues(SharedPreference.justInstalled);
    // }
    //await SharedPreference.prefs.clear();
    GetPref.gs.erase();
  }
  static Widget getImageFile(
      double width, double height, File image, double corner) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(corner),
      child: Image.file(
        image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.network('https://www.hpsystems.com.tr/tema/genel/uploads/ekibimiz/vote_1.png');
        },
      ),
    );
  }
  static Widget getProfilePic(
      double width, double height, String image, double corner) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(corner),
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        errorWidget: (context, url, error) =>
            Image.network('https://www.hpsystems.com.tr/tema/genel/uploads/ekibimiz/vote_1.png'),
      ), /*Image.network(
        image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print(error);
          return Utils.svgIconGreen(
              'images/user_circle.svg', 100.0, 100.0);
        },
      ),*/
    );
  }
}