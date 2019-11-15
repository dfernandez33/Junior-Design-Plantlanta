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

    var batch = firestore.batch();

    const eventRef = firestore.collection("Events").doc(eventID);
    const event = await eventRef.get();
    const eventData = event.data();
    const userRef = firestore.collection("Users").doc(UUID);
    const transactionRef = firestore.collection("Transactions").doc();

    if (eventData.confirmed_participants.includes(UUID)) {
        return {
            status: ResponseCode.FAILURE,
            message: "You have already confirmed your attendance to this event"
        }
    }

    batch.create(transactionRef, 
        {
            amount: eventData.reward,
            timestamp: new Date(),
            description: "Participated in " + eventData.name,
            uuid: UUID
        }
    );

    batch.update(eventRef, 
        {
            confirmed_participants: admin.firestore.FieldValue.arrayUnion(UUID),
        }
    );

    batch.update(userRef,
        {
            confirmed_events: admin.firestore.FieldValue.arrayUnion(eventID),
            points: admin.firestore.FieldValue.increment(eventData.reward),
            transaction_history: admin.firestore.FieldValue.arrayUnion(transactionRef.id),
        }
    );

    return batch.commit().then(() => {
        return {
            status: ResponseCode.SUCCESS,
            message: "Success updating user and event info"
        };
    }).catch(() => {
        return {
            status: ResponseCode.FAILURE,
            message: "Error updating user and event info"
        };
    });
}