import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:real_love/model/image-object.dart';
import 'package:real_love/model/image/image-avatar.dart';
import 'package:real_love/provider/ProviderAvatar.dart';
import 'package:real_love/style/common-style.dart';
import 'package:path/path.dart' as path;

class AvatarView extends StatefulWidget{
  final double size;
  final String url;
  AvatarView({this.size = 80, this.url});
  @override
  _AvatarViewState createState() => _AvatarViewState();

}

class _AvatarViewState extends State<AvatarView>{
  final img_pick = ImagePicker();
  File _fileimage;
  ImgObject _imgObject;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        _buildDialogPickImg(context);
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color:Theme.of(context).cardColor,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            ClipOval(
                child: Stack(
                  children: [
                    (widget.url == null && _imgObject == null) ? Image.asset('assets/images/user2.png', color: CommonStyle.colorGray,)
                    : ((_imgObject == null ) ?
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                                imageUrl: widget.url,
                                fit: BoxFit.cover,
                              ),
                    ) : Align(
                      alignment: Alignment.center,
                      child: Image.memory(_imgObject.data),
                    )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset('assets/icons/relove_takecamera.svg', color: CommonStyle.colorWhite, height: 20, width: 20,),
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }

  void _buildDialogPickImg(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildcontext){
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildItempickOption(
                text: 'Thư viện',
                context: context,
                onTap:(){
                  _image_source(ImageSource.gallery);
                }
              ),
              _buildItempickOption(
                text: 'Máy ảnh',
                context: context,
                onTap: (){
                  _image_source(ImageSource.camera);
                }
              )
            ],
          ),
        );
      }
    );
  }

  Widget _buildItempickOption({String text, Function onTap, BuildContext context}) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _image_source(ImageSource type) async{
    try{
      PickedFile avatarFile = await img_pick.getImage(source: type, preferredCameraDevice: CameraDevice.front);
      Uint8List byte = await avatarFile.readAsBytes();
      String pathimg = path.extension(avatarFile.path);
      setState(() {
        _imgObject = new ImgObject(data: byte, type: pathimg);
        _fileimage = File(avatarFile.path);
      });
      uploadImageToFirebase(context);
    }catch(e){
    }
  }
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = path.basename(_fileimage.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_fileimage);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    String url = imageUrl.toString();
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore.instance.collection('users_info').doc(_auth.currentUser?.uid).update({
      'url' : url
    });

  }
}