part of 'post_api_cubit.dart';

abstract class PostApiState extends Equatable {
  const PostApiState();
}

class PostApiInitial extends PostApiState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PostApiState{
  @override
  List<Object?> get props => [];
}

class SuccessState extends PostApiState{
  final String token;
  const SuccessState(this.token);

  @override
  List<Object?> get props => [token];
}

class ErrorState extends PostApiState{
  @override
  List<Object?> get props => [];
}

class FormSubmittedState extends PostApiState{
  @override
  List<Object?> get props => [];
}

class FormErrorState extends PostApiState{
  @override
  List<Object?> get props => [];
}