class Operation {
  String? _firstOperand;
  String? _secondOperand;
  String? _operator;

  String? calculate() {
    if (_firstOperand != null && _secondOperand != null) {
      final firstOperand = double.tryParse(_firstOperand!);
      final secondOperand = double.tryParse(_secondOperand!);
      if (firstOperand != null && secondOperand != null) {
        switch (_operator) {
          case '/':
            return (firstOperand / secondOperand).toString();
          case '*':
            return (firstOperand * secondOperand).toString();
          case '+':
            return (firstOperand + secondOperand).toString();
          case '-':
            return (firstOperand - secondOperand).toString();
        }
      }
    }
    return null;
  }

  // String backSpace(String text) {
  //   text = text.substring(0, _txtCtrl.text.length - 1);
  // }
}
