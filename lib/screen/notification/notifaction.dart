import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssj/api/get/notification_response.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';
import 'package:ssj/util/constant.dart';

class NotificationHistory extends StatefulWidget {
  const NotificationHistory({super.key});

  @override
  State<NotificationHistory> createState() => _NotificationHistoryState();
}

class _NotificationHistoryState extends State<NotificationHistory> {
  late Future<NotificationResponse> futureData;

  String UserId = UserPreferences.getUserId();

  Future<NotificationResponse> fetchNofification() async {
    final response =
        await http.get(Uri.parse('${BASEURL}/public/api/notifications'));

    if (response.statusCode == 200) {
      return NotificationResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchNofification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
            child: Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: Center(
        child: FutureBuilder<NotificationResponse>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("asset/notification.png"),
                      Text(
                        "Notifications",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              final notification = snapshot.data;
              return ListView.builder(
                itemCount: notification!.notifications.length,
                itemBuilder: (context, index) {
                  final reversedIndex =
                      notification.notifications.length - 1 - index;

                  final showNotification =
                      notification.notifications[reversedIndex];
                  return Card(
                    color: Colors.white,
                    elevation: 3,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            showNotification.title.toString(),
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff832729)),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        showNotification.body.toString(),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No Scheme added yet',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
