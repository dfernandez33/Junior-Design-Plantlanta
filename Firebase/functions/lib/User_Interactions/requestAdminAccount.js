"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const SENDGRID_API_KEY = functions.config().sendgrid.key;
const cors = require('cors')({
    origin: true,
});
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(SENDGRID_API_KEY);
exports.handler = async function (req, res, firestore) {
    return cors(req, res, async () => {
        const data = req.body;
        if (data == null) {
            res.status(400).send({
                status: 400,
                message: 'No user data recieved'
            });
        }
        let requestId = "";
        try {
            const requestRef = await firestore.collection("AdminRequests").add({
                name: data.name,
                email: data.email,
                message: data.message
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
            to: "plantlanta.bitbybit@gmail.com",
            from: "plantlanta.bitbybit@gmail.com",
            templateId: "d-364acda28c46429c8eff0976191b843a",
            dynamic_template_data: {
                request_link: "http://localhost:4200/verify_admin/" + requestId,
                name: data.name
            }
        };
        try {
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