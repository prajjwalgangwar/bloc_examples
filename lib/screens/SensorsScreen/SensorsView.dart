import 'package:bloc_examples/abcd/sensors/sensors_bloc.dart';
import 'package:bloc_examples/abcd/sensors/sensors_event.dart';
import 'package:bloc_examples/abcd/sensors/sensors_state.dart';
import 'package:bloc_examples/utilities/app_colors.dart';
import 'package:bloc_examples/utilities/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SensorsView extends StatelessWidget {
  SensorsView({Key? key}) : super(key: key);
  bool isDisable = false;

  @override
  Widget build(BuildContext context) {
    var sensorBloc = BlocProvider.of<SensorsBloc>(context);
    print(sensorBloc.state);
    return SafeArea(
        child: BlocListener<SensorsBloc, SensorsState>(
      listener: (context, state) {

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: BlocBuilder<SensorsBloc, SensorsState>(
              builder: (context, state) {
                // return GridView.builder(
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 3), itemBuilder: (context, index){
                //   return availableSensorsCard(
                //               state.sensorsList.elementAt(index).values.elementAt(0),
                //               AppConstants.globalSensorsList.elementAt(index).values.elementAt(0)[1]);
                // });
                if(!state.isDisable){
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.sensorDarkBlack,
                          width: 7
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: CachedNetworkImageProvider('https://cdn.dribbble.com/users/79356/screenshots/1794811/dribble-animation.gif')
                        )
                      ),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: state.sensorsList.length,
                    itemBuilder: (context, index) {
                      return availableSensorsCard(
                          state.sensorsList
                              .elementAt(index)
                              .values
                              .elementAt(0),
                          AppConstants.globalSensorsList
                              .elementAt(index)
                              .values
                              .elementAt(0)[1]);
                    });
              },
            )),
            BlocBuilder<SensorsBloc, SensorsState>(
              builder: (context, state) {
                // if(state.isDisable == true){
                //   return Center(child: CircularProgressIndicator(),);
                // }
                return Visibility(
                  // visible: !state.isMore ? false : true,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: AppColors.sensorDarkBlack,
                    child: OutlinedButton(onPressed: () async {
                      state.isDisable
                          ? null
                          : sensorBloc.add(AvailableSensorsEvent());
                      print(state.isDisable);
                    }, child: BlocBuilder<SensorsBloc, SensorsState>(
                        builder: (context, state) {
                      if (!state.isDisable) {
                        return const Text(
                          'Check for Available Sensors',
                          style: TextStyle(color: AppColors.sensorDarkCream),
                        );
                      }
                      return const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(color: AppColors.sensorDarkCream,strokeWidth: 2,),);
                    })),
                  ),
                );
              },
            )
          ],
        ),
      ),
    ));
  }

  accelerometerCard() {}

  gyroscopeCard() {}

  Widget availableSensorsCard(bool value, String name) {
    return Container(
        height: 50,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
        decoration: BoxDecoration(
            border: Border.all(
                color: value == true
                    ? AppColors.sensorDarkGreen
                    : Colors.red.shade900,
                width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            value == true
                ? Icon(
                    Icons.done,
                    color: Colors.green.shade900,
                  )
                : Icon(
                    Icons.cancel,
                    color: Colors.red.shade900,
                  ),
          ],
        )
        // ListTile(
        //   tileColor: value==true? AppColors.sensorLightGreen:Colors.red.shade100,
        //   title: Text(name),
        //   trailing: value==true?Icon(Icons.done, color: Colors.green.shade900,): Icon(Icons.not_interested, color: Colors.red.shade900,),
        // ),
        );
  }
}
