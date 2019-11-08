"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
exports.handler = async function (data, context, firestore) {
    const eventID = data.EventID;
    const itemRef = firestore.collection("Items").doc(eventID);
    try {
        const doc = await itemRef.get();
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: doc.data()
        };
    }
    catch (e) {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: "Error getting event info"
        };
    }
};
//# sourceMappingURL=getItem.js.map