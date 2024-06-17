import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:painc/Utils/Utils.dart';
import 'package:painc/passwordvalidation/password_strength_bloc.dart';

class PasswordStrengthPage extends StatefulWidget {
  final String value;
  PasswordStrengthPage(this.value);

  @override
  _PasswordStrengthPageState createState() => _PasswordStrengthPageState();
}

class _PasswordStrengthPageState extends State<PasswordStrengthPage> {
  PasswordStrengthBloc passwordStrengthBloc = PasswordStrengthBloc();
  bool isValidPassword = false;
  bool islowerCase = false;
  bool isuperCase = false;
  bool isnumber = false;
  bool isEightChar = false;
  bool isspecialChar = false;
  bool ispattern = false;
  bool islength = false;
  String isVisible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = Utils.getHeight(context);
    var screenWidth = Utils.getWidth(context);
    passwordStrengthBloc.add(OnTextChangedEvent(text: widget.value));
    return BlocListener<PasswordStrengthBloc, PasswordStrengthState>(
      listener: (context, state) {
        if (state is OnTextChangedState) {
          isVisible = state.text;
          passwordStrengthBloc.add(PasswordRegEx(passwordtext: state.text));
        }
        if (state is ValidPassword) {
          isValidPassword = true;
          islowerCase = true;
          isuperCase = true;
          isnumber = true;
          isEightChar = true;
          isspecialChar = true;
          ispattern = true;
          islength = true;
        }
        if (state is InvalidPassword) {
          isValidPassword = state.isInvalidPassword;
          if (state.passwordValidation['lowerCase'] != null &&
              state.passwordValidation['lowerCase']) {
            islowerCase = true;
          } else {
            islowerCase = false;
          }
          if (state.passwordValidation['upperCase'] != null &&
              state.passwordValidation['upperCase']) {
            isuperCase = true;
          } else {
            isuperCase = false;
          }
          if (state.passwordValidation['specialChar'] != null &&
              state.passwordValidation['specialChar']) {
            isspecialChar = true;
          } else {
            isspecialChar = false;
          }
          if (state.passwordValidation['minEightChar'] != null &&
              state.passwordValidation['minEightChar']) {
            isEightChar = true;
          } else {
            isEightChar = false;
          }
          if (state.passwordValidation['oneNumber'] != null &&
              state.passwordValidation['oneNumber']) {
            isnumber = true;
          } else {
            isnumber = false;
          }
          if (state.passwordValidation['length'] != null &&
              state.passwordValidation['length']) {
            islength = true;
          } else {
            islength = false;
          }
        }
      },
      bloc: passwordStrengthBloc,
      child: BlocBuilder<PasswordStrengthBloc, PasswordStrengthState>(
        builder: (context, state) {
          return Visibility(
            visible: widget.value.length == 0 ? false : (isValidPassword == true) ? false : true,
            child: Container(
              margin: EdgeInsets.only(left: screenWidth*.08),
                decoration: BoxDecoration(
                    color: Utils.white,
                    boxShadow: [BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                        offset: Offset(5.0,5.0)
                    )]
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Utils.semibold('Password must meet the following requirements:', 14.0, Utils.darkblue),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Utils.sizeBoxHeight(screenHeight*.02),
                        Row(
                          children: [
                            Icon(islowerCase == true ? Icons.check : Icons.clear, size: 20, color: islowerCase == true ? Utils.bottleclr : Utils.red),
                            SizedBox(width: 5),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text : TextSpan(text: 'At least ',style: Utils.googlenunitoreg(14.0, islowerCase == true ? Utils.bottleclr : Utils.red),
                                  children:[TextSpan(
                                      text: 'one letter ',style: Utils.boldtxt(14.0, islowerCase == true ? Utils.bottleclr : Utils.red)
                                  )] ),
                            )
                          ],
                        ),
                        Utils.sizeBoxHeight(screenHeight*.01),
                        Row(
                          children: [
                            Icon(isuperCase == true ? Icons.check : Icons.clear, size: 20, color: isuperCase == true ? Utils.bottleclr : Utils.red),
                            SizedBox(width: 5),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text : TextSpan(text: 'At least ',style: Utils.googlenunitoreg(14.0, isuperCase == true ? Utils.bottleclr : Utils.red),
                                  children:[TextSpan(
                                      text: 'one capital letter ',style: Utils.boldtxt(14.0, isuperCase == true ? Utils.bottleclr : Utils.red)
                                  )] ),
                            )
                          ],
                        ),
                        Utils.sizeBoxHeight(screenHeight*.01),
                        Row(
                          children: [
                            Icon(isnumber == true ? Icons.check : Icons.clear, size: 20, color: isnumber == true ? Utils.bottleclr : Utils.red),
                            SizedBox(width: 5),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text : TextSpan(text: 'At least ',style: Utils.googlenunitoreg(14.0, isnumber == true ? Utils.bottleclr : Utils.red),
                                  children:[TextSpan(
                                      text: 'one number ',style: Utils.boldtxt(14.0, isnumber == true ? Utils.bottleclr : Utils.red)
                                  )] ),
                            )
                          ],
                        ),
                        Utils.sizeBoxHeight(screenHeight*.01),
                        Row(
                          children: [
                            Icon(isEightChar == true ? Icons.check : Icons.clear, size: 20, color: isEightChar == true ? Utils.bottleclr : Utils.red),
                            SizedBox(width: 5),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text : TextSpan(text: 'Be at least ',style: Utils.googlenunitoreg(14.0, isEightChar == true ? Utils.bottleclr : Utils.red),
                                  children:[TextSpan(
                                      text: '8 characters',style: Utils.boldtxt(14.0, isEightChar == true ? Utils.bottleclr : Utils.red)
                                  )] ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          );
        },
        bloc: passwordStrengthBloc,
      ),
    );
  }
}
