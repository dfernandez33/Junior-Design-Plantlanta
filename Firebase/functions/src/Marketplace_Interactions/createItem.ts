import * as functions from 'firebase-functions';

import { Item } from "../Interface/Marketplace_Interactions_Interface/item";
import { ResponseCode } from '../Enums/responseCode';

export const handler = async function(data: Item, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore){
    // let UUID;
    // if (context.auth !== undefined) {
    //     UUID = context.auth.uid
    // } else {
    //     return {
    //         status: ResponseCode.FAILURE,
    //         message: "No UUID received from context."
    //     };
    // }
    try {
        const itemRef = await firestore.collection("Items");
        const newItemRef = await itemRef.add({});
        await newItemRef.set({
            name: data.name,
            description: data.description,
            price: data.price,
            quantity: data.quantity,
            image: data.image,
            code: data.code,
            ItemId: newItemRef.id,
            createdOn: new Date(),
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