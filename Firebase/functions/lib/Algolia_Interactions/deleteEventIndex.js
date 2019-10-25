"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = function (snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Events");
    const objectId = snapshot.id;
    return index.deleteObject(objectId);
};
//# sourceMappingURL=deleteEventIndex.js.map