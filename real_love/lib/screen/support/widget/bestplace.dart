
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_love/model/place/infopalce.dart';

class BestPlace extends StatelessWidget {
  final InfoPlace infoPlace;
  Widget itemremmove;

  BestPlace ({ this.infoPlace, this.itemremmove });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 01,),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.asset('${infoPlace.path}'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10, ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              child: _buildInfo(
                size: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo({ double size }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size,
          width: size,
          child: ClipOval(
              child:  Image.asset(
                  '${infoPlace.path}',
                fit: BoxFit.cover,
              )
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${infoPlace.name}', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),),
              SizedBox(height: 5,),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/relove_place.svg', height: 15, width: 15,),
                  SizedBox(width: 5,),
                  Text(
                      '${infoPlace.palace}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ).copyWith(color: Colors.black87)),
                ],

              ),
            ],
          ),
        )
      ],
    );
  }
  
}