import * as functions from 'firebase-functions';

export const handler = function(data: any, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    let eventsRef = firestore.collection("Events");
    return eventsRef.get().then((snapshot) => {
        const events = snapshot.docs.map(doc => doc.data());
        return {
            events: events
        }
    });
}