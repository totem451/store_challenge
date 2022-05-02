// ignore_for_file: unnecessary_new

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_challenge/src/bloc/bloc.dart';
import 'package:store_challenge/src/model/favorite_model.dart';
import 'package:store_challenge/src/service/services.dart';
import 'package:store_challenge/src/view/favorites_view.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({Key? key}) : super(key: key);

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {
  final productService = ProductService();
  final categoryService = CategoryService();
  final favoriteService = FavoriteService();
  late BLOC bloc;
  @override
  void initState() {
    bloc = new BLOC(StateS());
    bloc.add(LoadDataEvent());
    super.initState();
  }

  toColor(String hexColor) {
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  generateProducts(categoryId, products) {
    List<Widget> list = [];
    products.forEach((product) {
      if (product.category == categoryId) {
        list.add(Padding(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  productService.deleteProducts(product.name);
                  bloc.add(LoadDataEvent());
                },
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
              IconButton(
                onPressed: () {
                  favoriteService.addFavorites(product.name);
                  bloc.add(LoadDataEvent());
                },
                icon: Icon(Icons.favorite),
                color: Colors.blue,
              ),
              AutoSizeText(
                '${product.name}',
                minFontSize: 5,
                style: TextStyle(fontFamily: "Roboto", fontSize: 15),
              ),
            ],
          ),
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
        ));
      }
    });
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Column(
                  children: list, mainAxisAlignment: MainAxisAlignment.start),
            ));
  }

  generateCategories(products, categories) {
    List<Widget> list = [];
    categories.forEach((category) {
      list.add(InkWell(
        onTap: () => generateProducts(category.id, products),
        child: Padding(
          child: Row(
            children: <Widget>[
              Padding(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        categoryService.deleteCategories(category.name);
                        bloc.add(LoadDataEvent());
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    AutoSizeText(
                      '${category.name}',
                      minFontSize: 5,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          color: toColor(category.color),
                          fontSize: 18),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Store',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 46, 46, 46),
        child: Stack(children: [
          ListView(
            children: [
              SizedBox(height: 10),
              Text('    Categories',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 10),
              BlocListener(
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
                      return generateCategories(
                          state.products, state.categories);
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ]),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
            child: const Icon(Icons.favorite),
            heroTag: 'btn1',
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/create'),
            child: const Icon(Icons.add),
            heroTag: 'btn2',
          ),
        ],
      ),
    );
  }
}
