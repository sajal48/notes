import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes/Repository/userrepo.dart';
import 'package:notes/Screens/login/login_form.dart';
import 'package:notes/blocs/login_bloc/login_bloc.dart';
import 'package:notes/widget/curved_widget.dart';

class LoginScreen extends StatelessWidget {
  final UserRepo _userRepo;

  const LoginScreen({Key key, UserRepo userRepo})
      : _userRepo = userRepo,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: Neumorphic(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  .2,
                  .9,
                ],
                    colors: [
                  Colors.blueGrey,
                  Colors.white10
                ])),
            child: Stack(children: [
              CurvedWidget(
                child: Container(
                    padding: EdgeInsets.only(top: 70, left: 35),
                    height: 250,
                    width: double.infinity,
                    color: Colors.white38,
                    child: NeumorphicText(
                      "Login",
                      textAlign: TextAlign.start,
                      textStyle: NeumorphicTextStyle(
                        fontSize: 65,
                        fontWeight: FontWeight.bold,
                      ),
                      style: NeumorphicStyle(
                          color: Colors.transparent,
                          shadowDarkColor: Colors.black,
                          shadowLightColor: Colors.white,
                          depth: 4),
                    )),
              ),
              SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(top: 230),
                    child: LoginForm(
                      userrepo: _userRepo,
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
