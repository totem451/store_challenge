// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_challenge/src/bloc/bloc.dart';
import 'package:store_challenge/src/model/models.dart';
import 'package:store_challenge/src/service/favorite_service.dart';
import 'package:store_challenge/src/service/services.dart';

class FavoritesView extends StatefulWidget {
  FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late BLOC bloc;
  @override
  void initState() {
    bloc = new BLOC(StateS());
    bloc.add(LoadDataEvent());
    super.initState();
  }

  final favoritesService = FavoriteService();
  generateFavorites(favorites) {
    List<Widget> list = [];
    favorites.forEach((favorite) {
      list.add(InkWell(
        onTap: () {},
        child: Padding(
          child: Row(
            children: <Widget>[
              Padding(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        favoritesService.deleteFavorites(favorite.name);
                        bloc.add(LoadDataEvent());
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    AutoSizeText(
                      '${favorite.name}',
                      minFontSize: 5,
                      style: TextStyle(fontFamily: "Roboto", fontSize: 18),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04),
              ),
            ],
          ),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.007,
              top: MediaQuery.of(context).size.height * 0.007,
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02),
        ),
      ));
    });
    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    late List<FavoriteModel> favorites;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Favorites',
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 46, 46, 46),
        child: BlocListener(
          bloc: bloc,
          listener: (context, state) {},
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is InitialState) {
                return Center(
                    heightFactor: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ));
              }
              if (state is LoadDataState) {
                return generateFavorites(state.favorites);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
