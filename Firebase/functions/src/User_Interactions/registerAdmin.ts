import * as functions from "firebase-functions"
import {ResponseCode} from "../Enums/responseCode";
import { adminRegistrationInterface } from "../Interface/User_Interactions_Interface/adminRegistrationInterface";

const admin_key = "supersecretkey";

export const handler = function(data: adminRegistrationInterface, context:functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    if (data.admin_key !== admin_key) {
        return {
            status: ResponseCode.FAILURE,
            message: "Admin key provided was incorrect"
        };
    }

    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid
    } else {
        return {
            status: ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }
    const userRef = firestore.collection("Admins").doc(UUID);

    return userRef.set({
        name: data.name,
    }).then(() => {
        return {
            status: ResponseCode.SUCCESS,
            message: "Admin record created successfully"
        }
    }).catch((error) => {
        return {
            status: ResponseCode.FAILURE,
            message: error
        }
    })
}