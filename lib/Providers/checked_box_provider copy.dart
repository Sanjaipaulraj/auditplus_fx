import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditplus_fx/Providers/value_provider.dart';

import '../api_methods/api_methods.dart';

class CheckedBoxProvider extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  // Map<String, bool> _mmValues = _mmEmptyValues();
  Map<String, Map<String, bool>> mmValuesPerSymbol = {};
  Map<String, Map<String, bool>> am1ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am2ValuesPerSymbol = {};

  static Map<String, bool> _mmEmptyValues() => {
    'LongTcChecked': false,
    'LongTtChecked': false,
    'LongNeoChecked': false,
    'LongM1MfChecked': false,
    'LongM1TrendChecked': false,
    'LongM1ReversalChecked': false,
    'LongConfChecked': false,
    'LongDivergenceChecked': false,
    'LongRevChecked': false,
    'LongCatcherChecked': false,
    'LongM2MfChecked': false,
    'LongM2TrendChecked': false,
    'LongM2ReversalChecked': false,
    'LongGretTcChecked': false,
    'LongSigCrTtChecked': false,
    'ShortTcChecked': false,
    'ShortTtChecked': false,
    'ShortNeoChecked': false,
    'ShortM1MfChecked': false,
    'ShortM1TrendChecked': false,
    'ShortM1ReversalChecked': false,
    'ShortConfChecked': false,
    'ShortDivergenceChecked': false,
    'ShortRevChecked': false,
    'ShortCatcherChecked': false,
    'ShortM2MfChecked': false,
    'ShortM2TrendChecked': false,
    'ShortM2ReversalChecked': false,
    'ShortGretTcChecked': false,
    'ShortSigCrTtChecked': false,
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

  //Generic getter
  // Map<String, bool> getValues(String method, String symbol) {
  //   if (method == "MM") {
  //     return mmValuesPerSymbol.putIfAbsent(symbol, () => _mmEmptyValues());
  //   } else if (method == "AM1") {
  //     return am1ValuesPerSymbol.putIfAbsent(symbol, () => _am1EmptyValues());
  //   } else if (method == "AM2") {
  //     return am2ValuesPerSymbol.putIfAbsent(symbol, () => _am2EmptyValues());
  //   }
  //   throw Exception("Invalid method");
  // }
  Map<String, bool> getValues(String method, String symbol) {
    if (method == "MM") {
      return mmValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM1") {
      return am1ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM2") {
      return am2ValuesPerSymbol[symbol] ?? {};
    }
    throw Exception("Invalid method");
  }

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

  // bool get isLongTcChecked => _mmValues['LongTcChecked']!;
  // bool get isLongTtChecked => _mmValues['LongTtChecked']!;
  // bool get isLongNeoChecked => _mmValues['LongNeoChecked']!;
  // bool get isLongM1MfChecked => _mmValues['LongM1MfChecked']!;
  // bool get isLongM1TrendChecked => _mmValues['LongM1TrendChecked']!;
  // bool get isLongM1ReversalChecked => _mmValues['LongM1ReversalChecked']!;
  // bool get isLongConfChecked => _mmValues['LongConfChecked']!;
  // bool get isLongDivergenceChecked => _mmValues['LongDivergenceChecked']!;
  // bool get isLongRevChecked => _mmValues['LongRevChecked']!;
  // bool get isLongCatcherChecked => _mmValues['LongCatcherChecked']!;
  // bool get isLongM2MfChecked => _mmValues['LongM2MfChecked']!;
  // bool get isLongM2TrendChecked => _mmValues['LongM2TrendChecked']!;
  // bool get isLongM2ReversalChecked => _mmValues['LongM2ReversalChecked']!;
  // bool get isLongGretTcChecked => _mmValues['LongGretTcChecked']!;
  // bool get isLongSigCrTtChecked => _mmValues['LongSigCrTtChecked']!;

  // bool get isShortTcChecked => _mmValues['ShortTcChecked']!;
  // bool get isShortTtChecked => _mmValues['ShortTtChecked']!;
  // bool get isShortNeoChecked => _mmValues['ShortNeoChecked']!;
  // bool get isShortM1MfChecked => _mmValues['ShortM1MfChecked']!;
  // bool get isShortM1TrendChecked => _mmValues['ShortM1TrendChecked']!;
  // bool get isShortM1ReversalChecked => _mmValues['ShortM1ReversalChecked']!;
  // bool get isShortConfChecked => _mmValues['ShortConfChecked']!;
  // bool get isShortDivergenceChecked => _mmValues['ShortDivergenceChecked']!;
  // bool get isShortRevChecked => _mmValues['ShortRevChecked']!;
  // bool get isShortCatcherChecked => _mmValues['ShortCatcherChecked']!;
  // bool get isShortM2MfChecked => _mmValues['ShortM2MfChecked']!;
  // bool get isShortM2TrendChecked => _mmValues['ShortM2TrendChecked']!;
  // bool get isShortM2ReversalChecked => _mmValues['ShortM2ReversalChecked']!;
  // bool get isShortGretTcChecked => _mmValues['ShortGretTcChecked']!;
  // bool get isShortSigCrTtChecked => _mmValues['ShortSigCrTtChecked']!;

  // bool get isMM1ReversalPlusPlusChecked => _mmValues['MM1ReversalPlusPlusChecked']!;
  // bool get isMM1ReversalPlusChecked => _mmValues['MM1ReversalPlusChecked']!;
  // bool get isMM1ReversalChecked => _mmValues['MM1ReversalChecked']!;
  // bool get isMM1SignalExitChecked => _mmValues['MM1SignalExitChecked']!;
  // bool get isMM1TcChangeChecked => _mmValues['MM1TcChangeChecked']!;
  // bool get isMM1HwChecked => _mmValues['MM1HwChecked']!;
  // bool get isMM1MfChecked => _mmValues['MM1MfChecked']!;
  // bool get isMM1HWTHChecked => _mmValues['MM1HWTHChecked']!;
  // bool get isMM2ReversalPlusPlusChecked => _mmValues['MM2ReversalPlusPlusChecked']!;
  // bool get isMM2ReversalPlusChecked => _mmValues['MM2ReversalPlusChecked']!;
  // bool get isMM2ReversalChecked => _mmValues['MM2ReversalChecked']!;
  // bool get isMM2SignalExitChecked => _mmValues['MM2SignalExitChecked']!;
  // bool get isMM2TcChangeChecked => _mmValues['MM2TcChangeChecked']!;
  // bool get isMM2HwChecked => _mmValues['MM2HwChecked']!;
  // bool get isMM2MfChecked => _mmValues['MM2MfChecked']!;
  // bool get isMM2HWTHChecked => _mmValues['MM2HWTHChecked']!;

  bool getValue(String symbol, String method, String field) {
    final values = getValues(method, symbol);

    // 🔥 KEY FIX
    if (values.isEmpty) return false;

    return values[field] ?? false;
  }

  // bool get isLongAllChecked => isLongTcChecked && isLongTtChecked && isLongNeoChecked && isLongConfChecked;
  bool isLongAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (v['LongTcChecked'] ?? false) &&
        (v['LongTtChecked'] ?? false) &&
        (v['LongNeoChecked'] ?? false) &&
        (v['LongConfChecked'] ?? false);
  }

  // bool get isShortAllChecked => isShortTcChecked && isShortTtChecked && isShortNeoChecked && isShortConfChecked;
  bool isShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (v['ShortTcChecked'] ?? false) &&
        (v['ShortTtChecked'] ?? false) &&
        (v['ShortNeoChecked'] ?? false) &&
        (v['ShortConfChecked'] ?? false);
  }
  // bool get isM1LongAllChecked =>
  //     (isLongAllChecked && isLongM1MfChecked && isLongM1TrendChecked) ||
  //     (isLongAllChecked && !isLongM1MfChecked && isLongM1ReversalChecked && isLongM1TrendChecked);

  bool isM1LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return ((isLongAllChecked(symbol) && (v['LongM1MfChecked'] ?? false) && (v['LongM1TrendChecked'] ?? false)) ||
        (isLongAllChecked(symbol)) &&
            !(v['LongM1MfChecked'] ?? false) &&
            (v['LongM1ReversalChecked'] ?? false) &&
            (v['LongM1TrendChecked'] ?? false));
  }

  // bool get isM1ShortAllChecked =>
  //     (isShortAllChecked && isShortM1MfChecked && isShortM1TrendChecked) ||
  //     (isShortAllChecked && !isShortM1MfChecked && isShortM1ReversalChecked && isShortM1TrendChecked);

  bool isM1ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['ShortAllChecked'] ?? false) &&
            (v['ShortM1MfChecked'] ?? false) &&
            (v['ShortM1TrendChecked'] ?? false)) ||
        ((v['ShortAllChecked'] ?? false) &&
            !(v['ShortM1MfChecked'] ?? false) &&
            (v['ShortM1ReversalChecked'] ?? false) &&
            (v['ShortM1TrendChecked'] ?? false)));
  }

  // bool get isM2LongAllChecked =>
  //     ((isLongDivergenceChecked || isLongRevChecked) &&
  //         isLongCatcherChecked &&
  //         isLongM2MfChecked &&
  //         isLongM2TrendChecked) ||
  //     ((isLongDivergenceChecked || isLongRevChecked) &&
  //         isLongCatcherChecked &&
  //         !isLongM2MfChecked &&
  //         isLongM2ReversalChecked &&
  //         isLongM2TrendChecked);

  bool isM2LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['LongDivergenceChecked'] ?? false) || (v['LongRevChecked'] ?? false)) &&
            (v['LongCatcherChecked'] ?? false) &&
            (v['LongM2MfChecked'] ?? false) &&
            (v['LongM2TrendChecked'] ?? false)) ||
        (((v['LongDivergenceChecked'] ?? false) || (v['LongRevChecked'] ?? false)) &&
            (v['LongCatcherChecked'] ?? false) &&
            !(v['LongM2MfChecked'] ?? false) &&
            (v['LongM2ReversalChecked'] ?? false) &&
            (v['LongM2TrendChecked'] ?? false));
  }

  // bool get isM2ShortAllChecked =>
  //     ((isShortDivergenceChecked || isShortRevChecked) &&
  //         isShortCatcherChecked &&
  //         isShortM2MfChecked &&
  //         isShortM2TrendChecked) ||
  //     ((isShortDivergenceChecked || isShortRevChecked) &&
  //         isShortCatcherChecked &&
  //         !isShortM2MfChecked &&
  //         isShortM2TrendChecked &&
  //         isShortM2ReversalChecked);

  bool isM2ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['ShortDivergenceChecked'] ?? false) || (v['ShortRevChecked'] ?? false)) &&
            (v['ShortCatcherChecked'] ?? false) &&
            (v['ShortM2MfChecked'] ?? false) &&
            (v['ShortM2TrendChecked'] ?? false)) ||
        (((v['ShortDivergenceChecked'] ?? false) || (v['ShortRevChecked'] ?? false)) &&
            (v['ShortCatcherChecked'] ?? false) &&
            !(v['ShortM2MfChecked'] ?? false) &&
            (v['ShortM2ReversalChecked'] ?? false) &&
            (v['ShortM2TrendChecked'] ?? false));
  }

  Future<void> loadFromApi(String symbol, String section) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await getSymbolSetting(userId: "1", symbol: symbol, section: section);
      // if (section == 'MM') {
      //   result.forEach((key, value) {
      //     _mmValues[key] = value;
      //   });
      // }
      if (section == 'MM') {
        mmValuesPerSymbol[symbol] = {..._mmEmptyValues(), ...result};
      }

      if (section == 'AM1') {
        am1ValuesPerSymbol[symbol] = {..._am1EmptyValues(), ...result};
      }
      if (section == 'AM2') {
        am2ValuesPerSymbol[symbol] = {..._am2EmptyValues(), ...result};
      }
    } catch (e) {
      // _mmValues = _mmEmptyValues();
      mmValuesPerSymbol.clear();
      am1ValuesPerSymbol.clear();
      am2ValuesPerSymbol.clear();
    }

    _isLoading = false;
    notifyListeners();
  }

  void changeValue(String symbol, String method, String field, BuildContext context) {
    // if (method == "MM1" || method == "MM2") {
    //   _mmValues[field] = !(_mmValues[field] ?? false);

    //   if (field.startsWith('Long')) {
    //     _mmValues[field.replaceFirst('Long', 'Short')] = false;
    //   }
    //   if (field.startsWith('Short')) {
    //     _mmValues[field.replaceFirst('Short', 'Long')] = false;
    //   }
    //   symbolSetting(
    //     userId: "1",
    //     symbol: symbol,
    //     section: "MM", // MM1 / MM2
    //     checkedValues: _mmValues,
    //   );
    // }
    if (method == "MM1" || method == "MM2") {
      // final values = getValues("MM", symbol);

      // values[field] = !(values[field] ?? false);
      // symbolSetting(userId: "1", symbol: symbol, section: "MM", checkedValues: values);
      final oldValues = getValues("MM", symbol);

      final newValues = {...oldValues, field: !(oldValues[field] ?? false)};

      mmValuesPerSymbol[symbol] = newValues;

      symbolSetting(userId: "1", symbol: symbol, section: "MM", checkedValues: newValues);
    }
    if (method == 'AM1') {
      // final values = getValues(method, symbol);

      // values[field] = !(values[field] ?? false);
      // symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: values);
      final oldValues = getValues(method, symbol);

      final newValues = {...oldValues, field: !(oldValues[field] ?? false)};
      am1ValuesPerSymbol[symbol] = newValues;

      symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: newValues);
    }
    if (method == 'AM2') {
      // final values = getValues(method, symbol);

      // values[field] = !(values[field] ?? false);
      // symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: values);
      final oldValues = getValues(method, symbol);

      final newValues = {...oldValues, field: !(oldValues[field] ?? false)};

      am2ValuesPerSymbol[symbol] = newValues;

      symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: newValues);
    }
    notifyListeners();
    if (field == 'MM1ReversalPlusPlusChecked' ||
        field == 'MM1ReversalPlusChecked' ||
        field == 'MM1ReversalChecked' ||
        field == 'MM1SignalExitChecked' ||
        field == 'MM1TcChangeChecked' ||
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
        field == 'MM2TcChangeChecked' ||
        field == 'MM2HwChecked' ||
        field == 'MM2HWTHChecked' ||
        field == 'MM2MfChecked') {
      final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else if (field == 'AM1ReversalPlusPlusChecked' ||
        field == 'AM1ReversalPlusChecked' ||
        field == 'AM1ReversalChecked' ||
        field == 'AM1SignalExitChecked' ||
        field == 'AM1TcChangeChecked' ||
        field == 'AM1HwChecked' ||
        field == 'AM1HWTHChecked' ||
        field == 'AM1MfChecked') {
      final currentSymbol = symbol;
      updateAutoTradeFlags(currentSymbol, method, context);
    } else if (field == 'AM2ReversalPlusPlusChecked' ||
        field == 'AM2ReversalPlusChecked' ||
        field == 'AM2ReversalChecked' ||
        field == 'AM2SignalExitChecked' ||
        field == 'AM2TcChangeChecked' ||
        field == 'AM2HwChecked' ||
        field == 'AM2HWTHChecked' ||
        field == 'AM2MfChecked') {
      final currentSymbol = symbol;
      updateAutoTradeFlags(currentSymbol, method, context);
      // updateTradeFlags(crntMod, context);
    } else {
      return;
    }
  }

  void clearState(String method) {
    if (method == 'MM1' || method == 'MM2') {
      // _mmValues = _mmEmptyValues();
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

  //Automatic Closing per list Tile
  bool getAutoValue(String symbol, String method, String field) {
    if (method == 'AM1' || method == 'AM2') {
      return getValues(method, symbol)[field] ?? false;
    }
    return false;
  }
}
