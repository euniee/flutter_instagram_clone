import 'package:flutter/material.dart';
import 'package:flutter_instgram_clone/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){ //로그인 성공하면 여기에 데이터가 있음

          return TabPage(snapshot.data);
        }else{
          return LoginPage();
        }
      },

    );
  }
}
