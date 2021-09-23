part of 'faq_cubit.dart';


abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqInitial extends FaqState {}

class FaqSuccess extends FaqState {
  final FaqApiResModel model;

  FaqSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class FaqError extends FaqState {
  final String message;

  FaqError(this.message);

  @override
  List<Object> get props => [message];
}
