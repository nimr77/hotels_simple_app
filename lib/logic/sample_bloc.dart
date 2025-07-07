import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}

// Events
abstract class CounterEvent {}

class Decrement extends CounterEvent {}

class Increment extends CounterEvent {}
