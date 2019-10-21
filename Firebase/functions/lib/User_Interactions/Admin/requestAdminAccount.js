"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const cors = require('cors')({
    origin: true,
});
const SENDGRID_API_KEY = functions.config().sendgrid.key;
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(SENDGRID_API_KEY);
exports.handler = async function (req, res, firestore) {
    return cors(req, res, async () => {
        const data = req.body; //get request data
        if (data == null) { //check for valid data
            res.status(400).send({
                status: 400,
                message: 'No user data recieved'
            });
        }
        // get reference to organization which user is trying to register as.
        const orgQuerySnapshot = await firestore.collection("Organizations").where("name", "==", data.organizationName).get();
        console.log(orgQuerySnapshot);
        if (orgQuerySnapshot.empty) {
            res.status(400).send({
                status: 400,
                message: "No organization with the given name was found"
            });
        }
        let organization;
        orgQuerySnapshot.forEach(org => {
            organization = org;
        });
        let requestId = "";
        try { //create new entry in admin request table with new request info
            const requestRef = await firestore.collection("AdminRequests").add({
                name: data.name,
                email: data.email,
                message: data.message,
                organizationName: data.organizationName,
                organizationId: organization.id
            });
            requestId = requestRef.id;
        }
        catch (e) {
            res.status(400).send({
                status: 400,
                message: e.message
            });
        }
        const mssg = {
            to: organization.data().contactEmail,
            from: "plantlanta.bitbybit@gmail.com",
            templateId: "d-364acda28c46429c8eff0976191b843a",
            dynamic_template_data: {
                request_link: "http://localhost:4200/verify_admin/" + requestId,
                name: data.name,
                organizationName: data.organizationName
            }
        };
        try { // send email to organization contact
            await sgMail.send(mssg);
            const message = 'Request sent';
            res.status(200).send({
                status: 200,
                message: message
            });
        }
        catch (e) {
            await firestore.collection("AdminRequests").doc(requestId).delete();
            res.status(400).send({
                status: 400,
                message: e.message
            });
        }
    });
};
//# sourceMappingURL=requestAdminAccount.js.map