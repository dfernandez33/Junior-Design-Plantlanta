"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Items");
    const objectId = snapshot.id;
    return index.deleteObject({
        objectID: objectId
    });
};
//# sourceMappingURL=deleteItemIndex.js.map