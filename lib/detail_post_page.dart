import 'package:flutter/material.dart';
class DetailPostPage extends StatelessWidget {
  final dynamic document; //var와 final은 같이 쓸 수 없어서 dynamic으로 정의
  DetailPostPage(this.document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('둘러보기') ,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(document['userPhotoUrl']),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(document['email'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(document['displayName']),
                                ],
                              ),
                          ),


                        ],
                      )
                  ),

                  Hero(
                    tag: document['photoUrl'], //태그를 똑같이 맞춰주면 동작
                    child: Image.network(document['photoUrl'],
                        fit: BoxFit.fitWidth),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(document['contents']),
                  ),


                ],
              ),


            ],
          ),
        )
    );
  }
}
