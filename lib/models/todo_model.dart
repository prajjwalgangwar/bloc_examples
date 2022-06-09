import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;

  const Todo({
    required this.title,
  });

  @override
  List<Object> get props => [title];
}
