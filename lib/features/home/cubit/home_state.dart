part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomePageLoading extends HomeState {
  final int page;
  HomePageLoading(this.page);
  @override
  List<Object> get props => [];
}

class HomePageLoaded extends HomeState{
  final List<Data> users;

  HomePageLoaded(this.users);
  @override
  List<Object> get props => [users];
}