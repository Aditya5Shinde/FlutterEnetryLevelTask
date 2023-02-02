import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LogIn.dart';
import 'Homepage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Product.dart';
import 'dart:convert';

void main() {
  runApp(
    const MaterialApp(home: Splash()),
  );
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool? visiting;

  void share() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Productlist', jsonEncode(superMap));
    visiting = prefs.getBool('Check');
    if (prefs.getBool('Check') != null) {
      if (prefs.getBool('Check') == false) {
        prefs.setString('Productlist', jsonEncode(superMap));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      } else {
        var product2 = prefs.getString('Productlist');
        Map addingjason = jsonDecode(product2!);
        prefs.setString('Productlist', jsonEncode(addingjason));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home(ProductList: jsonDecode(prefs.getString('Productlist')!))),
          );
        });
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });
    }
  }

  @override
  void initState() {
    share();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SpinKitPouringHourGlassRefined(color: Colors.redAccent);
  }
}
