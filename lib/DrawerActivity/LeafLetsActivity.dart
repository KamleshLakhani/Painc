import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/Getleaftlets.dart';
import 'package:painc/DrawerActivity/LeafLetsDescriptionActivity.dart';
import 'package:painc/GetX/getleaftlets.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/appbar.dart';

class Leaflets extends StatefulWidget {
  @override
  _LeafletsState createState() => _LeafletsState();
}

class _LeafletsState extends State<Leaflets> {

  @override
  void initState() {
    Get.put(getleaftlets());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);

    return Scaffold(
      appBar: CustAppbar(
        txt: 'Leaflets',
        infobtn: false,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          width: screenwidth,
          height: screenheight,
          child: GetX<getleaftlets>(builder: (controller) {
            if (controller.titlegetleaftlets != null &&
                controller.titlegetleaftlets.length != 0) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.titlegetleaftlets.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.15,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  //mainAxisExtent: screenheight*.27
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(LeftLetsDescription(controller.titlegetleaftlets[index].description));
                    },
                    child: Container(
                      //color: Colors.blueGrey,
                      child: Column(
                        children: [
                          Container(
                            height: screenheight * .21,
                            width: screenwidth / 2,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Utils.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 5,
                                    color: Utils.grey.withOpacity(0.1),
                                    spreadRadius: 1)
                              ],
                            ),
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Utils.svg(
                                    'assets/svg/onlylogo.svg', 80.0, 80.0)),
                          ),
                          Utils.darkbluetxt(controller.titlegetleaftlets[index].title,
                              screenwidth * .045)
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }
}

/* */
