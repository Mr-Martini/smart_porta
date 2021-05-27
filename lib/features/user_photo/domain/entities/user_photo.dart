import 'package:equatable/equatable.dart';

class UserPhoto extends Equatable {

  final String url;

  UserPhoto({required this.url});

  @override
  List<Object?> get props => [url];

}