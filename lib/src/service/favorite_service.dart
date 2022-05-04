import 'dart:convert';

import 'package:store_challenge/src/model/models.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  final String url = 'https://createthrivestore-default-rtdb.firebaseio.com/';
  Future<List<FavoriteModel>> listFavorites() async {
    List<FavoriteModel> favorites = [];
    var resp = await http.get(Uri.parse(url + 'favorite.json'));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> favoritesMap = json.decode(resp.body);
      favoritesMap.forEach((key, value) {
        final tempFavorite = FavoriteModel.fromMap(value);
        favorites.add(tempFavorite);
      });
    }
    return favorites;
  }

  deleteFavorites(name) async {
    var resp = await http.post(Uri.parse(url + 'favorite/$name.json'));
    return resp.statusCode;
  }

  addFavorites(name) async {
    var body = jsonEncode({"name": "$name"});

    var resp = await http.post(
      Uri.parse(url + 'favorite.json'),
      body: body,
    );
    return resp.statusCode;
  }
}
