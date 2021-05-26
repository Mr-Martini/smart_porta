import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleSignInCanceledFailure extends Failure {}

class UnknownFailure extends Failure {}

class NetworkFailure extends Failure {}