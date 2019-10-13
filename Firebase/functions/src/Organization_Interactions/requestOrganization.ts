import * as functions from "firebase-functions"
import { OrganizationRequest } from "../Interface/Organization_Interactions/organizationRequest";

const cors = require('cors')({
    origin: true,
});

const SENDGRID_API_KEY = functions.config().sendgrid.key;
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(SENDGRID_API_KEY);

export const handler = async function(req: any, res: any, firestore: FirebaseFirestore.Firestore) {
    return cors(req, res, async () => {
        const requestData: OrganizationRequest = req.body;

        if (requestData == null) { //check for valid data
            res.status(400).send({
                status: 400,
                message:'No organization data recieved'
            });
        }

        let requestId = "";
        try {   //create organization request entry in database
            const requestRef = await firestore.collection("OrganizationRequests").add({
                name: requestData.name,
                mission: requestData.mission,
                contactEmail: requestData.contactEmail,
                doc501C3URL: requestData.doc501C3URL
            });
            requestId = requestRef.id;
        } catch (e) {
            res.status(400).send({
                status: 400,
                message: e.message
            });
        }

        const mssg = { //buid message for email
            to: "plantlanta.bitbybit@gmail.com",
            from: "plantlanta.bitbybit@gmail.com",
            templateId: "d-96e02c4550b045c4be5568cf841cef52",
            dynamic_template_data: {
                request_url: "http://localhost:4200/verify_organization/" + requestId,
                name: requestData.name,
            }
        }
    
        try { // send email to organization contact
            await sgMail.send(mssg);
            const message = 'Request sent';
            res.status(200).send({
                status: 200,
                message: message
            });
        } catch (e) {
            await firestore.collection("AdminRequests").doc(requestId).delete();
            res.status(400).send({
                status: 400,
                message: e.message
            });
        }
    });
}
