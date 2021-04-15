import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/Repository/userrepo.dart';
import 'package:notes/blocs/authentication_bloc/authentication_bloc.dart';

import 'Screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserRepo userRepo = UserRepo(firebaseAuth: FirebaseAuth.instance);
  runApp(
    MyApp(userRepo: userRepo,)
    // BlocProvider(
    //   create: (context)=> AuthenticationBloc(
    //     userRepo: userRepo
    //   ),
    //   child: MyApp(userRepo: userRepo,),
    // )
  );
}
 class MyApp extends StatelessWidget {
  final UserRepo _userRepo;

  MyApp({UserRepo userRepo}): _userRepo=userRepo;
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
         textSelectionTheme: TextSelectionThemeData(
           cursorColor: Colors.grey
         ),
         primaryColor: Colors.black,
       ),
       home:LoginScreen()
     );
   }
 }



