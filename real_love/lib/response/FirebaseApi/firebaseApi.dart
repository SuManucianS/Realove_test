import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_love/model/callingtoUser/calling.dart';
import 'package:real_love/model/usermatch/usermatch.dart';
import 'package:real_love/utils/utils.dart';
import 'package:real_love/model/user/UserProfile/user-profile.dart';


class FirebaseApi {
  static Stream<List<UserMatch>> getUsers(int limit) =>
    FirebaseFirestore.instance
        .collection('users')
        .limit(limit)
        .snapshots()
        .transform(Utils.transformer(UserMatch.fromJson));

  static Future calling(String myId, String idUserofReCall) async {
    final calling = Calling(
      idUser: idUserofReCall,
      idtoUserReCall: null,
      id: myId,
      statecall: 'calling'
    );
    final calling2 = Calling(
      idUser: null,
      idtoUserReCall: myId,
      id: idUserofReCall,
      statecall: 'waiting'
    );
    final refUsers = FirebaseFirestore.instance.collection('info_call');
    await refUsers
        .doc(myId)
        .update(calling.toJson());
    await refUsers
        .doc(idUserofReCall)
        .update(calling2.toJson());
  }
  static Stream<List<Calling>> getstatecall() =>
      FirebaseFirestore.instance
          .collection('info_call')
          .snapshots()
          .transform(Utils.transformer(Calling.fromJson));
  static Stream<List<UserProfile>> getinfouser({int limit}) =>
      FirebaseFirestore.instance
          .collection('users_info').limit(limit)
          .snapshots()
          .transform(Utils.transformer(UserProfile.fromJson));
  static Future updateuserinfo({String hometown, String quoete, List<String> chipss, String uid}) async {
    final refUsers = FirebaseFirestore.instance.collection('users_info');
    await refUsers.doc(uid).update({'chips': chipss ?? [], 'hometown': hometown, 'quote': quoete});
  }
  static Stream<List<UserProfile>> getlistuser_match({int limit, String uid}) =>
      FirebaseFirestore.instance.collection('/list_user_match/${uid}/${uid}').limit(limit)
          .snapshots()
          .transform(Utils.transformer(UserProfile.fromJson));
}
