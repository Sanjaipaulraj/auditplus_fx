import 'dart:io';
// import 'dart:typed_data';

import 'package:excel/excel.dart';
// import 'package:file_saver/file_saver.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import 'models/models.dart';

Future<void> createExcelFile(List<DbReportModel> reports) async {
  // print(reports);

  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  if (reports.isEmpty) return;

  final headers = reports.first.toMap().keys.toList();

  for (int col = 0; col < headers.length; col++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0)).value = TextCellValue(headers[col]);
  }

  for (int row = 0; row < reports.length; row++) {
    final values = reports[row].toMap().values.toList();

    for (int col = 0; col < values.length; col++) {
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1)).value = TextCellValue(
        values[col]?.toString() ?? '',
      );
    }
  }
  try {
    List<int>? fileBytes = excel.encode();
    if (fileBytes != null) {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/my_data.xlsx');

      await file.writeAsBytes(fileBytes);

      print("Saved at: ${file.path}");

      await OpenFilex.open(file.path);
    }
  } catch (e) {
    print('Error saving file: $e');
  }
}

Future<Directory> getProjectDirectory() async {
  return Directory(Directory.current.path); // current Project folder path
}
