import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_task/bloc/service.dart';
import 'package:flutter_task/models/model.dart';

part 'beer_event.dart';
part 'beer_state.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  final BeerService beerService;

  BeerBloc({required this.beerService}) : super(BeerInitial()) {
    on<FetchBeers>((event, emit) async {
      emit(BeerLoading());

      try {
        final List<Code> beers =
            await beerService.fetchBeers(abv: event.abv, ibu: event.ibu);
        emit(BeerLoaded(beers: beers));
      } catch (e) {
        emit(BeerError(message: 'Failed to fetch beers'));
      }
    });

    on<FetchBeerDetails>((event, emit) async {
      emit(BeerLoading());

      try {
        final Code beer = await beerService.fetchBeerDetails(event.beerId);
        emit(BeerLoaded(beers: [beer]));
      } catch (e) {
        emit(BeerError(message: 'Failed to fetch beer details'));
      }
    });
  }
}
