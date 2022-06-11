import 'package:bloc_examples/screens/Home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/card_navigation_button.dart';
import 'order_detail_cubit.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<OrderDetailCubit>(context);
    return Material(
        child: SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            CardNavigationButton(
              name: 'Order List Using Cubit',
              color: Colors.amber.shade900,
              navigate: Container(),
            ),
            orderTiming(),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bloc.checkbox.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 150,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue.shade900),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            'https://m.media-amazon.com/images/I/61Xj1A6WCTL._SL1500_.jpg'))),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Column(
                                children: [
                                  ListTile(
                                    isThreeLine: true,
                                    // tileColor: Colors.red[100],
                                    title: const Text(
                                      'name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13,
                                          color: Colors.black),
                                    ),
                                    subtitle: const Text(
                                      "quantity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 11,
                                          color: Colors.black54),
                                    ),
                                    trailing: Column(
                                      children: const [
                                        Text(
                                          "price",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "mrp",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black26),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                          ),
                                          child: const Text(
                                            //todo---------- fetch units --------
                                            "units",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ),
                                      BlocBuilder<OrderDetailCubit,
                                          OrderDetailState>(
                                        builder: (context, state) {
                                          return Checkbox(
                                              fillColor: MaterialStateProperty.all(Colors.green.shade900),
                                              side: BorderSide(
                                                  color: Colors.red.shade900,
                                                  width: 2),
                                              checkColor: Colors.green.shade50,
                                              value: bloc.checkbox[index],
                                              onChanged: (value) {
                                                bloc.itemCheck(index);
                                                print('${bloc.state}');
                                              });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              color: Colors.blue.shade50,
              child: BlocConsumer<OrderDetailCubit, OrderDetailState>(
                listener: (context, state) {

                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              right: 10, left: 20, top: 10, bottom: 10),
                          child: Text('Total items = ${bloc.count}')),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: (state is OrderPackedState ||
                                        state is OtpVisibleState)
                                    ? true
                                    : false,
                                child: BlocBuilder<OrderDetailCubit,
                                    OrderDetailState>(
                                  builder: (context, state) {
                                    if(state is OrderPackedState){
                                      return OutlinedButton(
                                        style: ButtonStyle(
                                            side: MaterialStateProperty.all(BorderSide(
                                                color: Colors.red.shade900
                                            )),
                                            backgroundColor: MaterialStateProperty.all(Colors.red.shade50)
                                        ),
                                        onPressed: () {
                                        bloc.orderPacked();
                                      },
                                        child: Text(bloc.orderStatus[0], style: TextStyle(color: Colors.red.shade900),),
                                      );
                                    }else if(state is OtpVisibleState) {
                                      return OutlinedButton(
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(BorderSide(
                                            color: Colors.blue.shade900
                                          )),
                                          backgroundColor: MaterialStateProperty.all(Colors.blue.shade50)
                                        ),
                                        onPressed: () {

                                      },
                                        child: Text(bloc.orderStatus[1], style: TextStyle(color: Colors.blue.shade900),),
                                      );
                                    }
                                    return Container();
                                  },
                                )),
                            Visibility(
                              visible: (state is OtpVisibleState) ? true : false,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(9),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green.shade900),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  bloc.otp,
                                  style: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.w500, letterSpacing: 3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: (state is OtpVisibleState) ? true : false,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: const Text('before giving package, first verify the delivery person using the above otp', textAlign: TextAlign.center,),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Divider(
              color: Colors.blueGrey.shade100,
              thickness: 2,
            ),
          ],
        )),
      ),
    ));
  }

  Widget orderTiming() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          border: Border.all(color: Colors.indigo.shade900)),
      child: Text(
        "Assigning Delivery Person",
        textAlign: TextAlign.center,
        style: TextStyle(
            letterSpacing: 1,
            wordSpacing: 1,
            color: Colors.indigo.shade900,
            fontSize: 12),
      ),
    );
  }
}
