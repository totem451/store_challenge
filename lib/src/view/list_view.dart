import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_challenge/src/bloc/bloc.dart';
import 'package:store_challenge/src/model/models.dart';
import 'package:store_challenge/src/service/services.dart';
import 'package:store_challenge/src/view/loading_view.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {
  final productService = ProductService();
  final categoryService = CategoryService();
  final bloc = BLOC();
  @override
  void initState() {
    // TODO: implement initState
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
          widget.title,
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 46, 46, 46),
        child: ListView(
          children: [
            BlocListener(
              bloc: bloc,
              listener: (context, state) {},
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is InitialState) {
                    // return LoadingScreen();
                    return Text('loading');
                  }
                  if (state is LoaderProductsAndCategoriesState) {
                    // return generateProductsAndCategories(
                    //     state.products, state.categories);
                    return Text('list');
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
