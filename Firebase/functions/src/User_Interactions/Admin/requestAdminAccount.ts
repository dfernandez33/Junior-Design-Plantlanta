import * as functions from "firebase-functions"
import { AdminRequestInterface } from "../../Interface/User_Interactions_Interface/adminRequestInterface";

const SENDGRID_API_KEY = functions.config().sendgrid.key;

const cors = require('cors')({
    origin: true,
});

const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(SENDGRID_API_KEY);

export const handler = async function(req: any, res: any , firestore: FirebaseFirestore.Firestore) {
    return cors(req, res, async () => {
        const data: AdminRequestInterface = req.body;
        if (data == null) {
            res.status(400).send({
                status: 400,
                message:'No user data recieved'
            });
        }
    
        let requestId:string = "";
        try {
            const requestRef = await firestore.collection("AdminRequests").add({
                name: data.name,
                email: data.email,
                message: data.message
            });
            requestId = requestRef.id;
        } catch (e) {
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
        }
    
        try {
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