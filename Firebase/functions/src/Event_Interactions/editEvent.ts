import * as functions from 'firebase-functions';
import { ResponseCode } from '../Enums/responseCode';

export const handler = function(data: any, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    const eventId = data.eventId;
    const eventRef = firestore.collection("Events").doc(eventId);

    return eventRef.update({
        name: data.name,
        location: data.location,
        date: new Date(data.date),
        startTime: data.startTime,
        endTime: data.endTime,
        description: data.description,
        reward: data.reward,
        type: data.type,
    }).then(() => {
        return {
            status: ResponseCode.SUCCESS,
            message: "Event updated successfully"
        }
    }).catch((e) => {
        return {
            status: ResponseCode.FAILURE,
            message: e.message
        }
    });
}