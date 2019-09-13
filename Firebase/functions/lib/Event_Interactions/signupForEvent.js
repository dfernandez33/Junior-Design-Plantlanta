"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
const responseCode_1 = require("../Enums/responseCode");
exports.handler = function (data, context, firestore) {
    const eventID = data.EventID;
    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid;
    }
    else {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }
    const eventRef = firestore.doc("Events/" + eventID);
    const userRef = firestore.doc("Users/" + UUID);
    let eventUpdatePromise = eventRef.update({
        participants: admin.firestore.FieldValue.arrayUnion(UUID)
    });
    let userUpdatePromise = userRef.update({
        events: admin.firestore.FieldValue.arrayUnion(eventID)
    });
    return Promise.all([eventUpdatePromise, userUpdatePromise]).then(() => {
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "User was signed up successfully"
        };
    }).catch(() => {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: "Error updating user and event info"
        };
    });
};
//# sourceMappingURL=signupForEvent.js.map