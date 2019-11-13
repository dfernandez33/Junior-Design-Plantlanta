"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
exports.handler = async function (data, context, firestore) {
    const itemId = data.itemId;
    const itemRef = await firestore.collection("Items").doc(itemId);
    try {
        await itemRef.delete();
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "Item deleted successfully."
        };
    }
    catch (e) {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: e.message
        };
    }
};
//# sourceMappingURL=deleteItem.js.map