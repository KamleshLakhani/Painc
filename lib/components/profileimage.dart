import 'dart:io';

import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

class ProfileImage extends StatelessWidget {
  final String image;
  final File picked;
  ProfileImage({this.picked,this.image});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Utils.bottleclr),
              shape: BoxShape.circle,
              color: Utils.white,
              boxShadow: [BoxShadow(offset: Offset(3.0,3.0),blurRadius: 8, color: Utils.black.withOpacity(0.2), spreadRadius: 1)]
          ),
          child: image == null ? Image.network(image) : Container(decoration: BoxDecoration(image: DecorationImage(image: FileImage(picked))),),
          height: 106,
          width: 106,),
        Positioned(
          bottom: -10,
          child: CircleAvatar(backgroundColor: Utils.bottleclr,radius: 15,child: Icon(Icons.edit_outlined, color: Utils.white,)),
        )
      ],
    );
  }
}
