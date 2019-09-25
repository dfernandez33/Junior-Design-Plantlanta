"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
const admin = require("firebase-admin");
exports.handler = async function (user, firestore) {
    const UUID = user.uid;
    const userData = await firestore.collection("Admins").doc(UUID).get();
    if (!userData.exists) { //user was not an admin
        const userRecord = await firestore.collection("Users").doc(UUID);
        try {
            await userRecord.delete();
            const eventsRef = await firestore.collection("Events").listDocuments();
            eventsRef.forEach(async (eventDoc) => {
                await eventDoc.update({
                    participants: admin.firestore.FieldValue.arrayRemove(UUID),
                    confirmed_participants: admin.firestore.FieldValue.arrayRemove(UUID)
                });
            });
            return {
                status: responseCode_1.ResponseCode.SUCCESS,
                message: "User deleted successfully"
            };
        }
        catch (e) {
            return {
                status: responseCode_1.ResponseCode.FAILURE,
                message: e.message
            };
        }
    }
    else { //for admins only the record has to be deleted
        const userRecord = await firestore.collection("Users").doc(UUID);
        try {
            await userRecord.delete();
            return {
                status: responseCode_1.ResponseCode.SUCCESS,
                message: "User deleted successfully"
            };
        }
        catch (e) {
            return {
                status: responseCode_1.ResponseCode.FAILURE,
                message: e.message
            };
        }
    }
};
//# sourceMappingURL=deleteUser.js.map