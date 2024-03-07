import 'package:firebase_messaging/firebase_messaging.dart';

// class FirebaseNotification {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//     final FCMToken = await _firebaseMessaging.getToken();

//     print("Token : $FCMToken");

//     if (FCMToken != null) {
//       UserPreferences.setFcmToken(FCMToken.toString());
//     }

//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }
// }

// class FirebaseNotification {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   String? _fcmToken;

//   String? get fcmToken => _fcmToken;

//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//     _fcmToken = await _firebaseMessaging.getToken();

//     print("Token : $_fcmToken");

//     // if (_fcmToken != null) {
//     //   UserPreferences.setFcmToken(_fcmToken.toString());
//     // }

//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }
// }

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    _fcmToken = await _firebaseMessaging.getToken();

    print("Token: $_fcmToken");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message data: ${message.data}");

      // Handle notification with image
      if (message.data.containsKey('image')) {
        // Handle image notification
        String imageUrl = message.data['image'];
        // You can now use imageUrl to load and display the image
        print("Image URL: $imageUrl");
      }

      // Handle other data as needed
      // ...

      // Show notification in the system tray
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        print("Notification: ${notification.title}, ${notification.body}");
      }
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  // Add this method to handle background messages
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print("Handling background message: ${message.data}");

    // Handle background notification with image
    if (message.data.containsKey('image')) {
      String imageUrl = message.data['image'];
      // You can now use imageUrl to load and display the image
      print("Image URL: $imageUrl");
    }

    // Show notification in the system tray
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      print("Notification: ${notification.title}, ${notification.body}");
    }
  }
}
