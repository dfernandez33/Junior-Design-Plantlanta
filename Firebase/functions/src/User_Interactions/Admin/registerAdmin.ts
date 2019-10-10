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
    const requestRef = await firestore.collection("AdminRequests").doc(data.requestId);
    const request = await requestRef.get();
    const userRef = firestore.collection("Admins").doc(UUID);
    try {
        await userRef.set({
            name: data.name,
            organizationId: request.data().organizationId
        });
        await requestRef.delete();
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