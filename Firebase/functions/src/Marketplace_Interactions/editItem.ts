import * as functions from 'firebase-functions';
import { ResponseCode } from '../Enums/responseCode';

export const handler = function(data: any, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    const itemId = data.itemId;
    const itemRef = firestore.collection("Items").doc(itemId);

    return itemRef.update({
        name: data.name,
        brand: data.brand,
        description: data.description,
        price: data.price,
        quantity: data.quantity,
        image: data.image,
        codes: data.codes,
    }).then(() => {
        return {
            status: ResponseCode.SUCCESS,
            message: "Item updated successfully"
        }
    }).catch((e) => {
        return {
            status: ResponseCode.FAILURE,
            message: e.message
        }
    });
}