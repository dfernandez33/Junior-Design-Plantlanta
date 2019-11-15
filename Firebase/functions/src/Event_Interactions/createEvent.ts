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
        const adminData = await firestore.collection("Admins").doc(UUID).get();
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
            reward: data.reward,
            createdBy: UUID,
            createdOn: new Date(),
            participants: [],
            confirmed_participants: [],
            organizationId: adminData.data().organizationId,
            passed: false
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