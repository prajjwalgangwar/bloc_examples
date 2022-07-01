import 'package:bloc/bloc.dart';
import 'package:bloc_examples/abcd/posts/posts_state.dart';
import 'package:bloc_examples/utilities/app_constants.dart';
import 'package:flutter_sensors/flutter_sensors.dart';

import 'sensors_event.dart';
import 'sensors_state.dart';

class SensorsBloc extends Bloc<XSensorsEvent, SensorsState> {
  SensorsBloc() : super(const SensorsState()){
    on<AvailableSensorsEvent>(availableSensorsInPhone);
  }



  void availableSensorsInPhone(AvailableSensorsEvent event, Emitter<SensorsState> emit)async {
    try{
      for(int i = 0; i < AppConstants.globalSensorsList.length; i++){
        bool isAvailable =  await SensorManager().isSensorAvailable(AppConstants.globalSensorsList.elementAt(i).keys.elementAt(0));
        String name = AppConstants.globalSensorsList.elementAt(i).values.elementAt(0)[1];
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(
          isMore: i == 8 ? false : true,
          sensorsList: List.of(state.sensorsList)..add({name : isAvailable}),
          isDisable: true,
        ));
      }
      await Future.delayed(const Duration(seconds: 5));
      emit(state.copyWith(isDisable: false, isMore: true, sensorsList: []));
      print(state.isMore);
    } catch(e){
      throw Exception(e);
    }
  }


}
