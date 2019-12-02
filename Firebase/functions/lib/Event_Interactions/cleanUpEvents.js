"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = async function (context, firestore) {
    const passedEvents = await firestore.collection("Events").where("passed", "==", "false").get();
    let batch = firestore.batch();
    passedEvents.forEach((event) => {
        const eventData = event.data();
        if (new Date(eventData.date._seconds * 1000) <= new Date()) {
            batch.update(event.ref, {
                passed: true
            });
        }
    });
    return batch.commit();
};
//# sourceMappingURL=cleanUpEvents.js.map