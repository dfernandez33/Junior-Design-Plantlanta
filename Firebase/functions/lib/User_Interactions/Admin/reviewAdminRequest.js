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
        const request = await firestore.collection("AdminRequests").doc(requestId).get();
        if (request.data() == undefined) {
            res.status(400).send({
                status: 400,
                message: "No request under that ID"
            });
        }
        const requestInfo = request.data();
        const mssg = {
            to: requestInfo.email,
            from: "plantlanta.bitbybit@gmail.com",
            templateId: approved ? "d-089265f85a214588a45f0d31088b991c" : "d-d0cc1b31435f4fc482409c9a115f2199",
            dynamic_template_data: approved ? {
                registration_link: "http://localhost:4200/register/" + requestId,
                name: requestInfo.name,
                organizationName: requestInfo.organizationName
            }
                : {
                    name: requestInfo.name,
                    organizationName: requestInfo.organizationName
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
        if (!approved) {
            await firestore.collection("AdminRequests").doc(requestId).delete();
        }
        res.status(200).send({
            status: 200,
            message: "Review submitted successfully"
        });
    });
};
//# sourceMappingURL=reviewAdminRequest.js.map