import { Change } from "../../node_modules/firebase-functions";
import { DocumentSnapshot } from "../../node_modules/firebase-functions/lib/providers/firestore";
import { ResponseCode } from "../Enums/responseCode";

export const hanlder = function(snapshot: Change<DocumentSnapshot>) {
    if (snapshot.after.data().codes.length == 0) {
        return snapshot.after.ref.delete();
    } else {
        return {
            status: ResponseCode.SUCCESS,
            message: "This event still has codes available."
        }
    }
}