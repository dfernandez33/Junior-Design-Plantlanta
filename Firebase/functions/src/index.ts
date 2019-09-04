import * as functions from 'firebase-functions';
import admin = require("firebase-admin");
admin.initializeApp();
const firestore = admin.firestore();

import removeUserFromEvents = require("./Event_Interactions/removeUserFromEvent");
import signupForEvent = require("./Event_Interactions/signupForEvent");
import getAllEvents = require("./Event_Interactions/getAllEvents");

exports.removeUserFromEvents = functions.https.onCall((data, context) => {
   return removeUserFromEvents.handler(data, context, firestore);
});

exports.signupForEvent = functions.https.onCall((data, context) => {
    return signupForEvent.handler(data, context, firestore);
});

exports.getAllEvents = functions.https.onCall((data, context) => {
    return getAllEvents.handler(data, context, firestore);
})