import 'package:flutter_sensors/flutter_sensors.dart';

class AppConstants{
  static String signupText = 'SIGN UP';
  static String loginText = "LOGIN";

  static String loginPageDesc = "Enter your phone number to login/register";

  static String signupPageDesc = 'Enter your details to create new account';

  static List<Map<int, dynamic>> globalSensorsList = [
    {Sensors.ACCELEROMETER :  [false, 'ACCELEROMETER']},
    {Sensors.ROTATION :  [false, 'ROTATION']},
    {Sensors.SENSOR_STATUS_ACCURACY_MEDIUM :  [false, 'SENSOR_STATUS_ACCURACY_MEDIUM']},
    {Sensors.SENSOR_STATUS_ACCURACY_LOW : [false, 'SENSOR_STATUS_ACCURACY_LOW']},
    {Sensors.SENSOR_STATUS_ACCURACY_HIGH : [false, 'SENSOR_STATUS_ACCURACY_HIGH']},
    {Sensors.LINEAR_ACCELERATION : [false, 'LINEAR_ACCELERATION']},
    {Sensors.MAGNETIC_FIELD : [false, 'MAGNETIC_FIELD']},
    {Sensors.STEP_DETECTOR : [false, 'STEP_DETECTOR']},
    {Sensors.GYROSCOPE : [false, 'GYROSCOPE']},
  ];
}