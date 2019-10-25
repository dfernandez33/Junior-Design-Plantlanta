"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const responseCode_1 = require("../Enums/responseCode");
const SENDGRID_API_KEY = functions.config().sendgrid.key;
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(SENDGRID_API_KEY);
exports.handler = async function (data, context, firestore) {
    const itemID = data.ItemID;
    let UUID;
    let Email;
    if (context.auth !== undefined) {
        UUID = context.auth.uid;
        Email = context.auth.token.email;
    }
    else {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
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
    const userData = user.data();
    const code = itemData.codes.pop();
    const mssg = {
        to: Email,
        from: "plantlanta.bitbybit@gmail.com",
        templateId: "d-7dc8e8fded7f48d2b9a48883c8df2be0",
        dynamic_template_data: {
            itemName: itemData.name,
            name: userData.name,
            manufacturerName: itemData.brand,
            code: code
        }
    };
    if (userData.points >= itemData.price) {
        batch.create(transactionRef, {
            amount: -itemData.price,
            timestamp: new Date(),
            description: "Purchased " + itemData.name,
            uuid: UUID
        });
        batch.update(itemRef, {
            quantity: admin.firestore.FieldValue.increment(-1),
            codes: admin.firestore.FieldValue.arrayRemove(code)
        });
        batch.update(userRef, {
            points: admin.firestore.FieldValue.increment(-itemData.price),
        });
    }
    else {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: "User does not have enough points for selected item."
        };
    }
    try { // send email to organization contact
        await sgMail.send(mssg);
        return batch.commit().then(() => {
            return {
                status: responseCode_1.ResponseCode.SUCCESS,
                message: "Success updating item and user info."
            };
        }).catch(() => {
            return {
                status: responseCode_1.ResponseCode.FAILURE,
                message: "Error updating item and user info. "
            };
        });
    }
    catch (e) {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: e.message
        };
    }
};
//# sourceMappingURL=purchaseItem.js.map