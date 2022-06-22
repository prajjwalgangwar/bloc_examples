import 'package:equatable/equatable.dart';
import '../../models/todo_model.dart';

enum TodoStateType { add, remove }

class TodoState extends Equatable {
  final List<Todo> todos;
  final int index;

  const TodoState({this.todos = const <Todo>[], this.index = 0});

  TodoState copyWith({List<Todo>? todos, int? index}) {
    return TodoState(todos: todos ?? this.todos, index: index ?? this.index);
  }

  @override
  List<Object> get props => [todos, index];
}
