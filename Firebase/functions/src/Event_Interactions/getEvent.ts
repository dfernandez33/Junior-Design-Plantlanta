import * as functions from 'firebase-functions';
import {ResponseCode} from "../Enums/responseCode";

export const handler =  async function(data: signupRequest, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    const eventID = data.EventID;
    const eventRef = firestore.collection("Events").doc(eventID);

    try {
        const doc = await eventRef.get();
        return {
            status: ResponseCode.SUCCESS,
            message: doc.data()
        };
    }
    catch (e) {
        return {
            status: ResponseCode.FAILURE,
            message: "Error getting event info"
        };
    }
}
