import 'package:bloc_examples/abcd/sensors/sensors_view.dart';
import 'package:bloc_examples/screens/Home.dart';
import 'package:bloc_examples/screens/SensorsScreen/SensorsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugRepaintRainbowEnabled = true;
  BlocOverrides.runZoned(
        () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyBLOCs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SensorsPage()
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition( bloc, transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
