import 'package:flutter/material.dart';
import 'json_class.dart';

class DetailPage extends StatelessWidget {

  final Product product;

  DetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
    );
  }
}
