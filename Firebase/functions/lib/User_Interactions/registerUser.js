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
    const userRef = firestore.collection("Users").doc(UUID);
    return userRef.set({
        name: data.name,
        dob: new Date(Date.parse(data.dob)),
        phone: data.phone,
        picture: data.profile_picture,
        address: data.address,
        preferences: data.preferences,
        events: [],
        friends: [],
        confirmed_events: [],
        points: 0,
        transaction_history: []
    }).then(() => {
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "User record created successfully"
        };
    }).catch((error) => {
        return {
            status: responseCode_1.ResponseCode.FAILURE,
            message: error
        };
    });
};
//# sourceMappingURL=registerUser.js.map