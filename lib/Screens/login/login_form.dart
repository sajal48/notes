import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes/Repository/userrepo.dart';
import 'package:notes/Screens/home/home_screen.dart';
import 'package:notes/Screens/register/register_screen.dart';
import 'package:notes/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:notes/blocs/login_bloc/login_bloc.dart';
import 'package:notes/main.dart';
import 'package:notes/widget/neumorphic_btn.dart';

class LoginForm extends StatefulWidget {
  final UserRepo _userRepo;

  const LoginForm({Key key, UserRepo userrepo})
      : _userRepo = userrepo,
        super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  LoginBloc loginBloc;
  bool get isPopulated =>
      _emailcontroller.text.isNotEmpty && _passcontroller.text.isNotEmpty;

  bool isButtonenable(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
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
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
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
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
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
                    style:
                        NeumorphicStyle(color: Colors.transparent, depth: -5),
                    child: TextFormField(
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
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
                    style:
                        NeumorphicStyle(color: Colors.transparent, depth: -5),
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
                  Custom_Btn(
                    txt: Text("Register"),
                    icon: Icon(Icons.create),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
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
    }));
  }

  void _onEmailcng() {
    loginBloc.add(LoginEmailChange(email: _emailcontroller.text));
  }

  void _onPasscng() {
    loginBloc.add(LoginPasswordChanged(password: _passcontroller.text));
  }

  void _onFormSubmited() {
    loginBloc.add(LoginWithCredentialsPressed(
        email: _emailcontroller.text, password: _passcontroller.text));
  }
}
