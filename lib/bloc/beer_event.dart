part of 'beer_bloc.dart';

abstract class BeerEvent extends Equatable {
  const BeerEvent();
}

class FetchBeers extends BeerEvent {
  final double? abv;
  final double? ibu;

  FetchBeers({this.abv, this.ibu});

  @override
  List<Object?> get props => [abv, ibu];
}

class FetchBeerDetails extends BeerEvent {
  final int beerId;

  FetchBeerDetails({required this.beerId});

  @override
  List<Object> get props => [beerId];
}
