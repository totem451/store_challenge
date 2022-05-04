import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_challenge/src/bloc/bloc.dart';
import 'package:store_challenge/src/model/models.dart';
import 'package:store_challenge/src/service/services.dart';

class CreateView extends StatefulWidget {
  List<CategoryModel> categories;
  List<ProductModel> products;
  CreateView({Key? key, required this.categories, required this.products})
      : super(key: key);

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  final categoryService = CategoryService();
  final productService = ProductService();
  TextEditingController cNameInput = TextEditingController();
  TextEditingController cColorInput = TextEditingController();
  TextEditingController pNameInput = TextEditingController();
  TextEditingController pImageInput = TextEditingController();
  TextEditingController pCategoryInput = TextEditingController();
  ProductModel product = ProductModel();
  CategoryModel category = CategoryModel();
  bool isSwitched = false;
  late BLOC bloc;

  void initState() {
    bloc = new BLOC(StateS());
    bloc.add(LoadDataEvent());
    super.initState();
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  categoryF() {
    return Column(children: [
      Center(
          child: TextFormField(
        onChanged: (value) => category.name = value,
        controller: cNameInput,
        decoration: InputDecoration(
            labelText: 'Enter name',
            labelStyle: TextStyle(color: Colors.white)),
      )),
      Center(
          child: TextFormField(
        onChanged: (value) => category.color = value,
        controller: cColorInput,
        decoration: InputDecoration(
          labelText: 'Enter color (hexadecimal)',
          labelStyle: TextStyle(color: Colors.white),
        ),
      )),
    ]);
  }

  productF() {
    return Column(children: [
      Center(
          child: TextFormField(
        onChanged: (value) => product.name = value,
        controller: pNameInput,
        decoration: InputDecoration(
            labelText: 'Enter name',
            labelStyle: TextStyle(color: Colors.white)),
      )),
      Center(
          child: TextFormField(
        onChanged: (value) => product.category = value,
        controller: pCategoryInput,
        decoration: InputDecoration(
          labelText: 'Enter category',
          labelStyle: TextStyle(color: Colors.white),
        ),
      )),
      Center(
          child: TextFormField(
        onChanged: (value) => product.image = value,
        controller: pImageInput,
        decoration: InputDecoration(
          labelText: 'Enter image',
          labelStyle: TextStyle(color: Colors.white),
        ),
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Create',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 46, 46, 46),
        child: BlocListener(
          bloc: bloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          child: ListView(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    onChanged: toggleSwitch,
                    value: isSwitched,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blueGrey,
                    inactiveThumbColor: Colors.redAccent,
                    inactiveTrackColor: Colors.redAccent,
                  ),
                  Text(
                    isSwitched ? 'Category' : 'Product',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Divider(color: Colors.blue, thickness: 1.5),
              SizedBox(height: 30),
              // Text('hola', style: TextStyle(color: Colors.red)),
              isSwitched ? categoryF() : productF(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool cNameIsUsed = false;
          bool pNameIsUsed = false;
          widget.categories.forEach((c) {
            if (c.name == cNameInput.value.text) {
              cNameIsUsed = true;
            }
          });
          widget.products.forEach((p) {
            if (p.name == cNameInput.value.text) {
              pNameIsUsed = true;
            }
          });
          if (!pNameIsUsed || !cNameIsUsed) {
            isSwitched
                ? categoryService.addCategories(category)
                : productService.addProducts(product);
            isSwitched
                ? SnackBar(content: Text('Category $cNameInput is generated'))
                : SnackBar(content: Text('Product $pNameInput is generated'));
          } else {
            isSwitched
                ? SnackBar(
                    content: Text(
                        'Category name $cNameInput is used, please use other'))
                : SnackBar(
                    content: Text(
                        'Product name $pNameInput is used, please use other'));
          }
          bloc.add(LoadDataEvent());
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
