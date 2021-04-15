import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes/Screens/register/register_screen.dart';
import 'package:notes/widget/neumorphic_btn.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Neumorphic(
        style: NeumorphicStyle(
          color: Colors.transparent,

        ),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Neumorphic(
                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                   style: NeumorphicStyle(
                     color: Colors.transparent,
                     depth: -5
                   ),
                  child: TextFormField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: "Email",
                      icon: Icon(Icons.email),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Neumorphic(
                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                  style: NeumorphicStyle(
                      color: Colors.transparent,
                      depth: -5
                  ),
                  child: TextFormField(
                    controller: _passcontroller,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                        labelText: "Password"
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(30)),
                Custom_Btn(
                  txt: Text("Login"),
                  icon: Icon(Icons.arrow_forward),
                  onPressed: (){},
                ),
                Padding(padding: EdgeInsets.all(10)),
                Custom_Btn(
                  txt: Text("Register"),
                  icon: Icon(Icons.create),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return RegisterScreen();
                    }));
                  },
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}