import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/custdropdown.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/components/textfield.dart';

class InsuranceDetail extends StatefulWidget {
  @override
  _InsuranceDetailState createState() => _InsuranceDetailState();
}

class _InsuranceDetailState extends State<InsuranceDetail> {
  String _choosenname;
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
        appBar: CustAppbar(
          txt: 'Insurance Details',infobtn: false,
        ),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              height: screenheight,
              width: screenwidth,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Utils.sizeBoxHeight(45.0),
                        Container(width:screenwidth*.5,child: Text('Please enter the details of health insurance ',textAlign: TextAlign.center,style: Utils.nunitolight(14.0,Utils.lightgrey1))),
                        Utils.sizeBoxHeight(45.0),
                        Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Utils.svg('assets/svg/membershipnum.svg',19.0,19.0),
                                  Utils.sizeBoxWidth(13.0),
                                  Flexible(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(color: Colors.grey)
                                          )
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: CustDropDown(
                                          textselectionstyle: Utils.googlenunitoreg(14.0, Utils.lightgrey1),
                                          onChanged: (String value) {
                                      setState(() {
                                        _choosenname = value;
                                      });
                                      },
                                          choosenvalue: _choosenname,
                                          hinttext:
                                          'Insurer',
                                          dropdownitems: [
                                            'Bupa',
                                            'AXA PPA',
                                            'Aviva',
                                            'Vitlaity',
                                            'Self pay',
                                            'Others'
                                          ],
                                        ),/*DropdownButton<String>(
                                          icon: Icon(Icons.keyboard_arrow_down, color: Utils.lightgrey1),
                                          value: _chosenValue,
                                          //elevation: 5,
                                          style: TextStyle(color: Utils.grey.withOpacity(0.6), fontSize: 16.0,fontFamily: 'Nunito', fontWeight: FontWeight.w400),
                                          isExpanded: true,
                                          items: <String>[
                                            'BUPA',
                                            'AXA PPA',
                                            'Aviva',
                                            'Vitality',
                                            'Self pay',
                                            'Others',
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          hint: Text(
                                            "Gender",
                                            style: TextStyle(
                                                color: Utils.hintclr,
                                                fontSize: 16,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              _chosenValue = value;
                                            });
                                          },
                                        ),*/
                                      ),
                                    ),
                                  ),
                                ])),
                        Utils.sizeBoxHeight(45.0),
                        CustTxtField(icon: 'assets/svg/membershipnum.svg', hinttxt: 'Membership Number',icnheight: 19.0,icnwidth: 19.0),
                        Utils.sizeBoxHeight(45.0),
                        CustTxtField(icon: 'assets/svg/patientcode.svg', hinttxt: 'Patient Code',icnheight: 19.0,icnwidth: 19.0),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: screenheight*.03,
                    left: screenwidth*.01,
                    right: screenwidth*.01,
                    child:  PainCButton(
                      title: 'Save', onTap: (){Get.back();},
                      borderColor: Utils.bottleclr,
                      titleColor: Utils.bottleclr,
                      spashColor: Utils.bottleclr,
                      tappedTitleColor: Utils.white,
                    ),/*RoundedBtn(
                      ontap: () => Get.back(),
                      btnclr: Utils.bottleclr,
                      btntxtclr: Utils.white,
                      txt: 'Reset Password',
                    ),*/
                  ),
                ],
              )
          ),
        ));
  }
}
