import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {

  final FirebaseUser user;
  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         'Instagram Clone',
          style : TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      ),
      body: _buildBody(),
    );
  }

 Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('Instagram에 오신 것을 환영합니다',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text('사진과 동영상을 보려면 팔로우하세요',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  SizedBox(
                    width: 300.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(3.0)),
                            SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUrl),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5.0)),
                            Text(user.email,
                              style : TextStyle(fontWeight: FontWeight.bold)),
                            Text(user.displayName),
                            Padding(padding: EdgeInsets.all(5.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Image.network('https://klear.com/images/anonUser.jpg', fit: BoxFit.cover),
                                ),
                                Padding(padding: EdgeInsets.all(1.0)),
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Image.network('https://klear.com/images/anonUser.jpg',fit: BoxFit.cover),
                                ),
                                Padding(padding: EdgeInsets.all(1.0)),
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Image.network('https://klear.com/images/anonUser.jpg',fit: BoxFit.cover),
                                ),
                                Padding(padding: EdgeInsets.all(1.0)),
                              ],
                            ),
                          Padding(padding: EdgeInsets.all(3.0)),
                            Text('Facebook 친구'),
                            Padding(padding: EdgeInsets.all(3.0)),
                            RaisedButton(
                              child: Text('팔로우'),
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              onPressed: (){},
                            ),
                            Padding(padding: EdgeInsets.all(3.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
 }
}
