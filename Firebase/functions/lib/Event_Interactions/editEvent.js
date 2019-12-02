"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
exports.handler = function (data, context, firestore) {
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
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "Event updated successfully"
        };
    }).catch((e) => {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: e.message
        };
    });
};
//# sourceMappingURL=editEvent.js.map