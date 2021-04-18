import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:notes/widget/curved_widget.dart';

class HomeScreen extends StatelessWidget {
  User user;

  HomeScreen({Key key, this.user}) : super(key: key);
  HomeScreen.n() {
    this.user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Neumorphic(
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
                  padding: EdgeInsets.only(top: 45, left: 25),
                  height: 200,
                  width: double.infinity,
                  color: Colors.white38,
                  child: NeumorphicText(
                    "${user.email}",
                    textAlign: TextAlign.start,
                    textStyle: NeumorphicTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    style: NeumorphicStyle(
                        color: Colors.blueGrey,
                        shadowDarkColor: Colors.black,
                        shadowLightColor: Colors.white,
                        depth: 1),
                  )),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: 50, left: (MediaQuery.of(context).size.width - 50)),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationLoggedOut());
                  },
                  child: NeumorphicIcon(
                    Icons.exit_to_app,
                    size: 30,
                    style: NeumorphicStyle(color: Colors.blueGrey, depth: 2),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
