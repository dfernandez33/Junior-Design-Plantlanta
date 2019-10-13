import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import {ResponseCode} from "../Enums/responseCode";

export const handler = async function(data: purchaseRequest, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    const itemID = data.ItemID;
    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid
    } else {
        return {
            status: ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }

    var batch = firestore.batch();

    const itemRef = firestore.collection("Items").doc(itemID);
    const item = await itemRef.get();
    const itemData = item.data();
    const userRef = firestore.collection("Users").doc(UUID);
    const transactionRef = firestore.collection("Transactions").doc();

    const user = await userRef.get();
    const userPoints = user.data().points;

    if(userPoints >= itemData.price) {

        batch.create(transactionRef, 
            {
                amount: -itemData.price,
                timestamp: new Date(),
                description: "Purchased " + itemData.name,
                uuid: UUID
            }
        );
    
        batch.update(itemRef, 
            {
                quantity: admin.firestore.FieldValue.increment(-1),
            }
        );
    
        batch.update(userRef,
            {
                points: admin.firestore.FieldValue.increment(-itemData.price),
            }
        );
        
   } else {
        
    return {
        status: ResponseCode.FAILURE,
        message: "User does not have enough points for selected item."
    };

   }

    return batch.commit().then(() => {
        return {
            status: ResponseCode.SUCCESS,
            message: "Success updating user and event info"
        };
    }).catch(() => {
        return {
            status: ResponseCode.FAILURE,
            message: "Error updating user and event info"
        };
    });
}