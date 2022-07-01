import 'package:flutter_sensors/flutter_sensors.dart';

abstract class XSensorsEvent {}

class XSensorsInitialEvent extends XSensorsEvent{}

class XGyroscopeEvent extends XSensorsEvent{
  XGyroscopeEvent();
}

class AvailableSensorsEvent extends XSensorsEvent{

}