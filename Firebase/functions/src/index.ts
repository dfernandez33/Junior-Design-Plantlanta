import * as functions from 'firebase-functions';
import admin = require("firebase-admin");
import algoliasearch = require('algoliasearch');

const algoliaClient = algoliasearch(functions.config().algolia.app, functions.config().algolia.key);

//ONLY INITIALIZE APP HERE!!!
admin.initializeApp({
    storageBucket: "junior-design-plantlanta.appspot.com"
});

const firestore = admin.firestore();

// User/Admin Interactions
import registerUser = require("./User_Interactions/registerUser");
import registerAdmin = require("./User_Interactions/Admin/registerAdmin");
import isUserAdmin = require("./User_Interactions/Admin/isUserAdmin");
import requestAdminAccount = require("./User_Interactions/Admin/requestAdminAccount");
import getAdminRequest = require("./User_Interactions/Admin/getAdminRequest");
import reviewAdminRequest = require("./User_Interactions/Admin/reviewAdminRequest")
import deleteUser = require("./User_Interactions/deleteUser");

// Event Interactions
import createEvent = require("./Event_Interactions/createEvent");
import signupForEvent = require("./Event_Interactions/signupForEvent");
import removeUserFromEvents = require("./Event_Interactions/removeUserFromEvent");
import getAllEvents = require("./Event_Interactions/getAllEvents");
import getEvent = require("./Event_Interactions/getEvent")
import confirmEvent = require("./Event_Interactions/confirmEvent");
import editEvent = require("./Event_Interactions/editEvent");
import deleteEvent = require("./Event_Interactions/deleteEvent");

// Organization Interactions
import requestOrganization = require("./Organization_Interactions/requestOrganization");
import getOrganizationRequest = require("./Organization_Interactions/getOrganizationRequest");
import reviewOrganizationRequest = require("./Organization_Interactions/reviewOrganizationRequest");

// Algolia Interactions (fucntions used to update Algolia index for full-text search)
import addEventToIndex = require("./Algolia_Interactions/addEventToIndex");
import updateEventIndex = require("./Algolia_Interactions/updateEventIndex");
import deleteEventIndex = require("./Algolia_Interactions/deleteEventIndex");
import addItemToIndex = require("./Algolia_Interactions/addItemToIndex");
import updateItemIndex = require("./Algolia_Interactions/updateItemIndex");
import deleteItemIndex = require("./Algolia_Interactions/deleteItemIndex");

/*========================================================================
Organization Interactions
==========================================================================*/
exports.requestOrganization = functions.https.onRequest((req, res) => {
    return requestOrganization.handler(req, res, firestore);
});

exports.getOrganizationRequest = functions.https.onCall((data, context) => {
    return getOrganizationRequest.handler(data, context, firestore);
});

exports.reviewOrganizationRequest = functions.https.onRequest((req, res) => {
    return reviewOrganizationRequest.handler(req, res, firestore);
})

// Marketplace Interactions
import purchaseItem = require("./Item_Interactions/purchaseItem");


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

exports.reviewAdminRequest = functions.https.onRequest((req, res) => {
    return reviewAdminRequest.handler(req, res, firestore);
});

exports.deleteUser = functions.auth.user().onDelete((user) => {
    return deleteUser.handler(user, firestore);
});

/*========================================================================
Marketplace Interactions
==========================================================================*/
exports.purchaseItem = functions.https.onCall((data, context) => {
    return purchaseItem.handler(data, context, firestore);
});

/*========================================================================
Algolia Interactions
==========================================================================*/
exports.addEventToIndex = functions.firestore.document("Events/{eventId}").onCreate((snapshot) => {
    return addEventToIndex.handler(snapshot, algoliaClient);
});

exports.updateEventIndex = functions.firestore.document("Events/{eventId}").onUpdate((snapshot) => {
    return updateEventIndex.handler(snapshot, algoliaClient);
});

exports.deleteEventIndex = functions.firestore.document("Events/{eventId}").onDelete((snapshot) => {
    return deleteEventIndex.handler(snapshot, algoliaClient);
});

exports.addItemToIndex = functions.firestore.document("Items/{itemdId}").onCreate((snapshot) => {
    return addItemToIndex.handler(snapshot, algoliaClient);
});

exports.updateItemIndex = functions.firestore.document("Items/{ItemId}").onUpdate((snapshot) => {
    return updateItemIndex.handler(snapshot, algoliaClient);
});

exports.deleteItemIndex = functions.firestore.document("Items/{ItemId}").onDelete((snapshot) => {
    return deleteItemIndex.handler(snapshot, algoliaClient);
});