import 'package:flutter/material.dart';

void showLoadingDialog({
  @required BuildContext context,
  bool idShow = true,
  Color barrierColor,
})
{
  idShow
      ? Future.delayed(Duration(seconds: 0), () {
    showDialog(
        context: context,
        barrierColor: barrierColor ?? Colors.grey.withOpacity(0.50),
        barrierDismissible:
        false, // set to false if you want to force a rating
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  })
      : print("Please wait");
}

void hideLoadingDialog({@required BuildContext context}) {
  Navigator.pop(context, false);
}
