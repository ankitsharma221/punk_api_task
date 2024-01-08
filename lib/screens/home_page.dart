import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/bloc/beer_bloc.dart';
import 'package:flutter_task/screens/details_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController abvController = TextEditingController();
  final TextEditingController ibuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Punk Beers',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.teal,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Beers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                _buildFilterTextField(
                  controller: abvController,
                  labelText: 'Enter ABV value',
                  textColor: Colors.white,
                ),
                SizedBox(height: 8),
                _buildFilterTextField(
                  controller: ibuController,
                  labelText: 'Enter IBU value',
                  textColor: Colors.white,
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: Icon(Icons.filter_list),
                  label: Text('Apply Filter'),
                  onPressed: () {
                    double? abv = double.tryParse(abvController.text);
                    double? ibu = double.tryParse(ibuController.text);
                    BlocProvider.of<BeerBloc>(context)
                        .add(FetchBeers(abv: abv, ibu: ibu));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BeerBloc, BeerState>(
              builder: (context, state) {
                if (state is BeerLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BeerLoaded) {
                  return ListView.builder(
                    itemCount: state.beers.length,
                    itemBuilder: (context, index) {
                      final beer = state.beers[index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            beer.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'ABV: ${beer.abv}%, IBU: ${beer.ibu ?? 'N/A'}',
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              beer.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BeerDetailsPage(beer: beer),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (state is BeerError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTextField({
    required TextEditingController controller,
    required String labelText,
    required Color textColor,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        labelStyle: TextStyle(color: textColor),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
