import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/Homepage.dart';
import 'QueryHelp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? EmaiController;
  TextEditingController? PassController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    EmaiController = TextEditingController();
    PassController = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    EmaiController?.dispose();
    PassController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String Evals;
    String Pass;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Image.network(
                'https://picsum.photos/seed/383/600',
                width: 265.4,
                height: 254.2,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 104.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Text(
                  'Login',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 45),
                ),
              ),
              Container(
                width: 100,
                height: 31.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(
                    Icons.alternate_email_sharp,
                    color: Colors.black,
                    size: 32,
                  ),
                  Container(
                    width: 44.9,
                    height: 31.7,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                        controller: EmaiController,
                        autofocus: true,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Email ID',
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
                        ),
                        style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.lock_outlined,
                    color: Colors.black,
                    size: 32,
                  ),
                  Container(
                    width: 44.9,
                    height: 31.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: PassController,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 62.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              ButtonTheme(
                minWidth: 341.8,
                height: 46,
                child: ElevatedButton(
                  onPressed: () async {
                    LoginCalls UserAuth = new LoginCalls(
                      Email: EmaiController!.text,
                      Password: PassController!.text,
                    );
                    var Scode = await UserAuth.Network();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (Scode == 200) {
                      prefs.setBool('Check', true);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home(ProductList: jsonDecode(prefs.getString('Productlist')!),)),
                        );
                      });
                    }
                  },
                  child: Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
