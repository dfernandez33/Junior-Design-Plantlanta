import * as functions from 'firebase-functions';
import * as admin from "firebase-admin"
import { ResponseCode } from '../Enums/responseCode';

export const handler = function(data: any, context: functions.EventContext, firestore: FirebaseFirestore.Firestore) {
    const eventId = context.params.eventId;
    // remove event from users who had signed up for it
    return firestore.collection("Users").where("events", "array-contains", eventId).get().then(users => {
        const batch = firestore.batch();
        users.forEach(user => {
            batch.update(user.ref, {events: admin.firestore.FieldValue.arrayRemove(eventId)});
        })
        return batch.commit().then(() => {
            console.log("event deleted successfullly");
            return {
                status: ResponseCode.SUCCESS,
                message: "Successfully deleted"
            }
        }).catch(() => {
            console.log("there was an issue deleting the event.");
            return {
                status: ResponseCode.FAILURE,
                message: "there was an error deleting"
            }
        });
    }).catch(() => {
        console.log("there was a problem getting the users during event deletion");
        return {
            status: ResponseCode.FAILURE,
            message: "there was a problem getting users for deletion"
        }
    });
}