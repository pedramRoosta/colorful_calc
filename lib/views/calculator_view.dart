import 'package:colorful_calc/bases/base_view.dart';
import 'package:colorful_calc/views/calculator_state.dart';
import 'package:colorful_calc/views/calculator_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcView extends BaseView<CalcViewModel> {
  CalcView({Key? key}) : super(key: key);

  final _textHintStyle = TextStyle(
    fontSize: 60,
    fontFamily: 'OpenSans',
    color: Colors.white.withOpacity(0.5),
  );
  final _textStyle = const TextStyle(
    fontSize: 70,
    color: Colors.white,
    fontFamily: 'OpenSans',
  );
  final _buttonStyle = TextStyle(
    fontSize: 55,
    color: Colors.white.withOpacity(0.8),
    fontFamily: 'OpenSans',
  );
  final _txtCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final operators = [
    '/',
    '*',
    '+',
    '-',
  ];
  final buttons = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    '=',
    'C',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color.fromARGB(255, 55, 126, 218),
            Color.fromARGB(255, 7, 204, 255)
          ],
        ),
      ),
      child: Column(
        children: [
          BlocBuilder<CalcViewModel, CalcBaseState>(
            bloc: viewModel,
            builder: (_, state) {
              final text = (state as Loaded).text;
              _txtCtrl.text = text;
              return Container(
                margin: const EdgeInsets.only(top: 80),
                child: TextField(
                  scrollController: _scrollCtrl,
                  controller: _txtCtrl,
                  maxLines: 1,
                  onChanged: (str) {},
                  decoration: InputDecoration(
                    hintText: 'Use my power',
                    hintStyle: _textHintStyle,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color.fromARGB(200, 102, 222, 251),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[^A-Za-z!@#^&]'),
                    ),
                  ],
                  style: _textStyle,
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 90,
                  child: TextButton(
                    onPressed: () => viewModel.backSapace(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  children: _createButtons(buttons),
                ),
              ),
              Column(
                children: _createButtons(operators),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _createButtons(List<String> objectList) {
    final list = <Widget>[];
    for (var button in objectList) {
      list.add(
        SizedBox(
          width: 100,
          height: 90,
          child: TextButton(
            onPressed: () {
              if (button == 'C') {
                viewModel.clearText();
              } else if (button == '=') {
                viewModel.showResult();
              } else {
                viewModel.addText(button);
              }
            },
            child: Center(
              child: Text(
                button,
                style: _buttonStyle,
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }
}
