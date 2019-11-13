import * as functions from 'firebase-functions';
import { ResponseCode } from '../Enums/responseCode';

export const handler = async function(data: any, context: functions.EventContext, firestore: FirebaseFirestore.Firestore) {
    const itemId = data.itemId;

    const itemRef = await firestore.collection("Items").doc(itemId);
    try {
        await itemRef.delete();
        return {
            status: ResponseCode.SUCCESS,
            message: "Item deleted successfully."
        }
    } catch (e) {
        return {
            status: ResponseCode.FAILURE,
            message: e.message
        }
    }
}