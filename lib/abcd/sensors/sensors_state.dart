import 'package:equatable/equatable.dart';

// enum SensorStatus { initial, fetched, failure }

class SensorsState extends Equatable {
  final List<Map<String, dynamic>> sensorsList;
  final bool isMore;
  final bool isDisable;

  const SensorsState(
      {this.sensorsList = const <Map<String, dynamic>>[],
      this.isMore = true,
        this.isDisable = false,
      });

  SensorsState copyWith(
      {List<Map<String, dynamic>>? sensorsList,
        bool? isMore,
        bool? isDisable,
      }) {
    return SensorsState(
        sensorsList: sensorsList ?? this.sensorsList,
        isMore: isMore ?? this.isMore,
        isDisable: isDisable ?? this.isDisable
    );
  }

  @override
  List<Object?> get props => [sensorsList, isDisable, isMore];
}

// class SensorsErrorState extends SensorsState{
//   final String errorMessage;
//   SensorsErrorState(this.errorMessage);
// }
