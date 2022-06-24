import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'covid_tracker_bloc.dart';
import 'covid_tracker_event.dart';
import 'covid_tracker_state.dart';

class Covid_trackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Covid_trackerBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<Covid_trackerBloc>(context);

    return Container();
  }
}

