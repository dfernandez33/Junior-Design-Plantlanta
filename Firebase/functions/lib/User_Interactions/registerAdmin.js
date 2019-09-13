"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
const admin_key = "supersecretkey";
exports.handler = function (data, context, firestore) {
    if (data.admin_key !== admin_key) {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: "Admin key provided was incorrect"
        };
    }
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
    const userRef = firestore.collection("Admins").doc(UUID);
    return userRef.set({
        name: data.name,
    }).then(() => {
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "Admin record created successfully"
        };
    }).catch((error) => {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: error
        };
    });
};
//# sourceMappingURL=registerAdmin.js.map