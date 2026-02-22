import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<PermissionStatus> requestCameraPermission() async {
    try {
      final status = await Permission.camera.request();
      return status;
    } catch (e) {
      print('Error requesting camera permission: $e');
      return PermissionStatus.denied;
    }
  }

  Future<PermissionStatus> checkCameraPermission() async {
    try {
      return await Permission.camera.status;
    } catch (e) {
      print('Error checking camera permission: $e');
      return PermissionStatus.denied;
    }
  }

  Future<Map<String, String>?> captureAndSavePhoto(int measureNo) async {
    try {
      final status = await checkCameraPermission();
      if (!status.isGranted) {
        final newStatus = await requestCameraPermission();
        if (!newStatus.isGranted) {
          return null;
        }
      }

      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (photo == null) {
        return null;
      }

      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final filename = 'plc_measure_${measureNo}_$timestamp.jpg';
      final appDir = await getApplicationDocumentsDirectory();
      final savedPath = '[0;35m${appDir.path}/$filename';
      final File sourceFile = File(photo.path);
      final File savedFile = await sourceFile.copy(savedPath);
      return {
        'filename': filename,
        'path': savedFile.path,
        'uri': savedFile.uri.toString(),
      };
    } catch (e) {
      print('Error capturing and saving photo: $e');
      return null;
    }
  }

  Future<String> getAppStoragePath() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      return appDir.path;
    } catch (e) {
      print('Error getting app storage path: $e');
      return '';
    }
  }
}