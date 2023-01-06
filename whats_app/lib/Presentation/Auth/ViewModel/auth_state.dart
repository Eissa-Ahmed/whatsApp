part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class UpdateLangState extends AuthState {}

class UpdateThemeState extends AuthState {}

class GetCountryState extends AuthState {}

class SignInLoadingState extends AuthState {}

class SignInSuccessState extends AuthState {}

class SignInErrorgState extends AuthState {}

class IncrementTimeSendCodeState extends AuthState {}
