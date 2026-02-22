import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import '../models/measurement.dart';

class ExportService {
  Future<String?> exportToCSV(List<Measurement> measurements) async {
    try {
      if (measurements.isEmpty) {
        return null;
      }

      final List<List<String>> csvData = [];
      csvData.add(['measure_no','photo_filename','photo_path','description','improvement_measure','priority','created_at']);

      for (final measurement in measurements) {
        csvData.add([
          measurement.measureNo.toString(),
          _escapeCSV(measurement.photoFilename),
          _escapeCSV(measurement.photoPath),
          _escapeCSV(measurement.description),
          _escapeCSV(measurement.improvementMeasure),
          measurement.priority,
          measurement.createdAt.toIso8601String(),
        ]);
      }

      final csv = const ListToCsvConverter().convert(csvData);
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final filename = 'plc_inspection_export_$timestamp.csv';
      final appDir = await getApplicationDocumentsDirectory();
      final filepath = '${appDir.path}/$filename';
      final file = File(filepath);
      await file.writeAsString(csv, encoding: utf8);

      return filepath;
    } catch (e) {
      print('Error exporting to CSV: $e');
      return null;
    }
  }

  Future<String?> exportToJSON(List<Measurement> measurements) async {
    try {
      if (measurements.isEmpty) {
        return null;
      }

      final jsonData = {
        'exported_at': DateTime.now().toIso8601String(),
        'records': measurements.map((m) {
          return {
            'measure_no': m.measureNo,
            'photo_filename': m.photoFilename,
            'photo_path': m.photoPath,
            'description': m.description,
            'improvement_measure': m.improvementMeasure,
            'priority': m.priority,
            'created_at': m.createdAt.toIso8601String(),
          };
        }).toList(),
      };

      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final filename = 'plc_inspection_export_$timestamp.json';
      final appDir = await getApplicationDocumentsDirectory();
      final filepath = '${appDir.path}/$filename';
      final file = File(filepath);
      await file.writeAsString(jsonEncode(jsonData), encoding: utf8);

      return filepath;
    } catch (e) {
      print('Error exporting to JSON: $e');
      return null;
    }
  }

  String _escapeCSV(String value) {
    if (value.isEmpty) return '';
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  Future<bool> fileExists(String filepath) async {
    try {
      return await File(filepath).exists();
    } catch (e) {
      return false;
    }
  }
}