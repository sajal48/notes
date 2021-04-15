import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/Repository/userrepo.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo _userRepo;

  AuthenticationBloc({UserRepo userRepo})
      : _userRepo = userRepo,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthstartedtomap();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthloggedintomap();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthloggedouttomap();
    }
  }

  Stream<AuthenticationState> _mapAuthloggedouttomap() async*{
    yield AuthenticationFailure();
    _userRepo.signOut();}

  Stream<AuthenticationState> _mapAuthloggedintomap() async*{
    yield AuthenticationSuccess(await _userRepo.getUser());}

  Stream<AuthenticationState> _mapAuthstartedtomap() async*{
    final isSignedIn = await _userRepo.isSingedIn();
    if(isSignedIn){
      final user = await _userRepo.getUser();
      yield AuthenticationSuccess(user);
    }
    else{
      yield AuthenticationFailure();
    }
  }
}


