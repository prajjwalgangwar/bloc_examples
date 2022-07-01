import 'package:equatable/equatable.dart';

// enum SensorStatus { initial, fetched, failure }

class SensorsState extends Equatable {
  final List<Map<String, dynamic>> sensorsList;
  final bool isMore;
  final bool isDisable;
  // final SensorStatus status;
  // final bool isAvailable;

  const SensorsState(
      {this.sensorsList = const <Map<String, dynamic>>[],
      this.isMore = true,
        this.isDisable = false,
      // this.status = SensorStatus.initial
      });

  SensorsState copyWith(
      {List<Map<String, dynamic>>? sensorsList,
        bool? isMore,
        bool? isDisable,
        // SensorStatus? status, bool? isAvailable
      }) {
    return SensorsState(
        sensorsList: sensorsList ?? this.sensorsList,
        isMore: isMore ?? this.isMore,
        isDisable: isDisable ?? this.isDisable
        // isAvailable: isAvailable ?? this.isAvailable,
        // status: status ?? this.status
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [sensorsList];
}

// class SensorsErrorState extends SensorsState{
//   final String errorMessage;
//   SensorsErrorState(this.errorMessage);
// }
