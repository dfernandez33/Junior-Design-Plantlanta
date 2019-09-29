import * as functions from 'firebase-functions';

import { Event } from "../Interface/Event_Interactions_Interface/event";
import { ResponseCode } from '../Enums/responseCode';

export const handler = async function(data: Event, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore){
    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid
    } else {
        return {
            status: ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }
    try {
        console.log(data);
        const eventsRef = await firestore.collection("Events");
        const newEventRef = await eventsRef.add({});
        await newEventRef.set({
            name: data.name,
            location: data.location,
            date: new Date(data.date),
            startTime: data.startTime,
            endTime: data.endTime,
            description: data.description,
            eventId: newEventRef.id,
            createdBy: UUID,
            createdOn: new Date(),
            participants: [],
            confirmed_participants: []
        });
        return {
            status: ResponseCode.SUCCESS,
            message: "Event created successfully"
        }
    } catch(e) {
        return {
            status: ResponseCode.FAILURE,
            message: e.message
        }
    }

}