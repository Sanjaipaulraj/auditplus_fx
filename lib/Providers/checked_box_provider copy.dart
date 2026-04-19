import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditplus_fx/Providers/value_provider.dart';

import '../api_methods/api_methods.dart';

class CheckedBoxProvider extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Map<String, Map<String, bool>> mmValuesPerSymbol = {};
  Map<String, Map<String, bool>> am1ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am2ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am3ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am4ValuesPerSymbol = {};

  static Map<String, bool> _mmEmptyValues() => {
    'LongTcChecked': false,
    'LongTtChecked': false,
    'LongNeoChecked': false,
    'LongSignalChecked': false,
    'LongSignalExitChecked': false,
    'LongMfChecked': false,
    'LongHwChecked': false,
    'LongReversalChecked': false,
    'LongReversalPlusChecked': false,
    'LongDivergenceChecked': false,
    'ShortTcChecked': false,
    'ShortTtChecked': false,
    'ShortNeoChecked': false,
    'ShortSignalChecked': false,
    'ShortSignalExitChecked': false,
    'ShortMfChecked': false,
    'ShortHwChecked': false,
    'ShortReversalChecked': false,
    'ShortReversalPlusChecked': false,
    'ShortDivergenceChecked': false,
    'MM1ReversalPlusPlusChecked': false,
    'MM1ReversalPlusChecked': false,
    'MM1ReversalChecked': false,
    'MM1SignalExitChecked': false,
    'MM1TcChangeChecked': false,
    'MM1HwChecked': false,
    'MM1MfChecked': false,
    'MM1HWTHChecked': false,
    'MM2ReversalPlusPlusChecked': false,
    'MM2ReversalPlusChecked': false,
    'MM2ReversalChecked': false,
    'MM2SignalExitChecked': false,
    'MM2TcChangeChecked': false,
    'MM2HwChecked': false,
    'MM2MfChecked': false,
    'MM2HWTHChecked': false,
    'MM3ReversalPlusPlusChecked': false,
    'MM3ReversalPlusChecked': false,
    'MM3ReversalChecked': false,
    'MM3SignalExitChecked': false,
    'MM3TcChangeChecked': false,
    'MM3HwChecked': false,
    'MM3MfChecked': false,
    'MM3HWTHChecked': false,
    'MM4ReversalPlusPlusChecked': false,
    'MM4ReversalPlusChecked': false,
    'MM4ReversalChecked': false,
    'MM4SignalExitChecked': false,
    'MM4TcChangeChecked': false,
    'MM4HwChecked': false,
    'MM4MfChecked': false,
    'MM4HWTHChecked': false,
  };

  static Map<String, bool> _am1EmptyValues() => {
    'AM1ReversalPlusPlusChecked': false,
    'AM1ReversalPlusChecked': false,
    'AM1ReversalChecked': false,
    'AM1SignalExitChecked': false,
    'AM1TcChangeChecked': false,
    'AM1HwChecked': false,
    'AM1MfChecked': false,
    'AM1HWTHChecked': false,
  };

  static Map<String, bool> _am2EmptyValues() => {
    'AM2ReversalPlusPlusChecked': false,
    'AM2ReversalPlusChecked': false,
    'AM2ReversalChecked': false,
    'AM2SignalExitChecked': false,
    'AM2TcChangeChecked': false,
    'AM2HwChecked': false,
    'AM2MfChecked': false,
    'AM2HWTHChecked': false,
  };

  static Map<String, bool> _am3EmptyValues() => {
    'AM3ReversalPlusPlusChecked': false,
    'AM3ReversalPlusChecked': false,
    'AM3ReversalChecked': false,
    'AM3SignalExitChecked': false,
    'AM3TcChangeChecked': false,
    'AM3HwChecked': false,
    'AM3MfChecked': false,
    'AM3HWTHChecked': false,
  };

  static Map<String, bool> _am4EmptyValues() => {
    'AM4ReversalPlusPlusChecked': false,
    'AM4ReversalPlusChecked': false,
    'AM4ReversalChecked': false,
    'AM4SignalExitChecked': false,
    'AM4TcChangeChecked': false,
    'AM4HwChecked': false,
    'AM4MfChecked': false,
    'AM4HWTHChecked': false,
  };

  //Generic getter
  Map<String, bool> getValues(String method, String symbol) {
    if (method == "MM") {
      return mmValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM1") {
      return am1ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM2") {
      return am2ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM3") {
      return am3ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM4") {
      return am4ValuesPerSymbol[symbol] ?? {};
    }
    throw Exception("Invalid method");
  }

  bool getValue(String symbol, String method, String field) {
    final map = getValues(method, symbol);
    return map[field] ?? false;
  }

  bool isLongAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (v['LongTcChecked'] ?? false) && (v['LongTtChecked'] ?? false) && (v['LongNeoChecked'] ?? false);
  }

  bool isShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (v['ShortTcChecked'] ?? false) && (v['ShortTtChecked'] ?? false) && (v['ShortNeoChecked'] ?? false);
  }

  bool isM1LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (isLongAllChecked(symbol) && (v['LongMfChecked'] ?? false) && (v['LongSignalChecked'] ?? false));
  }

  bool isM1ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isShortAllChecked(symbol) && (v['ShortMfChecked'] ?? false) && (v['ShortSignalChecked'] ?? false));
  }

  bool isM2LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isLongAllChecked(symbol) &&
        (v['LongSignalChecked'] ?? false) &&
        ((v['LongReversalChecked'] ?? false) || (v['LongReversalPlusChecked'] ?? false)));
  }

  bool isM2ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isShortAllChecked(symbol) &&
        (v['ShortSignalChecked'] ?? false) &&
        ((v['ShortReversalChecked'] ?? false) || (v['ShortReversalPlusChecked'] ?? false)));
  }

  bool isM3LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isLongAllChecked(symbol) && (v['ShortSignalExitChecked'] ?? false));
  }

  bool isM3ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isShortAllChecked(symbol) && (v['LongSignalExitChecked'] ?? false));
  }

  bool isM4LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['LongReversalPlusChecked'] ?? false) || (v['LongDivergenceChecked'] ?? false)) &&
        (v['LongTcChecked'] ?? false) &&
        ((v['LongMfChecked'] ?? false) || (v['LongHwChecked'] ?? false)));
  }

  bool isM4ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['ShortReversalPlusChecked'] ?? false) || (v['ShortDivergenceChecked'] ?? false)) &&
        (v['ShortTcChecked'] ?? false) &&
        ((v['ShortMfChecked'] ?? false) || (v['ShortHwChecked'] ?? false)));
  }

  Future<void> loadFromApi(String symbol, String section) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await getSymbolSetting(userId: "1", symbol: symbol, section: section);

      if (section == 'MM') {
        mmValuesPerSymbol[symbol] = {..._mmEmptyValues(), ...result};
      }
      if (section == 'AM1') {
        am1ValuesPerSymbol[symbol] = {..._am1EmptyValues(), ...result};
      }
      if (section == 'AM2') {
        am2ValuesPerSymbol[symbol] = {..._am2EmptyValues(), ...result};
      }
      if (section == 'AM3') {
        am3ValuesPerSymbol[symbol] = {..._am3EmptyValues(), ...result};
      }
      if (section == 'AM4') {
        am4ValuesPerSymbol[symbol] = {..._am4EmptyValues(), ...result};
      }
    } catch (e) {
      mmValuesPerSymbol.clear();
      am1ValuesPerSymbol.clear();
      am2ValuesPerSymbol.clear();
      am3ValuesPerSymbol.clear();
      am4ValuesPerSymbol.clear();
    }

    _isLoading = false;
    notifyListeners();
  }

  void changeValue(String symbol, String method, String field, BuildContext context) {
    if (method == "MM1" || method == "MM2" || method == "MM") {
      mmValuesPerSymbol[symbol]![field] = !(mmValuesPerSymbol[symbol]![field] ?? false);

      if (field.startsWith('Long')) {
        mmValuesPerSymbol[symbol]![field.replaceFirst('Long', 'Short')] = false;
      }
      if (field.startsWith('Short')) {
        mmValuesPerSymbol[symbol]![field.replaceFirst('Short', 'Long')] = false;
      }
      symbolSetting(
        userId: "1",
        symbol: symbol,
        section: "MM", // MM1 / MM2
        checkedValues: mmValuesPerSymbol[symbol]!,
      );
    }
    if (method == 'AM1') {
      am1ValuesPerSymbol[symbol] ??= _am1EmptyValues();
      am1ValuesPerSymbol[symbol]![field] = !(am1ValuesPerSymbol[symbol]![field] ?? false);

      symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: am1ValuesPerSymbol[symbol]!);
    }

    if (method == 'AM2') {
      am2ValuesPerSymbol[symbol] ??= _am2EmptyValues();
      am2ValuesPerSymbol[symbol]![field] = !(am2ValuesPerSymbol[symbol]![field] ?? false);

      symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: am2ValuesPerSymbol[symbol]!);
    }

    if (method == 'AM3') {
      am3ValuesPerSymbol[symbol] ??= _am3EmptyValues();
      am3ValuesPerSymbol[symbol]![field] = !(am3ValuesPerSymbol[symbol]![field] ?? false);

      symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: am3ValuesPerSymbol[symbol]!);
    }

    if (method == 'AM4') {
      am4ValuesPerSymbol[symbol] ??= _am2EmptyValues();
      am4ValuesPerSymbol[symbol]![field] = !(am4ValuesPerSymbol[symbol]![field] ?? false);

      symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: am4ValuesPerSymbol[symbol]!);
    }
    notifyListeners();
    if (field == 'MM1ReversalPlusPlusChecked' ||
        field == 'MM1ReversalPlusChecked' ||
        field == 'MM1ReversalChecked' ||
        field == 'MM1SignalExitChecked' ||
        // field == 'MM1TcChangeChecked' ||
        field == 'MM1HwChecked' ||
        field == 'MM1HWTHChecked' ||
        field == 'MM1MfChecked') {
      final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else if (field == 'MM2ReversalPlusPlusChecked' ||
        field == 'MM2ReversalPlusChecked' ||
        field == 'MM2ReversalChecked' ||
        field == 'MM2SignalExitChecked' ||
        // field == 'MM2TcChangeChecked' ||
        field == 'MM2HwChecked' ||
        field == 'MM2HWTHChecked' ||
        field == 'MM2MfChecked') {
      final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else if (field == 'MM3ReversalPlusPlusChecked' ||
        field == 'MM3ReversalPlusChecked' ||
        field == 'MM3ReversalChecked' ||
        field == 'MM3SignalExitChecked' ||
        // field == 'MM3TcChangeChecked' ||
        field == 'MM3HwChecked' ||
        field == 'MM3HWTHChecked' ||
        field == 'MM3MfChecked') {
      final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else if (field == 'MM4ReversalPlusPlusChecked' ||
        field == 'MM4ReversalPlusChecked' ||
        field == 'MM4ReversalChecked' ||
        field == 'MM4SignalExitChecked' ||
        // field == 'MM4TcChangeChecked' ||
        field == 'MM4HwChecked' ||
        field == 'MM4HWTHChecked' ||
        field == 'MM4MfChecked') {
      final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else if (field == 'AM1ReversalPlusPlusChecked' ||
        field == 'AM1ReversalPlusChecked' ||
        field == 'AM1ReversalChecked' ||
        field == 'AM1SignalExitChecked' ||
        // field == 'AM1TcChangeChecked' ||
        field == 'AM1HwChecked' ||
        field == 'AM1HWTHChecked' ||
        field == 'AM1MfChecked') {
      final currentSymbol = symbol;
      updateAutoTradeFlags(currentSymbol, method, context);
    } else if (field == 'AM2ReversalPlusPlusChecked' ||
        field == 'AM2ReversalPlusChecked' ||
        field == 'AM2ReversalChecked' ||
        field == 'AM2SignalExitChecked' ||
        // field == 'AM2TcChangeChecked' ||
        field == 'AM2HwChecked' ||
        field == 'AM2HWTHChecked' ||
        field == 'AM2MfChecked') {
      final currentSymbol = symbol;
      updateAutoTradeFlags(currentSymbol, method, context);
    } else if (field == 'AM3ReversalPlusPlusChecked' ||
        field == 'AM3ReversalPlusChecked' ||
        field == 'AM3ReversalChecked' ||
        field == 'AM3SignalExitChecked' ||
        // field == 'AM3TcChangeChecked' ||
        field == 'AM3HwChecked' ||
        field == 'AM3HWTHChecked' ||
        field == 'AM3MfChecked') {
      final currentSymbol = symbol;
      updateAutoTradeFlags(currentSymbol, method, context);
    } else if (field == 'AM4ReversalPlusPlusChecked' ||
        field == 'AM4ReversalPlusChecked' ||
        field == 'AM4ReversalChecked' ||
        field == 'AM4SignalExitChecked' ||
        // field == 'AM4TcChangeChecked' ||
        field == 'AM4HwChecked' ||
        field == 'AM4HWTHChecked' ||
        field == 'AM4MfChecked') {
      final currentSymbol = symbol;
      updateAutoTradeFlags(currentSymbol, method, context);
    } else {
      return;
    }
  }

  void clearState(String method) {
    if (method == 'MM1' || method == 'MM2' || method == 'MM') {
      mmValuesPerSymbol.clear();
    }
    if (method == 'AM1') {
      am1ValuesPerSymbol.clear();
    }
    if (method == 'AM2') {
      am2ValuesPerSymbol.clear();
    }
    notifyListeners();
  }
}
