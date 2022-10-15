import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Login Page", style: TextStyle(fontFamily: "Pacifico")),
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain, image: AssetImage("images/1.png"))),
          ),
          SizedBox(
            height: 50,
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
              label: Text(
                "Enter your email",
                style: TextStyle(fontFamily: "Pacifico"),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: _isObscure,
            controller: password,
            decoration: InputDecoration(
                label: Text("Enetr your password ",
                    style: TextStyle(fontFamily: "Pacifico")),
                suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: (() {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: (() async {
                  try {
                    var authopject = FirebaseAuth.instance;
                    UserCredential myUser =
                        await authopject.signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(" sucessfully login",
                            style: TextStyle(fontFamily: "Pacifico"))));
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return HomePage();
                    })));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("wrong login",
                            style: TextStyle(fontFamily: "Pacifico"))));
                  }
                }),
                child: Text("Login", style: TextStyle(fontFamily: "Pacifico"))),
          ),
          TextButton(
              onPressed: (() async {
                try {
                  var authopject = FirebaseAuth.instance;
                  UserCredential myUser =
                      await authopject.createUserWithEmailAndPassword(
                          email: email.text, password: password.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("added sucessfully",
                          style: TextStyle(fontFamily: "Pacifico"))));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("sorry this is used ",
                          style: TextStyle(fontFamily: "Pacifico"))));
                }
              }),
              child: Text("Signup", style: TextStyle(fontFamily: "Pacifico"))),
        ],
      ),
    );
  }
}
