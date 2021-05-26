import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/scan_device/domain/entities/scan_device.dart';

abstract class ScanDeviceRepository {
  Future<Result<Failure, ScanDevice>> scan();
}