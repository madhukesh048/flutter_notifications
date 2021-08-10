const functions = require('firebase-functions');
const admin = require('firebase-admin');
 
admin.initializeApp(functions.config().functions);
 
var newData;
 
exports.myTrigger = functions.firestore.document('messages/{id}').onCreate(async (snapshot, context) => {
 
    if (snapshot.empty) {
        console.log('No Devices');
        return;
    }
 
    newData = snapshot.data();
    console.log(newData.data);

    const deviceIdTokens = await admin
    .firestore()
    .collection('deviceTokens')
    .get();

    var tokens = [];

    for (var token of deviceIdTokens.docs) {
    tokens.push(token.data().token)
    }
 
    var payload = {
        notification: {
            title: 'Push Title',
            body: 'Push Body',
            sound: 'default',
        },
        data: {
           click_action: "FLUTTER_NOTIFICATION_CLICK",message:newData.data,
        },
    };
 
    try {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log('Notification sent successfully');
    } catch (err) {
        console.log(err);
    }
});