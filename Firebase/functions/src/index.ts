import * as functions from 'firebase-functions';
import admin = require("firebase-admin");
//ONLY INITIALIZE APP HERE!!!
admin.initializeApp();
const firestore = admin.firestore();

import removeUserFromEvents = require("./Event_Interactions/removeUserFromEvent");
import signupForEvent = require("./Event_Interactions/signupForEvent");
import confirmEvent = require("./Event_Interactions/confirmEvent");
import getAllEvents = require("./Event_Interactions/getAllEvents");
import registerUser = require("./User_Interactions/registerUser");
import registerAdmin = require("./User_Interactions/registerAdmin");
import isUserAdmin = require("./User_Interactions/isUserAdmin");
import getEvent = require("./Event_Interactions/getEvent")
/*========================================================================
EVENT INTERACTIONS CLOUD FUNCTIONS
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
})

/*========================================================================
User Interactoins USER/Admin
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