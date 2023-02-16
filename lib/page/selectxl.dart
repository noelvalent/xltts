import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:xltts/page/tts.dart';
import 'package:xltts/widget/returnfloating.dart';
import 'package:xltts/widget/text.dart';

final List<AssetImage> imgList = [
  const AssetImage('assets/us.png'),
  // const AssetImage('assets/jp.png'),
  const AssetImage('assets/kr.png'),
];

List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: [
                  Image(image: item, fit: BoxFit.cover, width: 1000.0),
                ],
              )),
        ))
    .toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class SelectXL extends StatefulWidget {
  const SelectXL({super.key, required this.orgLang});
  final int orgLang;

  @override
  State<StatefulWidget> createState() {
    return _SelectXL();
  }
}

class _SelectXL extends State<SelectXL> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.red],
        )),
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints.tightFor(width: 500.0, height: null),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                createHeadline('Changing Language'),
                const Padding(padding: EdgeInsets.all(20.0)),
                Stack(
                  children: [
                    Column(
                      children: [
                        CarouselSlider(
                          items: imageSliders,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            onPageChanged: onPageChange,
                            autoPlay: false,
                          ),
                          carouselController: _controller,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(imageSliders, (index, url) {
                            return Container(
                              width: 10.0,
                              height: 10.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Colors.blueAccent
                                    : Colors.grey,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    // const Positioned.fill(
                    //     child: Align(
                    //         alignment: Alignment.center,
                    //         child: Text(
                    //           'Coming Soon',
                    //           style: TextStyle(
                    //               fontSize: 48.0,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.red,
                    //               backgroundColor: Colors.grey),
                    //         ))),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3, minimumSize: const Size(300.0, 90.0)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => TTSPage(
                                  orgLang: widget.orgLang,
                                  // xlLang: _currentIndex
                                ))));
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: getReturnFloating(context),
    );
  }
}
