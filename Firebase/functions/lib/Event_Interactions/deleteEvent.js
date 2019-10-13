"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
const responseCode_1 = require("../Enums/responseCode");
exports.handler = function (data, context, firestore) {
    const eventId = context.params.eventId;
    // remove event from users who had signed up for it
    return firestore.collection("Users").where("events", "array-contains", eventId).get().then(users => {
        const batch = firestore.batch();
        users.forEach(user => {
            batch.update(user.ref, { events: admin.firestore.FieldValue.arrayRemove(eventId) });
        });
        return batch.commit().then(() => {
            console.log("event deleted successfullly");
            return {
                status: responseCode_1.ResponseCode.SUCCESS,
                message: "Successfully deleted"
            };
        }).catch(() => {
            console.log("there was an issue deleting the event.");
            return {
                status: responseCode_1.ResponseCode.FAILURE,
                message: "there was an error deleting"
            };
        });
    }).catch(() => {
        console.log("there was a problem getting the users during event deletion");
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: "there was a problem getting users for deletion"
        };
    });
};
//# sourceMappingURL=deleteEvent.js.map