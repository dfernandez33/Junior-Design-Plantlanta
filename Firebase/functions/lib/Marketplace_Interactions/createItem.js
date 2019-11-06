"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
exports.handler = async function (data, context, firestore) {
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