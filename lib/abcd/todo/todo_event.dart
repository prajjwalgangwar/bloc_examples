import 'package:equatable/equatable.dart';



abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoInitialEvent extends TodoEvent {}
class TodoAddEvent extends TodoEvent {}

class TodoRemoveEvent extends TodoEvent{}
