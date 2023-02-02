import 'dart:convert';
import 'dart:io';
import 'Homepage.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:file_picker/file_picker.dart';

class FormstoAdd extends StatefulWidget {
  const FormstoAdd({Key? key}) : super(key: key);

  @override
  _FormstoAddState createState() => _FormstoAddState();
}

class _FormstoAddState extends State<FormstoAdd> {
  TextEditingController? NameController;
  TextEditingController? PriceController;
  late File file;
  String? path;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Map ListOfProduct;

  @override
  void initState() {
    super.initState();
    NameController = TextEditingController();
    PriceController = TextEditingController();
  }

  @override
  void dispose() {
    NameController?.dispose();
    PriceController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 127.4,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            TextFormField(
              controller: NameController,
              autofocus: true,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: 'Name',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                filled: true,
                fillColor: Color(0xFF75CFD8),
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              width: double.infinity,
              height: 362.6,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.network(
                'https://picsum.photos/seed/620/600',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            ButtonTheme(
              minWidth: 341.8,
              height: 46,
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    file = File(result.files.single.path!);
                    path = file.path;
                  } else {
                    // User canceled the picker
                  }
                },
                child: const Text("Pic Image"),
              ),
            ),
            TextFormField(
              controller: PriceController,
              autofocus: true,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: 'Price',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                filled: true,
                fillColor: Color(0xFF75CFD8),
              ),
              textAlign: TextAlign.center,
            ),
            ButtonTheme(
              minWidth: 341.8,
              height: 46,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences adding =
                      await SharedPreferences.getInstance();
                  Map addingjason =
                      jsonDecode(adding.getString('Productlist')!);
                  addingjason.addEntries({
                    '${addingjason.length}': {
                      "Title": NameController!.text,
                      "Price": int.parse(PriceController!.text),
                      "ImageUrl": path,
                    }
                  }.entries);
                  adding.setString('Productlist', jsonEncode(addingjason));
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home(ProductList:addingjason)),
                    );
                  });
                  print(jsonDecode(adding.getString('Productlist')!));
                  print('Add');
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
