"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Items");
    const data = snapshot.after.data();
    const objectId = snapshot.after.id;
    return index.saveObject({
        name: data.name,
        brand: data.brand,
        objectID: objectId
    });
};
//# sourceMappingURL=updateItemIndex.js.map