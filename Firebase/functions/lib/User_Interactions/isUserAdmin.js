"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
exports.handler = function (data, context, firestore) {
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
    const adminRef = firestore.collection("Admins");
    let isAdmin = false;
    return adminRef.listDocuments().then((documents) => {
        documents.forEach((document) => {
            if (document.id == UUID) {
                isAdmin = true;
            }
        });
        if (isAdmin) {
            return {
                status: responseCode_1.ResponseCode.SUCCESS,
                message: "The user is an admin"
            };
        }
        else {
            return {
                status: responseCode_1.ResponseCode.FAILURE,
                message: "This user is not an admin"
            };
        }
    });
};
//# sourceMappingURL=isUserAdmin.js.map