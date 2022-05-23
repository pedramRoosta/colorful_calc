import 'package:colorful_calc/setup.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseView<T extends Object> extends StatelessWidget {
  const BaseView({Key? key}) : super(key: key);

  T get viewModel => getIt<T>();
}
