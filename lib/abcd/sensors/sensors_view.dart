import 'package:bloc_examples/screens/SensorsScreen/SensorsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sensors_bloc.dart';
import 'sensors_event.dart';
import 'sensors_state.dart';

class SensorsPage extends StatelessWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SensorsBloc(),
      child: Builder(builder: (context) => SensorsView()),
    );
  }

}

