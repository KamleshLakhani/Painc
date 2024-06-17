import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';

class CustAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String txt;
  final bool infobtn;
  final VoidCallback onPressed;
  final VoidCallback onbackpress;
  CustAppbar({Key key,this.onbackpress, this.infobtn,this.txt,this.onPressed}) : preferredSize = Size.fromHeight(60.0), super(key: key);
  @override
  Widget build(BuildContext context) {
    return  AppBar(
      elevation: 0,
      backgroundColor: Utils.bottleclr,
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      actions: [if(infobtn == true )IconButton(icon: Icon(Icons.info_outline,size: 22), onPressed: onPressed,)],
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Utils.white, size: 18),
        onPressed: onbackpress == null ? ()=>Get.back() : onbackpress,
        /*onPressed: () {
          Get.back();
        },*/
      ),
      centerTitle: true,
      title: Text(
        txt,
        style: Utils.boldtxt(20.0, Utils.white),
      ),
    );
  }
}
