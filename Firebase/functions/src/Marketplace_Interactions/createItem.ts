import * as functions from 'firebase-functions';

import { Item } from "../Interface/Marketplace_Interactions_Interface/item";
import { ResponseCode } from '../Enums/responseCode';

export const handler = async function(data: Item, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore){
    try {
        const itemRef = await firestore.collection("Items");
        const newItemRef = await itemRef.add({});
        await newItemRef.set({
            name: data.name,
            brand: data.brand,
            description: data.description,
            price: data.price,
            quantity: data.quantity,
            image: data.image,
            codes: data.codes,
        });
        return {
            status: ResponseCode.SUCCESS,
            message: "Item created successfully"
        }
    } catch(e) {
        return {
            status: ResponseCode.FAILURE,
            message: e.message
        }
    }

}