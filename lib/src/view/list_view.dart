// ignore_for_file: unnecessary_new

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_challenge/src/bloc/bloc.dart';
import 'package:store_challenge/src/model/category_model.dart';
import 'package:store_challenge/src/model/favorite_model.dart';
import 'package:store_challenge/src/model/models.dart';
import 'package:store_challenge/src/service/services.dart';
import 'package:store_challenge/src/view/create_view.dart';
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
  late List<CategoryModel> categories;
  late List<ProductModel> products;
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

  generateProducts(categoryName, products, favorites) {
    List<Widget> list = [];
    bool isFavorite = false;
    products.forEach((product) {
      favorites.forEach((favorite) {
        if (product.name == favorite.name) {
          isFavorite = true;
        }
      });
      if (product.category == categoryName) {
        list.add(Padding(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  productService.deleteProducts(product.name);
                  SnackBar(
                      content: Text('Product ${product.name} is deleted',
                          style: TextStyle(color: Colors.white)));
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
                color: isFavorite ? Colors.red : Colors.blue,
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
      isFavorite = false;
    });
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Column(
                  children: list, mainAxisAlignment: MainAxisAlignment.start),
            ));
  }

  generateCategories(products, categories, favorites) {
    List<Widget> list = [];
    categories.forEach((category) {
      list.add(InkWell(
        onTap: () => generateProducts(category.name, products, favorites),
        child: Padding(
          child: Row(
            children: <Widget>[
              Padding(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        categoryService.deleteCategories(category.name);
                        SnackBar(
                            content: Text(
                                'Category ${category.name} is deleted',
                                style: TextStyle(color: Colors.white)));
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
                      categories = state.categories;
                      products = state.products;
                      return generateCategories(
                          state.products, state.categories, state.favorites);
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
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateView(
                        categories: categories, products: products))),
            child: const Icon(Icons.add),
            heroTag: 'btn2',
          ),
        ],
      ),
    );
  }
}
