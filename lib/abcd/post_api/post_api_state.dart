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
  final String errorMessage;

  const FormErrorState(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class FormLoadingState extends PostApiState{
  @override
  List<Object?> get props => [];
}

class PickedImageState extends PostApiState{
  final PickedFile imageFile;

  const PickedImageState(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class DatePickedState extends PostApiState{
  final String dob;

  const DatePickedState(this.dob);

  @override
  List<Object?> get props => [dob];
}

class UploadedSuccessState extends PostApiState{
  final ApiDetails apiDetails;

  UploadedSuccessState(this.apiDetails);

  @override
  List<Object?> get props => [apiDetails];
}