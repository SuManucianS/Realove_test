import 'package:flutter/material.dart';
import 'package:real_love/screen/support/layout/info.dart';

class SupportSrceen extends StatefulWidget{
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<SupportSrceen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        child: Image.asset('assets/images/cafe-coffee.jpg'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => InfoSupportScreen(type: 1,))
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        child: Image.asset('assets/images/milktea.jpg'),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => InfoSupportScreen(type: 2,))
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        child: Image.asset('assets/images/launuong.jpg'),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => InfoSupportScreen(type: 3,))
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        child: Image.asset('assets/images/movie.jpg'),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => InfoSupportScreen(type: 4,))
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        child: Image.asset('assets/images/park.jpg'),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => InfoSupportScreen(type: 5,))
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}