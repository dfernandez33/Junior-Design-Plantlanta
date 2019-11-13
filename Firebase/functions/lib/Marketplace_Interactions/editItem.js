"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
const responseCode_1 = require("../Enums/responseCode");
exports.handler = function (data, context, firestore) {
    const itemId = data.itemId;
    const itemRef = firestore.collection("Items").doc(itemId);
    return itemRef.update({
        name: data.name,
        brand: data.brand,
        description: data.description,
        price: data.price,
        quantity: data.quantity,
        image: data.image,
        codes: admin.firestore.FieldValue.arrayUnion.apply(null, data.codes),
    }).then(() => {
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "Item updated successfully"
        };
    }).catch((e) => {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: e.message
        };
    });
};
//# sourceMappingURL=editItem.js.map