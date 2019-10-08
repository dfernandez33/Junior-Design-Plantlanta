import * as functions from 'firebase-functions';
import { ResponseCode } from '../Enums/responseCode';

export const handler = function(data: any, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    const eventId = data.eventId;
    
}