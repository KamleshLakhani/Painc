import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

class ValidationBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    return Container(
      padding: EdgeInsets.all(10),
      width: screenwidth*.7,
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: Offset(5.0,5.0)
          )]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password must meet the following requirements:',
          textAlign: TextAlign.start,
          style: Utils.boldtxt(16.0, Utils.darkblue)),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.check, size: 20, color: Utils.bottleclr),
              SizedBox(width: 5),
              RichText(
                overflow: TextOverflow.ellipsis,
                text : TextSpan(text: 'At least ',style: Utils.nunitolight(18.0,Utils.bottleclr),
                    children:[TextSpan(
                      text: 'one letter ',style: Utils.boldtxt(18.0, Utils.bottleclr)
                    )] ),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.close, size: 20, color: Utils.red),
              SizedBox(width: 5),
              RichText(maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(text: 'At least ',style: Utils.nunitolight(18.0,Utils.red),
                    children:[TextSpan(
                      text: 'one capital letter ',style: Utils.boldtxt(18.0,Utils.red),
                    )] ),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.check, size: 20, color: Utils.bottleclr),
              SizedBox(width: 5),
              Container(
                width: screenwidth*.5,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                 text: TextSpan(text: 'At least ',style: Utils.nunitolight(18.0,Utils.bottleclr),
                      children:[TextSpan(
                        text: 'one number ',style: Utils.boldtxt(18.0,Utils.bottleclr),
                      )] ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.close, size: 20, color: Utils.red),
              SizedBox(width: 5),
              Container(
                width: screenwidth*.5,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(text: 'Be at least ',style: Utils.nunitolight(18.0,Utils.red),
                      children:[TextSpan(
                        text: '8 characters',style: Utils.boldtxt(18.0,Utils.red),
                      )] ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
