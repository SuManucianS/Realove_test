
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_love/model/callingtoUser/calling.dart';
import 'package:real_love/model/usermatch/usermatch.dart';
import 'package:real_love/response/FirebaseApi/firebaseApi.dart';
import 'package:real_love/screen/layout/dashboard.dart';
import 'package:real_love/screen/video_call/layout/callpage.dart';
import 'package:real_love/style/colors.dart';
import 'package:real_love/utils/sizeConfig.dart';

import 'button.dart';
import 'dialScreen.dart';

class BodyForDial extends StatefulWidget {
  final String id;

  const BodyForDial({Key key, this.id}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<BodyForDial> {
  String url;
  String name;
  String state;
  bool state2;
  String uidofUser;
  ClientRole _role = ClientRole.Broadcaster;
  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    setState(() {
      uidofUser = uid;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.id)
          .get().then((value) {
        UserMatch user = UserMatch.fromJson(value.data());
        setState(() {
          name = user.nickname;
          url = user.photoUrl;
        });
      });
    }
    );}
        /*
      FirebaseFirestore.instance
          .collection('info_call')
          .doc(uid)
          .get().then((value) {
        Calling call = Calling.fromJson(value.data());
        setState(() {
          state = call.statecall;
        });
      });
    });*/

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
              if (element.id == uidofUser) {
                if(element.statecall != null) {
                  print('recall ${element.idtoUserReCall},${element.statecall}');
                  state = element.statecall;
                  state2 = false;
                } else {
                  state2 = true;
                }
              }
            });
          }
          return state2 ? DashboardHomePage() : body_ofDial(name: name, url: url, id: uidofUser, context: context, state: state, role: _role, uidofUser: widget.id );
        }
      },
    );

  }
}

Widget body_ofDial({String name, String url, String id, BuildContext context, String state, ClientRole role, String uidofUser}) {
  return state != 'accept' ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "${name ?? 'Loading...'}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
              Text(
                "Calling…",
                style: TextStyle(color: Colors.white60),
              ),
              VerticalSpacing(),
              DialUserPic(image: "assets/images/calling_face.png", url: url,),
              Spacer(),
              VerticalSpacing(),
              RoundedButton(
                iconSrc: "assets/icons/relove_call_iend.svg",
                press: () {
                  updatecalling(idofFriend: uidofUser);
                  Navigator.pop(context);
                },
                color: Colors.red,
                iconColor: Colors.white,
              )
            ],
          ),
        ),
      ):
      CallPage(channelName: id, role: role,);
}

void updatecalling({String idofFriend}) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User user = auth.currentUser;
  final uid = user.uid;
  FirebaseFirestore.instance.collection('info_call').doc(uid).update({
    'call_to': null,
    'statecall' : null
  });
  FirebaseFirestore.instance.collection('info_call').doc(idofFriend).update({
    're_call': null,
    'statecall' : null
  });
}