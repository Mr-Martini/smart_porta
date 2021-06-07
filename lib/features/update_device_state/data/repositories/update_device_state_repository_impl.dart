import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/update_device_state/data/data_sources/update_device_state_remote_service.dart';
import 'package:smart_porta/features/update_device_state/domain/entities/device_state.dart';
import 'package:smart_porta/features/update_device_state/domain/repositories/update_device_state_repository.dart';

class UpdateDeviceStateRepositoryImpl implements UpdateDeviceStateRepository {
  final UpdateDeviceStateRemoteService service;

  UpdateDeviceStateRepositoryImpl({required this.service});

  @override
  Future<Result<Failure, UpdateDeviceState>> updateState(
      bool state, String id) async {
    try {
      final result = await service.updateState(state, id);
      return Success(result);
    } on NotAllowedException {
      return Error(NotAllowedFailure());
    } on NoUserException {
      return Error(NoUserFailure());
    } on DioError catch(err) {
      print("err is ${err.response}");
      return Error(UnknownDioFailure());
    } catch (err) {
      return Error(UnknownFailure());
    }
  }
}
