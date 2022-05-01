// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_challenge/src/bloc/bloc.dart';
import 'package:store_challenge/src/service/services.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({Key? key}) : super(key: key);

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {
  final productService = ProductService();
  final categoryService = CategoryService();
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

  generateProductsAndCategories(products, categories) {
    List<Widget> list = [];
    categories.forEach((category) {
      list.add(InkWell(
        onTap: () {},
        child: Padding(
          child: Row(
            children: <Widget>[
              Padding(
                child: Text(category.name),
                // child: AutoSizeText(
                //   '${category.name}',
                //   minFontSize: 5,
                //   style: TextStyle(
                //       fontFamily: "Roboto",
                //       color: Color(0xFF767676),
                //       fontSize: 13),
                // ),
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
              BlocListener(
                bloc: bloc,
                listener: (context, state) {},
                child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is InitialState) {
                      return Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                      // return Text(
                      //   'loading',
                      //   style: TextStyle(color: Colors.red),
                      // );
                    }
                    if (state is LoadDataState) {
                      // return generateProductsAndCategories(
                      //     state.products, state.categories);
                      return Text(
                        'list',
                        style: TextStyle(color: Colors.red),
                      );
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
