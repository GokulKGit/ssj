// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:ssj/api/get/topbanner.dart';
// import 'package:http/http.dart' as http;

// // Your TopBanner and Datum classes here

// class BannerCarousel extends StatelessWidget {
//   final List<Datum> data;

//   BannerCarousel({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 200, // Set the desired height
//         autoPlay: true, // Enable auto-play
//         autoPlayInterval: Duration(seconds: 3), // Set auto-play interval
//       ),
//       items: data.map((item) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               margin: EdgeInsets.symmetric(horizontal: 5.0),
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(item.bannerimageUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   item.bannertitle,
//                   style: TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text('Banner Carousel Example'),
//       ),
//       body: FutureBuilder<TopBanner>(
//         // Replace this with your API call to get the JSON data
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done &&
//               snapshot.hasData) {
//             return BannerCarousel(data: snapshot.data!.data);
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     ),
//   ));
// }

// Future<TopBanner> fetchData() async {
//   final response = await http.get(
//       Uri.parse("https://www.srishanmugajewellery.com/admin/public/api/showbanner"));
//   if (response.statusCode == 200) {
//     return topBannerFromJson(response.body);
//   } else {
//     throw Exception('Failed to load data');
//   }
// }

// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:ssj/api/get/topbanner.dart';

// // Your TopBanner and Datum classes here

// class BannerSlideView extends StatelessWidget {
//   final List<Datum> data;

//   BannerSlideView({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         return Container(
//           height: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             image: DecorationImage(
//               image: NetworkImage(data[index].bannerimageUrl),
//               fit: BoxFit.cover,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ssj/api/get/topbanner.dart';
import 'package:http/http.dart' as http;

class BannerSlideView extends StatefulWidget {
  final List<Datum> data;
  final Duration autoScrollDuration;
  final PageController pageController;

  BannerSlideView({
    required this.sec,
    required this.data,
    this.autoScrollDuration = const Duration(seconds: 3),
  }) : pageController = PageController();

  int sec;

  @override
  _BannerSlideViewState createState() => _BannerSlideViewState();
}

class _BannerSlideViewState extends State<BannerSlideView> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    timer = Timer.periodic(widget.autoScrollDuration, (Timer timer) {
      if (widget.pageController.page == widget.data.length - 1) {
        widget.pageController.jumpToPage(0);
      } else {
        widget.pageController.nextPage(
          duration: Duration(milliseconds: widget.sec),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(widget.data[index].bannerimageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<TopBanner> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://www.srishanmugajewellery.com/admin/public/api/showbanner'));
  if (response.statusCode == 200) {
    return topBannerFromJson(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<TopBanner> fetchDataHotBanner() async {
  final response = await http.get(Uri.parse(
      'https://www.srishanmugajewellery.com/admin/public/api/showhotbanner'));
  if (response.statusCode == 200) {
    return topBannerFromJson(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
