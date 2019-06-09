import 'package:flutter/material.dart';
import 'package:flutter_instgram_clone/tab_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatelessWidget {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Instagram Clon',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
              ),
              Padding(padding: EdgeInsets.all(50.0)),
              SignInButton(
                Buttons.Google,
                onPressed: (){
                  _handleSignIn().then((user){ //then 비동기로 받아온 것 넘어오게 함
                    print(user);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> TabPage(user)));
                  });

              },
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)
    );
    return user;
  }
}
