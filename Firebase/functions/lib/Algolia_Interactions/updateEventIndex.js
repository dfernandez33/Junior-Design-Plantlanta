"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Events");
    const data = snapshot.after.data();
    const objectId = snapshot.after.id;
    return index.saveObject({
        name: data.name,
        location: data.location,
        objectID: objectId
    });
};
//# sourceMappingURL=updateEventIndex.js.map