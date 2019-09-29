import { UserRecord } from "../../node_modules/firebase-functions/lib/providers/auth";
import { ResponseCode } from "../Enums/responseCode";
import * as admin from "firebase-admin";

export const handler = async function(user: UserRecord, firestore: FirebaseFirestore.Firestore) {
    const UUID = user.uid;
    const userData = await firestore.collection("Admins").doc(UUID).get();
    if (!userData.exists) { //user was not an admin
        const userRecord = await firestore.collection("Users").doc(UUID);
        try {
            await userRecord.delete();
            const eventsRef = await firestore.collection("Events").listDocuments();
            eventsRef.forEach(async (eventDoc) => {
                await eventDoc.update({
                    participants: admin.firestore.FieldValue.arrayRemove(UUID),
                    confirmed_participants: admin.firestore.FieldValue.arrayRemove(UUID)           
                });
            });
            return {
                status: ResponseCode.SUCCESS,
                message: "User deleted successfully"
            }
        } catch (e) {
            return {
                status: ResponseCode.FAILURE,
                message: e.message
            }
        }
    } else { //for admins only the record has to be deleted
        const userRecord = await firestore.collection("Users").doc(UUID);
        try {
            await userRecord.delete();
            return {
                status: ResponseCode.SUCCESS,
                message: "User deleted successfully"
            }
        } catch (e) {
            return {
                status: ResponseCode.FAILURE,
                message: e.message
            }
        }
    }
}