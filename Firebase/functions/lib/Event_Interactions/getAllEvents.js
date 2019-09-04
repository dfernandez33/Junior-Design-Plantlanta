"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (data, context, firestore) {
    let eventsRef = firestore.collection("Events");
    return eventsRef.get().then((snapshot) => {
        const events = snapshot.docs.map(doc => doc.data());
        return {
            events: events
        };
    });
};
//# sourceMappingURL=getAllEvents.js.map