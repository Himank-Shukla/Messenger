import 'package:flutter/material.dart';
import 'package:messenger/screens/home_screen.dart';
import 'package:messenger/screens/signup.dart';
import 'package:messenger/models/methods.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   colors: [Colors.red, Colors.white],
                // ),
              ), // LinearGradient
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "MESSENGER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // TextFormField(
                  //
                  //   decoration: InputDecoration(
                  //     labelText: "Enter Your Name",
                  //     fillColor: Colors.white,
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: const BorderSide(color: Colors.white,width: 2),
                  //       borderRadius: BorderRadius.circular(20)
                  //     )
                  //   ),
                  // ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              controller: _email,
                          decoration: InputDecoration.collapsed(
                              hintText: "Enter Your Email"),
                        )),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 75),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              controller: _password,
                          obscureText: true,
                          decoration: InputDecoration.collapsed(
                              hintText: "Enter Password"),
                        )),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        logIn(_email.text, _password.text).then((user) {
                          if (user != null) {
                            print("Login Sucessfull");
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                          } else {
                            print("Login Failed");
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      } else {
                        print("Please fill form correctly");
                      }
                    },
                    child: Text(
                      "LOGIN",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    textColor: Colors.white,
                    color: Colors.black,
                    minWidth: 200,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Signup(),
                            ),
                          ),
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
