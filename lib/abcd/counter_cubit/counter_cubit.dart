import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => state <10 ? emit(state + 1): null;

  void decrement() => state > 0 ? emit(state - 1) : null;

  void reset() => emit(0);
}
