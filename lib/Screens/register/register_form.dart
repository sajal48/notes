import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes/Repository/userrepo.dart';
import 'package:notes/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:notes/blocs/register_bloc/bloc/register_bloc.dart';
import 'package:notes/widget/neumorphic_btn.dart';

import '../../main.dart';

class RegisterForm extends StatefulWidget {
  final UserRepo _userRepo;

  const RegisterForm({Key key, UserRepo userrepo})
      : _userRepo = userrepo,
        super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  RegisterBloc registerBloc;
  bool get isPopulated =>
      _emailcontroller.text.isNotEmpty && _passcontroller.text.isNotEmpty;

  bool isButtonenable(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailcontroller.addListener(_onEmailcng);
    _passcontroller.addListener(_onPasscng);
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passcontroller.dispose();
    // TODO: implement initState
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Failed"), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ));
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Loging In ...."), CircularProgressIndicator()],
              ),
              backgroundColor: Colors.blueGrey,
            ));
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
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
                            color: Colors.transparent, depth: -5),
                        child: TextFormField(
                          controller: _emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (_) {
                            return !state.isEmailValid ? 'Email Invalid' : null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: "Email",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Neumorphic(
                        padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                        style: NeumorphicStyle(
                            color: Colors.transparent, depth: -5),
                        child: TextFormField(
                          controller: _passcontroller,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            return !state.isPasswordValid
                                ? 'Invalid Password'
                                : null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              icon: Icon(Icons.lock),
                              labelText: "Password"),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(30)),
                      Custom_Btn(
                        txt: Text("Login"),
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          if (isButtonenable(state)) {
                            _onFormSubmited();
                          }
                        },
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailcng() {
    registerBloc.add(RegisterEmailChange(email: _emailcontroller.text));
  }

  void _onPasscng() {
    registerBloc.add(RegisterPasswordChanged(password: _passcontroller.text));
  }

  void _onFormSubmited() {
    registerBloc.add(RegisterWithCredentialsPressed(
        email: _emailcontroller.text, password: _passcontroller.text));
  }
}
