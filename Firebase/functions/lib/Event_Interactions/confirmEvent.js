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
    const transactionRef = firestore.collection("Transactions").doc();
    batch.create(transactionRef, {
        amount: eventData.reward,
        timestamp: new Date(),
        description: "Participated in " + eventData.name,
        uuid: UUID
    });
    batch.update(eventRef, {
        confirmed_participants: admin.firestore.FieldValue.arrayUnion(UUID),
    });
    batch.update(userRef, {
        confirmed_events: admin.firestore.FieldValue.arrayUnion(eventID),
        points: admin.firestore.FieldValue.increment(eventData.reward),
        transaction_history: admin.firestore.FieldValue.arrayUnion(transactionRef.id),
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
//# sourceMappingURL=confirmEvent.js.map