import * as functions from 'firebase-functions';
import admin = require("firebase-admin");
//ONLY INITIALIZE APP HERE!!!
admin.initializeApp();
const firestore = admin.firestore();

// User/Admin Interactions
import registerUser = require("./User_Interactions/registerUser");
import registerAdmin = require("./User_Interactions/Admin/registerAdmin");
import isUserAdmin = require("./User_Interactions/Admin/isUserAdmin");
import requestAdminAccount = require("./User_Interactions/Admin/requestAdminAccount");
import getAdminRequest = require("./User_Interactions/Admin/getAdminRequest");
import reviewAdminRequest = require("./User_Interactions/Admin/reviewAdminRequest")
import deleteUser = require("./User_Interactions/deleteUser");
// Event interactions
import createEvent = require("./Event_Interactions/createEvent");
import signupForEvent = require("./Event_Interactions/signupForEvent");
import removeUserFromEvents = require("./Event_Interactions/removeUserFromEvent");
import getAllEvents = require("./Event_Interactions/getAllEvents");

/*========================================================================
Event Interactions
==========================================================================*/
exports.removeUserFromEvents = functions.https.onCall((data, context) => {
   return removeUserFromEvents.handler(data, context, firestore);
});

exports.signupForEvent = functions.https.onCall((data, context) => {
    return signupForEvent.handler(data, context, firestore);
});

exports.getAllEvents = functions.https.onCall((data, context) => {
    return getAllEvents.handler(data, context, firestore);
})

exports.createEvent = functions.https.onCall((data, context) => {
    return createEvent.handler(data, context, firestore);
})

/*========================================================================
User/Admin Interactions
==========================================================================*/
exports.registerUser = functions.https.onCall((data, context) => {
    return registerUser.handler(data, context, firestore);
})

exports.registerAdmin = functions.https.onCall((data, context) => {
    return registerAdmin.handler(data, context, firestore);
})

exports.isUserAdmin = functions.https.onCall((data, context) => {
    return isUserAdmin.handler(data, context, firestore);
})

exports.requestAdminAccount = functions.https.onRequest((req, res) => {
    return requestAdminAccount.handler(req, res, firestore);
})

exports.getAdminRequest = functions.https.onCall((data, context) => {
    return getAdminRequest.handler(data, context, firestore);
})

exports.reviewAdminRequest = functions.https.onCall((data, context) => {
    return reviewAdminRequest.handler(data, context, firestore);
})

exports.deleteUser = functions.auth.user().onDelete((user) => {
    return deleteUser.handler(user, firestore);
})