part of 'home_banner_cubit.dart';

abstract class HomeBannerState extends Equatable {
  const HomeBannerState();

  @override
  List<Object> get props => [];
}

class HomeBannerInitial extends HomeBannerState {}

class HomeBannerSuccess extends HomeBannerState {
  final HomeBannerApiResModel model;

  HomeBannerSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class HomeBannerError extends HomeBannerState {
  final String message;

  HomeBannerError(this.message);

  @override
  List<Object> get props => [message];
}
