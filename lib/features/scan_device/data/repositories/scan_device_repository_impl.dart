import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/scan_device/data/data_sources/scan_device_local_datasource.dart';
import 'package:smart_porta/features/scan_device/domain/entities/scan_device.dart';
import 'package:smart_porta/features/scan_device/domain/repositories/scan_device_repository.dart';

class ScanDeviceRepositoryImpl implements ScanDeviceRepository {
  final ScanDeviceLocalDataSource dataSource;

  ScanDeviceRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, ScanDevice>> scan() async {
    try {
      final result = await dataSource.scan();
      return Success(result);
    } on NoUserException {
      return Error(NoUserFailure());
    } on QRCanceledException catch (err) {
      print("QRCanceledException is $err");
      return Error(QRCodeCanceledFailure());
    } on QRCodeException catch (err) {
      print("QRCodeException is $err");
      return Error(QRCodeFailure());
    } catch (err) {
      print("err is $err");
      return Error(UnknownFailure());
    }
  }
}
