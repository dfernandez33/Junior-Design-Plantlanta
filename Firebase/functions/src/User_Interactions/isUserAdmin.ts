import * as functions from "firebase-functions"
import {ResponseCode} from "../Enums/responseCode";

export const handler = function(data: any, context:functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    let UUID: string;
    if (context.auth !== undefined) {
        UUID = context.auth.uid
    } else {
        return {
            status: ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }
    const adminRef = firestore.collection("Admins");
    let isAdmin = false;
    return adminRef.listDocuments().then((documents) => {
        documents.forEach((document) => {
            if (document.id == UUID) {
                isAdmin = true;
            }
        });
        if (isAdmin) {
            return {
                status: ResponseCode.SUCCESS,
                message: "The user is an admin"
            }
        } else {
            return {
                status: ResponseCode.FAILURE,
                message: "This user is not an admin"
            }
        }
    })
}