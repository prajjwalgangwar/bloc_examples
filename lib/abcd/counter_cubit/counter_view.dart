
import 'package:bloc_examples/abcd/counter_cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';


class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    // final bloc = BlocProvider.of<CounterBloc>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red.shade100,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 200,
                  padding: EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black,
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: BlocBuilder<CounterCubit, int>(
                    builder: (context, state) {
                      return Text(state.toString(), textAlign: TextAlign.center,);
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black
                      ),
                      onPressed: () {
                        context.read<CounterCubit>().decrement();
                      }, child: const Icon(IconlyBold.volume_down)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black
                      ),
                      onPressed: () {
                        context.read<CounterCubit>().reset();
                      }, child: const Icon(IconlyBold.hide)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black
                      ),
                      onPressed: () {
                        context.read<CounterCubit>().increment();
                      }, child: const Icon(IconlyBold.volume_up)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

