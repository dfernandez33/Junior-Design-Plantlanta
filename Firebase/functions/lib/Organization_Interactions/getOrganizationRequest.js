"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (data, context, firestore) {
    const requestId = data.requestId;
    const request = firestore.collection("OrganizationRequests").doc(requestId).get();
    return request.then(doc => {
        return doc.data();
    });
};
//# sourceMappingURL=getOrganizationRequest.js.map