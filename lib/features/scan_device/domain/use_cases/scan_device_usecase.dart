import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/core/params/no_params.dart';
import 'package:smart_porta/features/core/usecases/async_usecase.dart';
import 'package:smart_porta/features/scan_device/domain/entities/scan_device.dart';
import 'package:smart_porta/features/scan_device/domain/repositories/scan_device_repository.dart';

class ScanDeviceUseCase extends AsyncUseCase<ScanDevice, NoParams> {

  final ScanDeviceRepository repository;

  ScanDeviceUseCase({required this.repository});

  @override
  Future<Result<Failure, ScanDevice>> call(NoParams params) {
    return repository.scan();
  }

}