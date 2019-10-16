import * as functions from "firebase-functions"
import { AdminRequestInterface } from "../../Interface/User_Interactions_Interface/adminRequestInterface";

const cors = require('cors')({
    origin: true,
});

const SENDGRID_API_KEY = functions.config().sendgrid.key;
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(SENDGRID_API_KEY);

export const handler = async function(req: any, res: any , firestore: FirebaseFirestore.Firestore) {
    return cors(req, res, async () => {
        const data: AdminRequestInterface = req.body; //get request data

        if (data == null) { //check for valid data
            res.status(400).send({
                status: 400,
                message:'No user data recieved'
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
        let organization: FirebaseFirestore.QueryDocumentSnapshot;
        orgQuerySnapshot.forEach(org => {
            organization = org;
        });
    
        let requestId:string = "";
        try { //create new entry in admin request table with new request info
            const requestRef = await firestore.collection("AdminRequests").add({
                name: data.name,
                email: data.email,
                message: data.message,
                organizationName: data.organizationName,
                organizationId: organization.id
            });
            requestId = requestRef.id;
        } catch (e) {
            res.status(400).send({
                status: 400,
                message: e.message
            });
        }

        const mssg = { //buid message for email
            to: organization.data().contactEmail,
            from: "plantlanta.bitbybit@gmail.com",
            templateId: "d-364acda28c46429c8eff0976191b843a",
            dynamic_template_data: {
                request_link: "http://localhost:4200/verify_admin/" + requestId,
                name: data.name,
                organizationName: data.organizationName
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