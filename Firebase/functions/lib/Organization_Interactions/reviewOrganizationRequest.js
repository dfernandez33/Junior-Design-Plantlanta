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
        const requestId = req.body.requestId;
        const approved = req.body.approved;
        const request = await firestore.collection("OrganizationRequests").doc(requestId).get();
        if (request.data() == undefined) {
            res.status(400).send({
                status: 400,
                message: "No request under that ID"
            });
        }
        const requestInfo = request.data();
        const decision = approved ? "approved" : "denied";
        const message = approved ? "You can now create admin accounts under your organization's name in order to create events." : "";
        const mssg = {
            to: requestInfo.contactEmail,
            from: "plantlanta.bitbybit@gmail.com",
            templateId: "d-3d07db11bea149019af091711e1cdd05",
            dynamic_template_data: {
                name: requestInfo.name,
                decision: decision,
                message: message
            }
        };
        try {
            await sgMail.send(mssg);
        }
        catch (e) {
            res.status(400).send({
                status: 400,
                message: e.message
            });
        }
        if (approved) {
            await firestore.collection("Organizations").add({
                name: requestInfo.name,
                mission: requestInfo.mission,
                contactEmail: requestInfo.contactEmail,
                doc501C3URL: requestInfo.doc501C3URL
            });
        }
        await firestore.collection("OrganizationRequests").doc(requestId).delete();
        res.status(200).send({
            status: 200,
            message: "Review submitted successfully"
        });
    });
};
//# sourceMappingURL=reviewOrganizationRequest.js.map