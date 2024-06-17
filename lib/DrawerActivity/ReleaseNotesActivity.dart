import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/ReleaseNote.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:painc/components/loader.dart';
class ReleaseNoteActivity extends StatefulWidget {
  @override
  _ReleaseNoteActivityState createState() => _ReleaseNoteActivityState();
}

class _ReleaseNoteActivityState extends State<ReleaseNoteActivity> {
  //String api = 'http://192.168.0.33:8080/api/get-release-note';
  Future<ReleaseNote> releasenotes;
  @override
  void initState() {
    print('data');
    releasenotes = getnotes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = Utils.getWidth(context);
    var screenHeight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        infobtn: false,
        txt: 'Release Notes',
        onbackpress: ()=>Get.back(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth*.03,vertical: screenHeight*.025),
        width: screenWidth,
        child: FutureBuilder<ReleaseNote>(
          future: releasenotes,
          builder: (context, snapshot) {
            try{
              if(snapshot.data.releaseNotes == null){
                return Center(child:Utils.semibold('No Release Notes Available', 16.0, Utils.darkblue));
              }
              else if(snapshot.hasData){
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: screenWidth*.03,horizontal: screenHeight*.02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Utils.bottleclr.withOpacity(0.1)
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Html(data: snapshot.data.releaseNotes.releaseVersion),
                              // Utils.btlclrboldtext('3.0.2', 18.0),
                              Divider(),
                              Html(data: snapshot.data.releaseNotes.description),
                              /*Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(padding: EdgeInsets.only(top: screenHeight*.004),child: Utils.darkbluetxt('●', 8.0),),
                              Utils.sizeBoxWidth(screenWidth*.02),
                              Flexible(
                                child: Text('Alternatives to traditional hospital care may be appropriate for some patients, particularly older adults. ',
                                    softWrap: true,
                                    style: TextStyle(color: Utils.darkblue)),
                              ),
                            ],
                          ),
                          Utils.sizeBoxHeight(screenHeight*.01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(padding: EdgeInsets.only(top: screenHeight*.004),child: Utils.darkbluetxt('●', 8.0),),
                              Utils.sizeBoxWidth(screenWidth*.02),
                              Flexible(
                                child: Text('In a trial conducted in nine communities in the United Kingdom, older adults randomly assigned to hospital at home plus comprehensive geriatric assessment had similar rates of living at home at six months compared with those receiving standard hospital admission, but a lower rate of admission to long-term care. ',
                                    softWrap: true,
                                    style: TextStyle(color: Utils.darkblue)),
                              ),
                            ],
                          ),
                          Utils.sizeBoxHeight(screenHeight*.01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(padding: EdgeInsets.only(top: screenHeight*.004),child: Utils.darkbluetxt('●', 8.0),),
                              Utils.sizeBoxWidth(screenWidth*.02),
                              Flexible(
                                child: Text('In both groups, the most common presenting problem was acute functional deterioration, and the most common diagnosis was infection. ',
                                    softWrap: true,
                                    style: TextStyle(color: Utils.darkblue)),
                              ),
                            ],
                          )*/
                            ]
                        ),
                      );
                    }

                );
              }
              return Center(child: CircularProgressIndicator());
            }catch(e){
              return Center(child: CircularProgressIndicator());
            }

          }

        ),

      ),
    );
  }
  Future<ReleaseNote> getnotes() async{
    print('nodatadsada');
    http.Response response = await ResponseClass.callGetApi(ApiSheet.notification);
    print(response.statusCode);
    print(response.body);
    ReleaseNote data = ReleaseNote.fromJson(json.decode(response.body));
    if(response.statusCode == 200){
      print('data');
      return ReleaseNote.fromJson(json.decode(response.body));
    }else{
      return null;
      print('no data');
      print(response.body);
    }
  }
}
