import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  final FirebaseUser user;


  AccountPage(this.user);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  int _postCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); // 내가 올린 게시물의 갯수만 가져옴
    Firestore.instance.collection('post').where('email', isEqualTo: widget.user.email)
    .getDocuments()
    .then((snapShot){
     setState(() {
       _postCount = snapShot.documents.length;
     });
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody() ,


    );
  }

  Widget _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: (){},
        ),
      ],
    );
  }

 Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.user.photoUrl),
                      ),
                    ),
                    Container(
                      width: 80.0,
                      height: 80.0,
                      alignment: Alignment.bottomRight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 28.0,
                            height: 28.0,
                            child: FloatingActionButton(onPressed: null,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 25.0,
                            height: 25.0,
                            child: FloatingActionButton(onPressed: null,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Text(widget.user.displayName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),


              ],
            ),
            Text('$_postCount\n게시물',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            Text('0\n팔로워',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            Text('0\n팔로잉',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
    );
 }
}
