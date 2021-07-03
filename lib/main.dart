import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listagem de Clientes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var items = [];

  @override
  void initState() {
    refreshUsers();
    super.initState();
  }

  Future refreshUsers() async {
    Uri uri =
    Uri.parse('http://vetornegocios.com.br:8080/app/clientes');
    final response = await http.get(uri);
    var data = json.decode(response.body);
    this.items = [];
    setState(() {
      for (var i = 0; i < data.length; i++) {
        this.items.add(data[i]['nome']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshUsers,
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text('${items[index]}'));
            }),
      ),
    );
  }
}
