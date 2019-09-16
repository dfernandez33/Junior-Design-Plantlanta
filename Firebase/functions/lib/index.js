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
const registerAdmin = require("./User_Interactions/Admin/registerAdmin");
const isUserAdmin = require("./User_Interactions/Admin/isUserAdmin");
const requestAdminAccount = require("./User_Interactions/Admin/requestAdminAccount");
const getAdminRequest = require("./User_Interactions/Admin/getAdminRequest");
const reviewAdminRequest = require("./User_Interactions/Admin/reviewAdminRequest");
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
User Interactoins USER/Admin
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
//# sourceMappingURL=index.js.map