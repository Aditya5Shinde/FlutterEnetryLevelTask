import 'package:flutter/material.dart';
import 'package:shop/Product.dart';

class ItemCard extends StatelessWidget {
  final Map product;


  void show (){
    print(product);
  }

  const ItemCard({
    required this.product
  }) ;



  @override
  Widget build(BuildContext context) {
    show();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Hero(
              tag: "I dont know",
              child: Image.asset(product['ImageUrl']),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20 / 4),
          child: Text(
            product['Title'],
            style: TextStyle(color:Colors.black),
          ),
        ),
        Text(
         '${ product['Price']}',
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}