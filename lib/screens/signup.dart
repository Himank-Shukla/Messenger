import 'package:flutter/material.dart';
import 'package:messenger/screens/home_screen.dart';
import 'package:messenger/screens/login.dart';
import 'package:messenger/models/methods.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: isLoading ? Center(child:  Container(
        child: CircularProgressIndicator(),
      ),) :Column(
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
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration.collapsed(
                    hintText: "Enter Your Name",
                  ),
                )),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _email,
                  decoration:
                      InputDecoration.collapsed(hintText: "Enter Your Email"),
                )),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 75),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  obscureText: true,
                  controller: _password,
                  decoration:
                      InputDecoration.collapsed(hintText: "Enter Password"),
                )),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
          MaterialButton(
            onPressed: () {if (_name.text.isNotEmpty &&
                _email.text.isNotEmpty &&
                _password.text.isNotEmpty) {
              setState(() {
                isLoading = true;
              });

              createAccount(_name.text, _email.text, _password.text)
                  .then((user) {
                if (user != null) {
                  setState(() {
                    isLoading = false;
                  });Navigator.push(context,MaterialPageRoute(builder: (_)=>HomeScreen()));
                  print("Account Created");
                } else {
                  print("Signup Failed");
                  setState(() {
                    isLoading = false;
                  });
                }
              });
            } else {
              print("Please enter Fields");
            }},
            child: Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            textColor: Colors.white,
            color: Colors.black,
            minWidth: 200,
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),

            // style: ButtonStyle(
            //   backgroundColor: MaterialColor(Colors.accents)
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () => Navigator.pop(
                    context,
                    // MaterialPageRoute(
                    //   builder: (_) => Login(),
                    // ),
                  ),
              child: Text(
                "Already have an account? Signin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ))
        ],
      ),
    );
  }
}
