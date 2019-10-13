"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../../Enums/responseCode");
exports.handler = async function (data, context, firestore) {
    let UUID;
    if (context.auth !== undefined) {
        UUID = context.auth.uid;
    }
    else {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: "No UUID received from context."
        };
    }
    const requestRef = await firestore.collection("AdminRequests").doc(data.requestId);
    const request = await requestRef.get();
    const userRef = firestore.collection("Admins").doc(UUID);
    try {
        await userRef.set({
            name: data.name,
            organizationId: request.data().organizationId
        });
        await requestRef.delete();
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "Admin record created successfully"
        };
    }
    catch (e) {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: e.message
        };
    }
};
//# sourceMappingURL=registerAdmin.js.map