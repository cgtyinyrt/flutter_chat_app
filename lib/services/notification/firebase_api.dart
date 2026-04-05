import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // Create an instance of the Firebase Messaging service
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notifications
  Future<void> initNotifications() async {
    // Request permission from the user (will prompt user to allow notifications)
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Fetch the FCM token for this device and save it to Firestore for later use in sending notifications
    final fcmToken = await _firebaseMessaging.getToken();

    // Print the token (normally you would send this to your server)
    print('FCM Token: $fcmToken');
  }

  // Function to handle received messages

  // Function to initialize foreground and background settings
}
