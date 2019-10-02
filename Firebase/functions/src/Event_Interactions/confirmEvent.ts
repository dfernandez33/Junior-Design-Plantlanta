import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import {ResponseCode} from "../Enums/responseCode";

export const handler = async function(data: signupRequest, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
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
    const eventRef = firestore.collection("Events").doc(eventID);
    const event = await eventRef.get();
    const eventData = event.data();
    const userRef = firestore.collection("Users").doc(UUID);

    let eventUpdatePromise = eventRef.update({
        confirmed_participants: admin.firestore.FieldValue.arrayUnion(UUID),
        points: admin.firestore.FieldValue.increment(eventData.reward),
        transaction_history: admin.firestore.FieldValue.arrayUnion({amount: eventData.reward, date: new Date(), description: "Participated in: " + eventData.name})
    });
    let userUpdatePromise = userRef.update({
        confirmed_events: admin.firestore.FieldValue.arrayUnion(eventID)
    });

    return Promise.all([eventUpdatePromise, userUpdatePromise]).then(() => {
        return eventRef.get().then(doc => {
            return {
                status: ResponseCode.SUCCESS,
                message: "Success updating user and event info"
            };
        });
    }).catch(() => {
        return {
            status: ResponseCode.FAILURE,
            message: "Error updating user and event info"
        };
    });
}