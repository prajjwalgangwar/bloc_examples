part of 'order_detail_cubit.dart';

abstract class OrderDetailState {
  const OrderDetailState();
}

class OrderDetailInitial extends OrderDetailState {}

class OrderPackedState extends OrderDetailState {
  final bool buttonvisible;
  OrderPackedState({required this.buttonvisible});
}

class ItemAddState extends OrderDetailState {
  int count;
  ItemAddState(this.count);
}

class ItemRemoveState extends OrderDetailState {
  int count;
  ItemRemoveState(this.count);
}

class OtpVisibleState extends OrderDetailState {

}
