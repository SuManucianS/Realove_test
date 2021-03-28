import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_love/style/common-style.dart';

abstract class LoadingProcessBuilder {
  static void showProgressDialog(BuildContext context, String title) {
    bool isShowingDialog;
    try {
      isShowingDialog = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(

            child: AlertDialog(
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                width: MediaQuery.of(context).size.width - 10,
                child: SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: CommonStyle.colorGray,
                      ),
                      SizedBox(height: 20),
                      Text(
                        title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ).then((_) {
        isShowingDialog = false;
      });
    } catch (e) {
      isShowingDialog = false;
    }
  }
}