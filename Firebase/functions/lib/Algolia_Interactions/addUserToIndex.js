"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Users");
    const data = snapshot.data();
    const objectID = snapshot.id;
    return index.addObject({
        name: data.name,
        phone: data.phone,
        picture: data.picture,
        objectID: objectID
    });
};
//# sourceMappingURL=addUserToIndex.js.map