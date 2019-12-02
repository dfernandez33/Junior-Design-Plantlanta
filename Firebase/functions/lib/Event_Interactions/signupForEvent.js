"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
const responseCode_1 = require("../Enums/responseCode");
exports.handler = async function (data, context, firestore) {
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
    var batch = firestore.batch();
    const eventRef = firestore.collection("Events").doc(eventID);
    const event = await eventRef.get();
    const eventData = event.data();
    const userRef = firestore.collection("Users").doc(UUID);
    const activityRef = firestore.collection("Activities").doc();
    const user = await userRef.get();
    const userData = user.data();
    batch.create(activityRef, {
        activitytype: "Signed up for Event",
        timestamp: new Date(),
        description: "Signed up for " + eventData.name,
        username: userData.name,
        uuid: UUID
    });
    batch.update(eventRef, {
        participants: admin.firestore.FieldValue.arrayUnion(UUID),
    });
    batch.update(userRef, {
        events: admin.firestore.FieldValue.arrayUnion(eventID),
    });
    return batch.commit().then(() => {
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "Success updating user and event info"
        };
    }).catch(() => {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: "Error updating user and event info"
        };
    });
};
//# sourceMappingURL=signupForEvent.js.map