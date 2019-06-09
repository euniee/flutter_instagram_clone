import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'create_page.dart';
import 'detail_post_page.dart';
class SearchPage extends StatefulWidget {
  FirebaseUser user;
  SearchPage(this.user);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePage(widget.user)));
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.blue,
      ),
    );
  }

 Widget _buildBody() {
    return StreamBuilder(
      stream: Firestore.instance.collection('post').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        var items = snapshot.data ?.documents ?? []; //data가 null 아닐   때 - documents가 null 일 때 []로 처리 : null이 안되게 처리할 수 있는 기법
        return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 한 줄에 몇개 들어갈 지
          childAspectRatio: 1.0, //가로세로 비율 (정사각형)
          mainAxisSpacing: 1.0, //가로세로 간격 여백
          crossAxisSpacing: 1.0, ), //가로세로 간격 여백
            itemCount: items.length, //아이템 총 갯수
            itemBuilder: (context,index){
              return _buildListItem(context,items[index]);
            });
      },

    );
  }

  Widget _buildListItem(BuildContext context, document) { //어떤 타입 들어올 지 모를 땐 타입 없이 document로 받기
    return Hero(
      tag: document['photoUrl'],
      child: Material(
        child: InkWell( //클릭했을 때 물ㅇ방울 처럼 퍼지게 하는 위젯
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DetailPostPage(document);
            }));
          },
          child: Image.network(
            document['photoUrl'],
            fit: BoxFit.cover,
          ),

        ),
      ),
    );
  }
}
