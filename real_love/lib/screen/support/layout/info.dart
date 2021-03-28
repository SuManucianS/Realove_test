import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:real_love/model/place/infopalce.dart';
import 'package:real_love/screen/support/widget/bestplace.dart';

class InfoSupportScreen extends StatefulWidget{

  InfoSupportScreen ({Key key, this.type}) : super (key: key);
  final int type;

  @override
  _InfoSupportState createState() => _InfoSupportState();
}

class _InfoSupportState extends State<InfoSupportScreen>{
  List<InfoPlace> _listpalceinfo = new List();
  CarouselController _carouselController = new CarouselController();
  bool isLoading = true;
  bool _isChecking = true;
  int _current = 0;
  Map<String, dynamic> formData = {
    'page' : 0,
    'size' : 5,
  };


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _refresh();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 25, right: 25,),
        child: _buildInfo()
      ),
    );
  }

  Widget _buildTypeInfo(int type) {
    switch (type) {
      case 1 :
        return _buildInfo();
        break;
      case 2 :
        return _buildInfo();
        break;
      case 3 :
        return _buildInfo();
        break;
      case 4 :
        return _buildInfo();
        break;
      case 5 :
        return _buildInfo();
        break;
    }
  }

  Widget _buildInfo() {
    return Container(
        child: _listpalceinfo.length == 0
            ? Align(
                child: isLoading
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                        backgroundColor: Colors.white,
                      )
                    : SizedBox(),
              alignment: Alignment.center,
            )
          : Column(
          children: [
            Expanded(
              child: _buildSliderVoucher(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.blueAccent,
                          ),
                          child: Text('Thông tin', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.orange.withOpacity(0.8),
                          ),
                          alignment: Alignment.center,
                          child: Text('Thoát', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            _indicatorItems(),
          ],
        ),
    );
  }

  Widget _buildInfoMildTea() {
    return Text('milk tea');
  }

  Widget _buildInfoHotpot() {
    return Text('hot pot');
  }

  Widget _buildInfoMovie() {
    return Text('movie');
  }

  Widget _buildInfoTourist() {
    return Text('tourist');
  }

  void _refresh() {
    isLoading = true;
    switch (widget.type) {
      case 1 :
        return _buildListCafe();
        break;
      case 2 :
        return _buildListMildTea();
        break;
      case 3 :
        return _buildListHotpot();
        break;
      case 4 :
        return _buildListMovie();
        break;
      case 5 :
        return _buildListTourist();
        break;
    }
  }

  Widget _buildSliderVoucher() {
    return CarouselSlider(
        items: List.generate(
          _listpalceinfo.length,
          (index) {
            return BestPlace(
              infoPlace: _listpalceinfo[index],
            );
          },
        ),
        options: CarouselOptions(
          reverse: false,
          viewportFraction: 0.9,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
          aspectRatio: 1,
        ),
      carouselController: _carouselController,
    );
  }

  Widget _indicatorItems() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            _listpalceinfo.length,
          (index) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 2.0,),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.blueAccent : Color(0xFFCBCBCB),
                ),
              );
          },
        ),
      ),
    );
  }

  void _buildListCafe() {
    setState(() {
      _listpalceinfo.add(InfoPlace(1, 'Highland', '399 Trương Định, Hà Nội', 5, 'assets/images/highland.jpg'));
      _listpalceinfo.add(InfoPlace(2, 'The coffee house', '38A Kim Đồng, Hà Nội', 5, 'assets/images/thecoffehouse.jpg'));
      _listpalceinfo.add(InfoPlace(3, 'Cộng Coffee', '203 Nguyễn Huy Tưởng, Hà Nội', 5, 'assets/images/congcafe.jpg'));
      _listpalceinfo.add(InfoPlace(4, 'Gemini', '48 Kim Đồng, Hà Nội', 5, 'assets/images/gemini.jpg'));
      _listpalceinfo.add(InfoPlace(5, 'Serein Cafe & Lounge', '16 Tập thể Ga Long Biên, Hà Nội', 5, 'assets/images/coffe-longbien.jpg'));
      isLoading = false;
    });
  }

  void _buildListMildTea() {
    setState(() {
      _listpalceinfo.add(InfoPlace(1, 'Gong cha', 'D2 Giảng võ, Hà Nội', 5, 'assets/images/milktea_gongcha.jpg'));
      _listpalceinfo.add(InfoPlace(2, 'Dingtea', '54 Duy Tân, Hà Nội', 5, 'assets/images/milktea_dingtea.jpg'));
      _listpalceinfo.add(InfoPlace(3, 'Royal Tea', '64 Trần Đăng Ninh, Hà Nội', 5, 'assets/images/milktea_royaltea.jpg'));
      _listpalceinfo.add(InfoPlace(4, 'Tiger Suger', '44 Cầu Giấy, Hà Nội', 5, 'assets/images/milktea_tigersuger.png'));
      _listpalceinfo.add(InfoPlace(5, 'Tocotoco', '54 Cầu Giấy, Hà Nội', 5, 'assets/images/milktea_tocotco.jpg'));
      isLoading = false;
    });

  }

  void _buildListHotpot() {
    setState(() {
      _listpalceinfo.add(InfoPlace(1, 'Lẩu Phan', 'Khách sạn Kim Liên, Hà Nội', 5, 'assets/images/hotpot_Phan.jpg'));
      _listpalceinfo.add(InfoPlace(2, 'Poseidon', 'Hồ Gươm Plazar, Hà Nội', 5, 'assets/images/hotpot_Posedon.jpg'));
      _listpalceinfo.add(InfoPlace(3, 'Yakimono ', '36 Nguyên Hồng, Hà Nội', 5, 'assets/images/hotpot_yakimono.jpg'));
      _listpalceinfo.add(InfoPlace(4, 'Dzung Chef', '47 Nguyễn Tuân, Hà Nội', 5, 'assets/images/hotpot_chefDzung.jpg'));
      _listpalceinfo.add(InfoPlace(5, 'Xả Hận', '311 Nguyễn Khang, Hà Nội', 5, 'assets/images/hotpot_xahan.jpg'));
      isLoading = false;
    });

  }

  void _buildListMovie() {
    setState(() {
      _listpalceinfo.add(InfoPlace(1, 'Rạp chiếu phimCGV', 'Hà Nội', 5, 'assets/images/ciname_cgv.jpg'));
      _listpalceinfo.add(InfoPlace(2, 'Rạp chiếu phim quốc gia', 'Hà Nội', 5, 'assets/images/ciname_nation.jpg'));
      _listpalceinfo.add(InfoPlace(3, 'Rạp chiếu phim tháng 8', 'Hà Nội', 5, 'assets/images/ciname_rapthang8.png'));
      _listpalceinfo.add(InfoPlace(4, 'Rạp chiếu phim BHD', 'Hà Nội', 5, 'assets/images/ciname_bhd.jpg'));
      isLoading = false;
    });

  }

  void _buildListTourist() {
    setState(() {
      _listpalceinfo.add(InfoPlace(1, 'Hồ Gươm', 'Hoàn Kiếm ,Hà Nội', 5, 'assets/images/tour_hoguom.png'));
      _listpalceinfo.add(InfoPlace(2, 'Hồ Tây', 'Tây Hồ, Hà Nội', 5, 'assets/images/tour_Hotay.jpg'));
      _listpalceinfo.add(InfoPlace(3, 'Bãi đá sông Hồng', 'Bắc Từ Liêm, Hà Nội', 5, 'assets/images/tour_baidasonghong.jpg'));
      _listpalceinfo.add(InfoPlace(4, 'Làng cổ Đường Lâm', 'Sơn Tây, Hà Nội', 5, 'assets/images/tour_langcoduonglam.jpg'));
      _listpalceinfo.add(InfoPlace(5, 'Ba Vì', 'Ba Vì, Hà Nội', 5, 'assets/images/tour_bavi.jpg'));
      isLoading = false;
    });

  }
}