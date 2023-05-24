import 'package:app/view/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/controller/encrypt.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
// TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context)
      => HomePage()));
    }
  }
  @override
  void dispose() {
// Clean up the controller when the widget is disposed.
    _usernamecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/login.png', height: 175,width: 175,),
              const SizedBox(
                height: 16.0,
              ),
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _usernamecontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Username")),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _passwordcontroller,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Password")),
              ),
              const SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  String username = "rvqvDK5MhYWhRK4Ynogsiw==";
                  String password = "vfGtEcxLgoKmQ6kfmY8rjA==";
                  if (EncriptLogin.encrypt(_passwordcontroller.text) ==
                      password &&
                      EncriptLogin.encrypt(_usernamecontroller.text) ==
                          username) {
                    logindata.setBool('login', false);
                    logindata.setString('username', username);
                    Navigator.pushNamed(context, '/HomePage');
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromARGB(255, 0, 118, 228),
                  ),
                  child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: AutofillHints.addressCity,
                            color: Colors.white),
                      )),
                ),
              )
            ]),
      ),
    );
  }
}