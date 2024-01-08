import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/bloc/beer_bloc.dart';
import 'package:flutter_task/bloc/service.dart';
import 'package:flutter_task/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punk API App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            BeerBloc(beerService: BeerService())..add(FetchBeers()),
        child: MyHomePage(),
      ),
    );
  }
}
