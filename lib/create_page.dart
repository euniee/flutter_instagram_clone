import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CreatePage extends StatefulWidget {
  final FirebaseUser user;
  CreatePage(this.user);
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  final textEditingController = new TextEditingController(); //얘가 소멸될 때 반드시 dispose 호출 해줘야함

  File _image;


  @override
  void dispose() { //메모리 해제해주는 오버라이드 함수
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: _getImage,
          backgroundColor: Colors.black,
          child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: _getImage),
      ),
    );
  }


 Widget _buildAppbar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          onPressed: (){
            final firebaseStorageRef = FirebaseStorage.instance
                .ref()
                .child('post')
                .child('${DateTime.now().millisecondsSinceEpoch}.png');

            final task = firebaseStorageRef.putFile(
              _image,StorageMetadata(contentType: 'image/png')
            );

            task.onComplete.then((value){
              var downloadUrl = value.ref.getDownloadURL();
              downloadUrl.then((url){ //Storage에 이미지를 저장하고 그 url을 얻어와서 DB에 저장해야함
                var doc = Firestore.instance.collection('post').document();
                doc.setData({
                  'id' : doc.documentID,
                  'photoUrl' : url.toString(),
                  'contents' : textEditingController.text,
                  'email' : widget.user.email,
                  'displayName' : widget.user.displayName,
                  'userPhotoUrl' : widget.user.photoUrl
                }).then((onValue){
                  Navigator.pop(context); //이전 화면으로 돌아감
                }); //맵 제이슨형태로 넣으면 됨
              });

            });

          },

        ),
      ],
    );
 }

 Widget _buildBody() {
    return Column(
      children: <Widget>[
        _image == null ? Text('No Image') : Image.file(_image),
        TextField(
          decoration: InputDecoration(hintText: '내용을 입력하세요'),
          controller: textEditingController, //TextField 값 얻어올 때 이 변수 사용
        ),
      ],
    );
 }

  Future _getImage() async{ //사람이 클릭할 때 까지 기다림
    //이미지 가져오려면 이미지 피커 사용
    File image = await ImagePicker.pickImage(source: ImageSource.gallery); //리턴을 Future <file> 콜백으로 받음 : 미래에 file이 될 리턴

    setState(() {
    _image = image;
    });

  }
}
