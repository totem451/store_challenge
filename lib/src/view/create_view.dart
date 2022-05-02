import 'package:flutter/material.dart';
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
  bool isSwitched = false;

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

  category() {
    return Column(children: [
      Center(
          child: TextFormField(
        onFieldSubmitted: (value) {
          cNameInput.value = TextEditingValue(text: value);
        },
        controller: cNameInput,
        decoration: InputDecoration(
            labelText: 'Enter name',
            labelStyle: TextStyle(color: Colors.white)),
      )),
      Center(
          child: TextFormField(
        onFieldSubmitted: (value) {
          cColorInput.value = TextEditingValue(text: value);
        },
        controller: cColorInput,
        decoration: InputDecoration(
          labelText: 'Enter color (hexadecimal)',
          labelStyle: TextStyle(color: Colors.white),
        ),
      )),
    ]);
  }

  product() {
    return Column(children: [
      Center(
          child: TextFormField(
        onFieldSubmitted: (value) {
          pNameInput.value = TextEditingValue(text: value);
        },
        controller: pNameInput,
        decoration: InputDecoration(
            labelText: 'Enter name',
            labelStyle: TextStyle(color: Colors.white)),
      )),
      Center(
          child: TextFormField(
        onFieldSubmitted: (value) {
          pCategoryInput.value = TextEditingValue(text: value);
        },
        controller: pCategoryInput,
        decoration: InputDecoration(
          labelText: 'Enter category',
          labelStyle: TextStyle(color: Colors.white),
        ),
      )),
      Center(
          child: TextFormField(
        onFieldSubmitted: (value) {
          pImageInput.value = TextEditingValue(text: value);
        },
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
            isSwitched ? category() : product(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int cId = 0;
          int cLastId = 0;
          int pId = 0;
          int pLastId = 0;
          bool cNameIsUsed = false;
          bool pNameIsUsed = false;
          widget.categories.forEach((c) {
            if (c.id! >= cLastId) {
              cId = c.id!;
            }
            cLastId = c.id!;
            if (c.name == cNameInput.value.text) {
              cNameIsUsed = true;
            }
          });
          widget.products.forEach((p) {
            if (p.id! >= pLastId) {
              pId = p.id!;
            }
            pLastId = p.id!;
            if (p.name == cNameInput.value.text) {
              pNameIsUsed = true;
            }
          });
          if (!pNameIsUsed || !cNameIsUsed) {
            isSwitched
                ? categoryService.addCategories(
                    cNameInput.value.text, cColorInput.value.text, cId)
                : productService.addProducts(pNameInput.value.text,
                    pCategoryInput.value.text, pId, pImageInput.value.text);
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
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
