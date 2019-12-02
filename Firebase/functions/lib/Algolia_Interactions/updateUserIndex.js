"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Users");
    const data = snapshot.after.data();
    const objectId = snapshot.after.id;
    return index.saveObject({
        name: data.name,
        phone: data.phone,
        picture: data.picture,
        objectID: objectId
    });
};
//# sourceMappingURL=updateUserIndex.js.map