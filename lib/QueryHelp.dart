import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginCalls
{
  late String Email;
  late String Password;

  LoginCalls({required this.Email , required this.Password});
  Future Network() async{
    var Body;
    http.Response response  = await http.post(Uri.parse('https://reqres.in/api/login'), body: {'email' : Email , 'password': Password });
    Body = response.body;
    print(Body);

   final  jason = jsonDecode(Body);
   print(jason['error']);
     return response.statusCode;
  }

}