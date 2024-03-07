import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ssj/api/get/topbanner.dart';

// Your TopBanner and Datum classes here

class BannerSlideView extends StatelessWidget {
  final List<Datum> data;

  BannerSlideView({required this.data});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(data[index].bannerimageUrl),
              fit: BoxFit.cover,
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
