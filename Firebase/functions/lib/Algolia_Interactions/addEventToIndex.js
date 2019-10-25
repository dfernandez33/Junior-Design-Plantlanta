"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Events");
    const data = snapshot.data();
    const objectID = snapshot.id;
    return index.addObject({
        name: data.name,
        location: data.location,
        objectID: objectID
    });
};
//# sourceMappingURL=addEventToIndex.js.map