import * as functions from "firebase-functions"
import {ResponseCode} from "../Enums/responseCode";

export const handler = function(data: userRegistrationInterface, context:functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid
    } else {
        return {
            status: ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }
    const userRef = firestore.collection("Users").doc(UUID);

    return userRef.set({
        name: data.name,
        dob: new Date(Date.parse(data.dob)),
        phone: data.phone,
        picture: data.profile_picture,
        address: data.address,
        preferences: data.preferences,
        events: [],
        friends: [],
        confirmed_events: [],
        points: 0,
        transaction_history: []
    }).then(() => {
        return {
            status: ResponseCode.SUCCESS,
            message: "User record created successfully"
        }
    }).catch((error) => {
        return {
            status: ResponseCode.FAILURE,
            message: error
        }
    })
}