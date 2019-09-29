import * as functions from "firebase-functions"

const SENDGRID_API_KEY = functions.config().sendgrid.key;
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(SENDGRID_API_KEY);

export const handler = async function(data: any, context: functions.https.CallableContext, firestore: FirebaseFirestore.Firestore) {
    const requestId = data.requestId;
    const approved = data.approved;
    const request = await firestore.collection("AdminRequests").doc(requestId).get();
    if (request.data() == undefined) {
        return {
            status: 400,
            message: "No request under that ID"
        };
    }

    const requestInfo = request.data();
    console.log(requestInfo);
    const mssg = {
        to: requestInfo.email,
        from: "plantlanta.bitbybit@gmail.com",
        templateId: approved ? "d-089265f85a214588a45f0d31088b991c" : "d-d0cc1b31435f4fc482409c9a115f2199",
        dynamic_template_data: approved ? {
            registration_link: "http://localhost:4200/register/" + requestId,
            name: requestInfo.name
        }
        : {
            name: requestInfo.name
        }
    }
    try {
        await sgMail.send(mssg);
    } catch(e) {
        return {
            status: 400,
            message: e.message
        }
    }

    if (!approved) {
       await firestore.collection("AdminRequests").doc(requestId).delete();
    }

    return {
        status: 200,
        message: "Email sent."
    }
}
