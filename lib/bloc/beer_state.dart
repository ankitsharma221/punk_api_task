part of 'beer_bloc.dart';

abstract class BeerState extends Equatable {
  const BeerState();

  @override
  List<Object> get props => [];
}

class BeerInitial extends BeerState {}

class BeerLoading extends BeerState {}

class BeerLoaded extends BeerState {
  final List<Code> beers;

  BeerLoaded({required this.beers});

  @override
  List<Object> get props => [beers];
}

class BeerError extends BeerState {
  final String message;

  BeerError({required this.message});

  @override
  List<Object> get props => [message];
}
