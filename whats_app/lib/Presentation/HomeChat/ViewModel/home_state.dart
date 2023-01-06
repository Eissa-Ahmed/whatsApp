part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoginSuccessState extends HomeState {}

class ShowEmojiState extends HomeState {}

class CloseEmojiState extends HomeState {}
