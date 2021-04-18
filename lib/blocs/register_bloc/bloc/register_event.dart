part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterEmailChange extends RegisterEvent {
  final String email;

  RegisterEmailChange({this.email});

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class RegisterWithCredentialsPressed extends RegisterEvent {
  final String email;
  final String password;

  RegisterWithCredentialsPressed({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
