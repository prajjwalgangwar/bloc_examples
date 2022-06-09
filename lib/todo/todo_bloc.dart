import 'package:bloc/bloc.dart';

import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<TodoInitialEvent>(_init);
  }

  void _init(TodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(
      todos: state.todos
    ));
  }
  
  void _addTodo(TodoEvent event, Emitter<TodoState> emit) async{

    // var todos = ;
    emit(state.copyWith(
      // todos: List.of(state.todos)..add(value)
    ));
  }
}
