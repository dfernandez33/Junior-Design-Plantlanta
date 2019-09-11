"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
//ONLY INITIALIZE APP HERE!!!
admin.initializeApp();
const firestore = admin.firestore();
const removeUserFromEvents = require("./Event_Interactions/removeUserFromEvent");
const signupForEvent = require("./Event_Interactions/signupForEvent");
const getAllEvents = require("./Event_Interactions/getAllEvents");
const registerUser = require("./User_Interactions/registerUser");
/*========================================================================
EVENT INTERACTIONS CLOUD FUNCTIONS
==========================================================================*/
exports.removeUserFromEvents = functions.https.onCall((data, context) => {
    return removeUserFromEvents.handler(data, context, firestore);
});
exports.signupForEvent = functions.https.onCall((data, context) => {
    return signupForEvent.handler(data, context, firestore);
});
exports.getAllEvents = functions.https.onCall((data, context) => {
    return getAllEvents.handler(data, context, firestore);
});
/*========================================================================
REGISTER USER
==========================================================================*/
exports.registerUser = functions.https.onCall((data, context) => {
    return registerUser.handler(data, context, firestore);
});
//# sourceMappingURL=index.js.map