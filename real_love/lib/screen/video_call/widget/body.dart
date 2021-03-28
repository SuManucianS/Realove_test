

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_love/model/callingtoUser/calling.dart';
import 'package:real_love/model/usermatch/usermatch.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/screen/layout/dashboard.dart';
import 'package:real_love/screen/video_call/layout/callpage.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/utils/sizeConfig.dart';
import 'package:real_love/widget/loading.dart';

import 'button.dart';
class VideoComponent extends StatefulWidget {
  final String idOfChanel;
  const VideoComponent({Key key, this.idOfChanel}) : super(key: key);
  @override
  _VideoState createState() => _VideoState();
  
}
class _VideoState extends State<VideoComponent> {
  String name;
  String url;
  bool state = true;
  String uid_currentUser;
  ClientRole _role = ClientRole.Broadcaster;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Calling>>(
      stream: FirebaseApi.getstatecall(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            ),
          );
        } else {
          final calling = snapshot.data;
          if (calling.isEmpty) {
            return Center(child: Text('nodata'),);
          } else {
            calling.forEach((element) {
              if (element.id == uid_currentUser) {
                print('stattecall ${element.statecall}');
                if(element.statecall == null) {
                  state = true;
                } else {
                  state = false;
                }
              }
            });
          }
          return bodyrecall();
        }
      },
    );

  }

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    setState(() {
      uid_currentUser = uid;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.idOfChanel)
          .get().then((value) {
         UserMatch user = UserMatch.fromJson(value.data());
         setState(() {
           name = user.nickname;
           url = user.photoUrl;
         });
      });
    });
  }

  Future<void> onJoin({String idofChanel, ClientRole role}) async {
    // update input validation
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: idofChanel,
            role: _role,
          ),
        ),
      );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  void movecalling({String idoffriend}) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    FirebaseFirestore.instance.collection('info_call').doc(uid).update({
      're_call': null,
      'statecall' : null
    });
    FirebaseFirestore.instance.collection('info_call').doc(idoffriend).update({
      'call_to': null,
      'statecall' : null
    });
  }

  void incom({String uid1}) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    FirebaseFirestore.instance.collection('info_call').doc(uid).update({
      'statecall' : 'accept'
    });
    FirebaseFirestore.instance.collection('info_call').doc(uid1).update({
      'statecall' : 'accept'
    });
  }

  Widget bodyrecall() {
    return state ? DashboardHomePage() : Stack(
      fit: StackFit.expand,
      children: [
        url == null ? Positioned(child: Loading(),) :
        CachedNetworkImage(
          imageUrl: url,
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
        // Image
        // Black Layer
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${name ?? 'Loading.....'}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
                VerticalSpacing(of: 10),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      press: () {
                        incom(uid1: widget.idOfChanel);
                        onJoin(idofChanel: widget.idOfChanel, role: _role);

                      },
                      iconSrc: "assets/icons/relove_call_in.svg",
                    ),
                    RoundedButton(
                      press: () {
                        movecalling(idoffriend: widget.idOfChanel);
                      },
                      iconSrc: "assets/icons/relove_call_iend.svg",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
