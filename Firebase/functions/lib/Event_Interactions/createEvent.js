"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
exports.handler = async function (data, context, firestore) {
    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid;
    }
    else {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
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
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "Event created successfully"
        };
    }
    catch (e) {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: e.message
        };
    }
};
//# sourceMappingURL=createEvent.js.map