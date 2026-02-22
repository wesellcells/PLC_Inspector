import 'package:intl/intl.dart';

class Measurement {
  final int? id;
  final int measureNo;
  final String photoFilename;
  final String photoPath;
  final String description;
  final String improvementMeasure;
  final String priority;
  final DateTime createdAt;

  Measurement({
    this.id,
    required this.measureNo,
    required this.photoFilename,
    required this.photoPath,
    required this.description,
    required this.improvementMeasure,
    required this.priority,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'measure_no': measureNo,
      'photo_filename': photoFilename,
      'photo_path': photoPath,
      'description': description,
      'improvement_measure': improvementMeasure,
      'priority': priority,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      id: map['id'] as int?,
      measureNo: map['measure_no'] as int,
      photoFilename: map['photo_filename'] as String? ?? '',
      photoPath: map['photo_path'] as String? ?? '',
      description: map['description'] as String? ?? '',
      improvementMeasure: map['improvement_measure'] as String? ?? '',
      priority: map['priority'] as String? ?? 'MEDIUM',
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Measurement copyWith({
    int? id,
    int? measureNo,
    String? photoFilename,
    String? photoPath,
    String? description,
    String? improvementMeasure,
    String? priority,
    DateTime? createdAt,
  }) {
    return Measurement(
      id: id ?? this.id,
      measureNo: measureNo ?? this.measureNo,
      photoFilename: photoFilename ?? this.photoFilename,
      photoPath: photoPath ?? this.photoPath,
      description: description ?? this.description,
      improvementMeasure: improvementMeasure ?? this.improvementMeasure,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Measurement(measureNo: $measureNo, priority: $priority, photoFilename: $photoFilename)';
  }
}

class MeasurementDraft extends Measurement {
  MeasurementDraft({
    required super.measureNo,
    super.photoFilename = '',
    super.photoPath = '',
    super.description = '',
    super.improvementMeasure = '',
    super.priority = 'MEDIUM',
    DateTime? createdAt,
  }) : super(
    createdAt: createdAt ?? DateTime.now(),
  );
}