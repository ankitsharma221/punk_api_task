import 'package:flutter_task/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BeerService {
  static const String apiUrl = 'https://api.punkapi.com/v2/beers';

  Future<List<Code>> fetchBeers({double? abv, double? ibu}) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Code> beers = jsonData.map((beer) => Code.fromJson(beer)).toList();
      if (abv != null) {
        beers =
            beers.where((beer) => beer.abv != null && beer.abv >= abv).toList();
      }
      if (ibu != null) {
        beers = beers
            .where((beer) => beer.ibu != null && beer.ibu! >= ibu)
            .toList();
      }
      return beers;
    } else {
      throw Exception('Failed to fetch beers');
    }
  }

  Future<Code> fetchBeerDetails(int beerId) async {
    final response = await http.get(Uri.parse('$apiUrl/$beerId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return Code.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch beer details');
    }
  }
}
