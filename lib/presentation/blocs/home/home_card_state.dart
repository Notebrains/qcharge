part of 'home_card_cubit.dart';


abstract class HomeCardState extends Equatable {
  const HomeCardState();

  @override
  List<Object> get props => [];
}

class HomeCardInitial extends HomeCardState {}

class HomeCardSuccess extends HomeCardState {
  final HomeCardApiResModel model;

  HomeCardSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class HomeCardError extends HomeCardState {
  final String message;

  HomeCardError(this.message);

  @override
  List<Object> get props => [message];
}
