import 'package:flutter/material.dart';

class ShowDetails extends StatelessWidget {
  const ShowDetails({
    super.key,
    required this.title,
    required this.userDetail,
  });

  final String userDetail, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title\t',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              )),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFF5F5F5),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('\t$userDetail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ))),
          ),
        ],
      ),
    );
  }
}
