import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:painc/ApiClass/login.dart';
import 'package:painc/GetX/updateprofile.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/cdd.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/components/textfield.dart';
import 'package:http/http.dart' as http;
import '../screens/GDRP.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UpdateController updateform = Get.put(UpdateController());
  ImagePicker imagePicker = ImagePicker();
  LoginModel loginmodel = new LoginModel();
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
        appBar: CustAppbar(
          txt: 'Edit Profile',onPressed: (){},infobtn: false,
        ),
        body: SafeArea(
          child: GetBuilder<UpdateController>(builder: (controller) {
            if(updateform.showloader == true.obs){
              return Center(child: CircularProgressIndicator());
            }else{
              return Form(
                key: updateform.updateprofile,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () async{
                            final pickedFile =
                            await ImagePicker.pickImage(source: ImageSource.gallery);
                            setState(() {
                              updateform.imagefile = File(pickedFile.path);
                            });
                          },
                          child: Hero(
                            tag: 'profile',
                            child: Stack(
                              alignment: Alignment.center,
                              overflow: Overflow.visible,
                              children: [
                                Container(
                                  width: screenwidth,
                                  height: 70,
                                  color: Utils.bottleclr,
                                ),
                                Positioned(
                                    bottom: -50,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      overflow: Overflow.visible,
                                      children: [
                                        Container(
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Utils.bottleclr),
                                                shape: BoxShape.circle,
                                                color: Utils.white,
                                                boxShadow: [BoxShadow(offset: Offset(3.0,3.0),blurRadius: 8, color: Utils.black.withOpacity(0.2), spreadRadius: 1)]
                                            ),
                                            child: Container(
                                              child: (updateform.imagefile != null) ? Utils.getImageFile(106, 106, updateform.imagefile, 100.0)
                                                  : GetBuilder<UpdateController>(builder: (controller)=>
                                                  ClipRRect(borderRadius: BorderRadius.circular(100),child: Image.network(controller.profileimg.value == '' ? 'https://www.hpsystems.com.tr/tema/genel/uploads/ekibimiz/vote_1.png' : controller.profileimg.value,fit: BoxFit.cover,))),
                                            ),
                                            height: 106,
                                            width: 106,),
                                        ),
                                        Positioned(
                                          bottom: -10,
                                          child: CircleAvatar(backgroundColor: Utils.bottleclr,radius: 15,child: Icon(Icons.edit_outlined, color: Utils.white,)),
                                        )
                                      ],
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 70),
                            padding: EdgeInsets.only(left: screenwidth*.1, right: screenwidth*.1),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Utils.sizeBoxHeight(screenheight * 0.04),
                                  CustTxtField(
                                      txtstyl: Utils.googlenunitoreg(16.0,Utils.black),
                                      controller: updateform.fnameController,
                                      validator: (val){
                                        if(val.isEmpty){
                                          return '';
                                        }return null;
                                      },
                                      icon: 'assets/svg/person.svg',
                                      hinttxt: 'First Name',
                                      icnheight: 18.0,
                                      icnwidth: 18.0),
                                  Utils.sizeBoxHeight(screenheight * 0.035),
                                  CustTxtField(
                                      txtstyl: Utils.googlenunitoreg(16.0,Utils.black),
                                      controller: updateform.mnameController,
                                      /* validator: (val){
                                      if(val.isEmpty){
                                        return '';
                                      }return null;
                                    },*/
                                      icon: 'assets/svg/person.svg',
                                      hinttxt: 'Middle Name',
                                      icnheight: 18.0,
                                      icnwidth: 18.0),
                                  Utils.sizeBoxHeight(screenheight * 0.035),
                                  CustTxtField(
                                      txtstyl: Utils.googlenunitoreg(16.0,Utils.black),
                                      controller: updateform.snameController,
                                      validator: (val){
                                        if(val.isEmpty){
                                          return '';
                                        }return null;
                                      },
                                      icon: 'assets/svg/person.svg',
                                      hinttxt: 'Surname',
                                      icnheight: 18.0,
                                      icnwidth: 18.0),
                                  Utils.sizeBoxHeight(screenheight * 0.020),
                                  Container(
                                      child: Row(children: [
                                        Utils.svg('assets/svg/person.svg', 18.0, 18.0),
                                        Utils.sizeBoxWidth(13.0),
                                        Flexible(
                                            child: GetBuilder<UpdateController>(
                                                builder: (controller)=>
                                                    Container(
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom:
                                                                BorderSide(color: Colors.grey))),
                                                        child: DropdownButtonHideUnderline(
                                                          child:CustomDropdownButton<RxString>(
                                                            value: updateform.choosenvalue,
                                                            items: ['Male','Female','Others'].map<DropdownMenuItem<RxString>>(
                                                                    (String value) {
                                                                  return DropdownMenuItem<RxString>(
                                                                    value: value.obs,
                                                                    child: Text(value,style: Utils.googlenunitoreg(16.0, Utils.black)),
                                                                  );
                                                                }).toList(),
                                                            hint: Text(
                                                              '${controller.hint.value}',style: Utils.googlenunitoreg(16.0, Utils.black),
                                                            ),
                                                            onChanged: (RxString value) {
                                                              setState(() {
                                                                updateform.choosenvalue = value;
                                                              });
                                                              updateform.choosenvalue = value;
                                                            },
                                                          ),
                                                        )))
                                        ),
                                      ])),
                                  Utils.sizeBoxHeight(screenheight * 0.035),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Utils.svg('assets/svg/date.svg', 18.0, 18.0),
                                      Utils.sizeBoxWidth(13.0),
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            Platform.isIOS
                                                ? updateform.selectIOSDate(context)
                                                : updateform.selectDate(context);
                                          },
                                          child: TextFormField(
                                            style: Utils.googlenunitoreg(16.0,Utils.black),
                                            keyboardType: TextInputType.text,
                                            validator: (val){
                                              if(val.isEmpty || val == null){
                                                return '';
                                              }return null;
                                            },
                                            controller: updateform.dateController,
                                            /*onSaved: (String val) {
                                            updateform.saveddate = val.obs;
                                          },*/
                                            enabled: false,
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(height: 0),
                                              contentPadding: EdgeInsets.only(bottom: 7.0),
                                              isDense: true,
                                              disabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5, color: Color(0x44000000)),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(width: 1.5, color: Utils.red)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Utils.sizeBoxHeight(screenheight * 0.035),
                                  CustTxtField(
                                      txtstyl: Utils.googlenunitoreg(16.0,Utils.black),
                                      controller: updateform.addressController,
                                      /*validator: (val){
                                      if(val.isEmpty){
                                        return '';
                                      }return null;
                                    },*/
                                      icon: 'assets/svg/location.svg',
                                      hinttxt: 'Address',
                                      icnheight: 22.0,
                                      icnwidth: 22.0),
                                  Utils.sizeBoxHeight(screenheight * 0.035),
                                  CustTxtField(
                                      txtstyl: Utils.googlenunitoreg(16.0,Utils.black),
                                      controller: updateform.pincodeController,
                                      validator: (val){
                                        if(val.isEmpty){
                                          return '';
                                        }return null;
                                      },
                                      icon: 'assets/svg/location.svg',
                                      hinttxt: 'Postcode',
                                      icnheight: 22.0,
                                      icnwidth: 22.0),
                                  Utils.sizeBoxHeight(screenheight * 0.08),
                                  Container(
                                      width: screenwidth*.35,
                                      height: screenheight*.065,
                                      child: PainCButton(
                                        title: 'Update', onTap: (){
                                        updateform.updateprofiledata(context);
                                      },
                                        borderColor: Utils.bottleclr,
                                        titleColor: Utils.bottleclr,
                                        spashColor: Utils.bottleclr,
                                        tappedTitleColor: Utils.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      )
                                  ),
                                  Utils.sizeBoxHeight(screenheight * 0.04),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
          ),
        ),
   /*floatingActionButton: FloatingActionButton(
        onPressed: () async{
          print(Constant.profilepic);
    },
    ),*/);
  }
}
