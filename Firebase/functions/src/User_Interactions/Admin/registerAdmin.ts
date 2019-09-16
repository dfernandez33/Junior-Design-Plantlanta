import * as functions from "firebase-functions"
import {ResponseCode} from "../../Enums/responseCode";
import { adminRegistrationInterface } from "../../Interface/User_Interactions_Interface/adminRegistrationInterface";

export const handler = async function(data: adminRegistrationInterface, context:functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid
    } else {
        return {
            status: ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }
    await firestore.collection("AdminRequests").doc(data.requestId).delete();
    const userRef = firestore.collection("Admins").doc(UUID);
    try {
        await userRef.set({
            name: data.name,
        });
        return {
            status: ResponseCode.SUCCESS,
            message: "Admin record created successfully"
        }
    } catch (e) {
        return {
            status: ResponseCode.FAILURE,
            message: e.message
        }
    }
}