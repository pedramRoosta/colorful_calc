import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator_state.freezed.dart';

abstract class CalcBaseState {}

@freezed
class CalcState extends CalcBaseState with _$CalcState {
  const factory CalcState.loaded({required String text}) = Loaded;
}
