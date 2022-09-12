import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'main.dart';

class AddEditPage extends StatefulWidget {
  final List? list;
  final int? index;
  AddEditPage({required this.list, required this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController id = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = 'http://127.0.0.1/crud_mysql/edit.php';
      http.post(Uri.parse(url), body: {
        'id': id.text,
        'fistname': firstName.text,
        'lastname': lastName.text,
        'phone': phone.text,
        'address': address.text,
      });
    } else {
      var url = 'http://127.0.0.1/crud_mysql/add.php';
      http.post(Uri.parse(url), body: {
        'id': id.text,
        'fistname': firstName.text,
        'lastname': lastName.text,
        'phone': phone.text,
        'address': address.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      id.text = widget.list![widget.index as int]['id'];
      firstName.text = widget.list![widget.index as int]['fistname'];
      lastName.text = widget.list![widget.index as int]['lastname'];
      phone.text = widget.list![widget.index as int]['phone'];
      address.text = widget.list![widget.index as int]['address'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Data'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: id,
              decoration: const InputDecoration(
                labelText: 'Id Person',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: firstName,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: lastName,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: address,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  addUpdateData();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
                debugPrint('Clicked RaisedButton Button');
              },
              child: Text(
                editMode ? 'Update' : 'Save',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
