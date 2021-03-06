import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleSignInCanceledFailure extends Failure {}

class UnknownFailure extends Failure {}

class NetworkFailure extends Failure {}

class NoUserFailure extends Failure {}

class QRCodeCanceledFailure extends Failure {}

class QRCodeFailure extends Failure {}

class NotAllowedFailure extends Failure {}

class NoPhotoUrlFailure extends Failure {}

class UnknownDioFailure extends Failure {}

class NoDeviceFailure extends Failure {}