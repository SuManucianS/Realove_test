import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:real_love/provider/ProviderAvatar.dart';
import 'package:real_love/provider/interesProvider.dart';
import 'package:real_love/provider/userinfor/userinfo.dart';
import 'package:real_love/router/router.dart';
import 'package:real_love/screen/login/login.dart';

import 'model/image/image-avatar.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InteresProvider()),
        ChangeNotifierProvider(create: (context) => AvatarImageProvider()),
        ChangeNotifierProvider(create: (context) => AvatarImage()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider())
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: MaterialApp(
        title: 'Real Love',
        routes: RoutesConstant.routes,
        home: new LoginScreen(),
      ),
    );
  }
}
