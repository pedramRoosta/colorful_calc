import 'package:colorful_calc/bases/base_view_model.dart';
import 'package:colorful_calc/views/calculator_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@singleton
class CalcViewModel extends BaseViewModel<CalcBaseState> {
  CalcViewModel() : super(const Loaded(text: ''));

  List<String> numbers = [];
  List<String> operators = [];
  void addText(String str) {
    if (isNumber(str) || isNumber(getLastChar())) {
      String text = (state as Loaded).text;
      text += str;
      emit(Loaded(text: text));
    }
  }

  String getLastChar() {
    final text = (state as Loaded).text;
    if (text.isNotEmpty) {
      return text.substring(text.length - 1);
    }
    return '';
  }

  bool isNumber(String str) {
    if (str.isNotEmpty) {
      final code = str.codeUnitAt(0);
      if (code >= 48 && code <= 57 || code == 46) {
        return true;
      }
      return false;
    }
    return true;
  }

  void clearText() {
    emit(const Loaded(text: ''));
  }

  void showResult() {
    final text = (state as Loaded).text.split('');
    operators = [];
    numbers = [];
    String word = '';

    for (var char in text) {
      if (isNumber(char)) {
        word += char;
      } else {
        operators.add(char);
        numbers.add(word);
        word = '';
      }
    }
    numbers.add(word);
    double result = double.parse(numbers[0]);
    for (var i = 0; i < operators.length; i++) {
      switch (operators[i]) {
        case '+':
          result += double.parse(numbers[i + 1]);
          break;
        case '-':
          result -= double.parse(numbers[i + 1]);
          break;
        case '/':
          result /= double.parse(numbers[i + 1]);
          break;
        case '*':
          result *= double.parse(numbers[i + 1]);
          break;
        default:
      }
    }
    emit(Loaded(text: result.toString()));
  }
}
