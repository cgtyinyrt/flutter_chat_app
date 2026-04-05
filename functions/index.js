const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNotificationOnMessage = functions.firestore
    .document("ChatRooms/{chatId}/Messages/{messageId}")
    .onCreate(async (snap, context) => {
        const message = snap.data();

        const receiverId = message.receiverId;

        const userDoc = await admin.firestore()
            .collection("Users")
            .doc(receiverId)
            .get();

        if (!userDoc.exists) return;

        const token = userDoc.data().fcmToken;

        if (!token) return;

        const payload = {
            notification: {
                title: message.senderEmail,
                body: message.message,
            },
            token: token,
        };

        return admin.messaging().send(payload);
    });