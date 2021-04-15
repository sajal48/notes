import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes/widget/neumorphic_btn.dart';

class RegisterForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
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
                TextFormField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.email),
                  ),
                ),
                TextFormField(
                  controller: _passcontroller,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Password"
                  ),
                ),
                Padding(padding: EdgeInsets.all(30)),
                Custom_Btn(
                  txt: Text("Login"),
                  icon: Icon(Icons.arrow_forward),
                  onPressed: (){},
                ),
                Padding(padding: EdgeInsets.all(10)),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
