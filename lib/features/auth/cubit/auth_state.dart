part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}


class AuthInitial extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthOtpSending extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthOtpSended extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthOTPVerifying extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthOTPVerifyed extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthOTPFailed extends AuthState {

  @override
  List<Object> get props => [];
}


class AuthGVerifing extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthGVerifed extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthGFailed extends AuthState {

  @override
  List<Object> get props => [];
}

