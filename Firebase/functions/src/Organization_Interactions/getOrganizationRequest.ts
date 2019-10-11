import * as functions from "firebase-functions"

export const handler = function(data: any, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    const requestId = data.requestId;
    const request = firestore.collection("OrganizationRequests").doc(requestId).get();
    return request.then(doc => {
        return doc.data();
    });
}