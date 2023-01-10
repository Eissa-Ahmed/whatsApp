part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoginSuccessState extends HomeState {}

class ShowEmojiState extends HomeState {}

class CloseEmojiState extends HomeState {}

class ShowMediaListState extends HomeState {}

class ToggleButtomSendState extends HomeState {}

class SendMessagePhotoLoading extends HomeState {}

class ShowSelectedState extends HomeState {}

class ClosesSelectedState extends HomeState {}

// class SendMessagePhotoSuccess extends HomeState {}
