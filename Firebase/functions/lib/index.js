"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
//ONLY INITIALIZE APP HERE!!!
admin.initializeApp();
const firestore = admin.firestore();
// User/Admin Interactions
const registerUser = require("./User_Interactions/registerUser");
const registerAdmin = require("./User_Interactions/Admin/registerAdmin");
const isUserAdmin = require("./User_Interactions/Admin/isUserAdmin");
const requestAdminAccount = require("./User_Interactions/Admin/requestAdminAccount");
const getAdminRequest = require("./User_Interactions/Admin/getAdminRequest");
const reviewAdminRequest = require("./User_Interactions/Admin/reviewAdminRequest");
const deleteUser = require("./User_Interactions/deleteUser");
// Event interactions
const createEvent = require("./Event_Interactions/createEvent");
const signupForEvent = require("./Event_Interactions/signupForEvent");
const removeUserFromEvents = require("./Event_Interactions/removeUserFromEvent");
const getAllEvents = require("./Event_Interactions/getAllEvents");
const getEvent = require("./Event_Interactions/getEvent");
const confirmEvent = require("./Event_Interactions/confirmEvent");
const editEvent = require("./Event_Interactions/editEvent");
const deleteEvent = require("./Event_Interactions/deleteEvent");
/*========================================================================
Event Interactions
==========================================================================*/
exports.removeUserFromEvents = functions.https.onCall((data, context) => {
    return removeUserFromEvents.handler(data, context, firestore);
});
exports.signupForEvent = functions.https.onCall((data, context) => {
    return signupForEvent.handler(data, context, firestore);
});
exports.confirmEvent = functions.https.onCall((data, context) => {
    return confirmEvent.handler(data, context, firestore);
});
exports.getEvent = functions.https.onCall((data, context) => {
    return getEvent.handler(data, context, firestore);
});
exports.getAllEvents = functions.https.onCall((data, context) => {
    return getAllEvents.handler(data, context, firestore);
});
exports.createEvent = functions.https.onCall((data, context) => {
    return createEvent.handler(data, context, firestore);
});
exports.editEvent = functions.https.onCall((data, context) => {
    return editEvent.handler(data, context, firestore);
});
exports.deleteEvent = functions.firestore.document("Events/{eventId}").onDelete((data, context) => {
    return deleteEvent.handler(data, context, firestore);
});
/*========================================================================
User/Admin Interactions
==========================================================================*/
exports.registerUser = functions.https.onCall((data, context) => {
    return registerUser.handler(data, context, firestore);
});
exports.registerAdmin = functions.https.onCall((data, context) => {
    return registerAdmin.handler(data, context, firestore);
});
exports.isUserAdmin = functions.https.onCall((data, context) => {
    return isUserAdmin.handler(data, context, firestore);
});
exports.requestAdminAccount = functions.https.onRequest((req, res) => {
    return requestAdminAccount.handler(req, res, firestore);
});
exports.getAdminRequest = functions.https.onCall((data, context) => {
    return getAdminRequest.handler(data, context, firestore);
});
exports.reviewAdminRequest = functions.https.onCall((data, context) => {
    return reviewAdminRequest.handler(data, context, firestore);
});
exports.deleteUser = functions.auth.user().onDelete((user) => {
    return deleteUser.handler(user, firestore);
});
//# sourceMappingURL=index.js.map