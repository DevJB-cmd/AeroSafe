import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class ReportPersistenceService {
  ReportPersistenceService._privateConstructor();
  static final ReportPersistenceService _instance =
      ReportPersistenceService._privateConstructor();
  factory ReportPersistenceService() => _instance;

  Future<Directory> _getReportsDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final reportsDir = Directory('${dir.path}/aerosafe_reports');
    if (!await reportsDir.exists()) {
      await reportsDir.create(recursive: true);
    }
    return reportsDir;
  }

  Future<File> _reportFile(String id) async {
    final dir = await _getReportsDirectory();
    return File('${dir.path}/report_$id.json');
  }

  Future<void> saveReport(Map<String, dynamic> report) async {
    try {
      final id = report['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
      final file = await _reportFile(id.toString());
      final jsonStr = const JsonEncoder.withIndent('  ').convert(report);
      await file.writeAsString(jsonStr, flush: true);
      if (kDebugMode) {
        // ignore: avoid_print
        print('Report saved: ${file.path}');
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('Failed to save report: $e');
      }
      rethrow;
    }
  }

  Future<List<FileSystemEntity>> listSavedReports() async {
    final dir = await _getReportsDirectory();
    return dir.list().toList();
  }

  Future<String?> readReport(String id) async {
    final file = await _reportFile(id);
    if (!await file.exists()) return null;
    return file.readAsString();
  }
}
