import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import {ResponseCode} from "../Enums/responseCode";

export const handler = function(data: removeUserFromEvent, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore)  {
    const eventID = data.EventID;
    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid
    } else {
        return {
            status: ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }
    const eventRef = firestore.doc("Events/" + eventID);
    const userRef = firestore.doc("Users/" + UUID);

    let eventUpdatePromise = eventRef.update({
        participants: admin.firestore.FieldValue.arrayRemove(UUID)
    });
    let userUpdatePromise = userRef.update({
        events: admin.firestore.FieldValue.arrayRemove(eventID)
    });

    return Promise.all([eventUpdatePromise, userUpdatePromise]).then(() => {
        return {
            status: ResponseCode.SUCCESS,
            message: "User was removed from event successfully"
        };
    }).catch(() => {
        return {
            status: ResponseCode.FAILURE,
            message: "Error updating user and event info"
        };
    });
}