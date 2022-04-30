import 'package:flutter/material.dart';

class CreateView extends StatefulWidget {
  CreateView({Key? key}) : super(key: key);

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
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
        decoration: InputDecoration(
            labelText: 'Enter name',
            labelStyle: TextStyle(color: Colors.white)),
      )),
      Center(
          child: TextFormField(
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
        decoration: InputDecoration(
            labelText: 'Enter name',
            labelStyle: TextStyle(color: Colors.white)),
      )),
      Center(
          child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Enter category',
          labelStyle: TextStyle(color: Colors.white),
        ),
      )),
      Center(
          child: TextFormField(
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
        onPressed: () {},
        child: const Icon(Icons.check),
      ),
    );
  }
}
