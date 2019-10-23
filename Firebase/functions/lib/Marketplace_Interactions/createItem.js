"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
exports.handler = async function (data, context, firestore) {
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
            brand: data.brand,
            description: data.description,
            price: data.price,
            quantity: data.quantity,
            image: data.image,
            codes: data.codes,
            ItemId: newItemRef.id,
            createdOn: new Date(),
        });
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "Item created successfully"
        };
    }
    catch (e) {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: e.message
        };
    }
};
//# sourceMappingURL=createItem.js.map