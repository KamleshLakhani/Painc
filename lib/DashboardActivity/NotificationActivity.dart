import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/SharedPreference.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        txt: 'Notifications',infobtn: false,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Notifications').orderBy('time',descending: true).snapshots(),
          builder: (context, AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Center(child: Utils.darkbluetxt('No Notifications', 16.0));
            }
            else if(snapshot.hasData){
              return ListView.builder(
                padding: EdgeInsets.all(15.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DateTime time = DateTime.parse((snapshot.data.docs[index]['time']).toDate().toString());
                    var seconds = Utils.cdate.difference(time).inSeconds;
                    var minutes = Utils.cdate.difference(time).inMinutes;
                    var houres = Utils.cdate.difference(time).inHours;
                    var days = Utils.cdate.difference(time).inDays;
                    GetPref.addgs(GetPref.notification, snapshot.data.docs.length);
                    SharedPreference.addintToSF(SharedPreference.notification, snapshot.data.docs.length);
                    return Container(
                      padding: EdgeInsets.only(left: 10,right: 15,top: screenheight*.01,bottom: screenheight*.01),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade100,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(5.0, 5.0))
                          ],
                          color: Utils.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Utils.svg('assets/svg/onlylogo.svg', 50, 50),
                          /*Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        'assets/onlylogo.png')*//*AssetImage(
                                        'https://i.pinimg.com/originals/ed/19/65/ed196549154d9419e4e983ae4ebbc119.jpg')*//*)),
                          ),*/
                          SizedBox(width: 15),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data.docs[index]['subject'],
                                   // overflow: TextOverflow.ellipsis,
                                   // maxLines: 1,
                                    style: Utils.boldtxt(14.0, Colors.black)),
                                Container(
                                  //width: screenwidth*.35,
                                  child: Text(snapshot.data.docs[index]['description'],
                                      style: TextStyle(
                                          fontFamily: 'Nunito Light',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.4))),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(  Utils.diff(snapshot.data.docs[index]['time']),//Utils.timesofdiff(days, houres, minutes, seconds),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: 'Nunito Light',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF8B8B8B))),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }

        ),
      ),
    );
  }
}
