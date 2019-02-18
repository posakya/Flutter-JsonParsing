import 'package:flutter/material.dart';
import 'dart:async';
import 'json_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Json Parsing'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Product>> _getProducts() async {
    var url = await http
        .get("http://shopswipe.edcel.com.sg/public/api/productList/9");

    var data = json.decode(url.body);
    var jsonData = data["products"] as List;

    List<Product> products = [];

    for (var row in jsonData) {
      Product product =
          Product(row["name"], row["product_image"], row["description"]);
      products.add(product);
    }
    print(products.length);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
            future: _getProducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);

              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading...."),
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[index].product_image),
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].description),
                      onTap: (){
                        Navigator.push(context,
                           new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                        );
                      },
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
