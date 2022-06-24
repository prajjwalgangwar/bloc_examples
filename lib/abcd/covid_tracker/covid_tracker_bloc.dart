import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'covid_tracker_event.dart';
import 'covid_tracker_state.dart';

class Covid_trackerBloc extends Bloc<Covid_trackerEvent, Covid_trackerState> {
  Covid_trackerBloc() : super(Covid_trackerState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<Covid_trackerState> emit) async {
    emit(state.clone());
  }



}
