import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_string/random_string.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailInitial());

  int count = 0;
  String otp = '';
  List<String> orderStatus = ['Mark Order Packed', 'Order Packed'];

  List checkbox =List<bool>.filled(4, false);

  void itemCheck(index){
    if(!checkbox[index]){
      count++;
      checkbox[index] = true;
      emit(ItemAddState(count));
    }else {
      count--;
      checkbox[index] = false;
      emit(ItemRemoveState(count));
    }
    if(count == checkbox.length){
      emit(OrderPackedState(buttonvisible: true));
    }
  }

  void orderPacked(){
    otp = randomNumeric(4);
    emit(OtpVisibleState());
  }

}
