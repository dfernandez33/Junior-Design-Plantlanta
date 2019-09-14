import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import {ResponseCode} from "../Enums/responseCode";

export const handler = function(data: signupRequest, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
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
        confirmed_participants: admin.firestore.FieldValue.arrayUnion(UUID)
    });
    let userUpdatePromise = userRef.update({
        confirmed_events: admin.firestore.FieldValue.arrayUnion(eventID)
    });

    return Promise.all([eventUpdatePromise, userUpdatePromise]).then(() => {
        return {
            status: ResponseCode.SUCCESS,
            message: "User was signed up successfully"
        };
    }).catch(() => {
        return {
            status: ResponseCode.FAILURE,
            message: "Error updating user and event info"
        };
    });
}