export const handler = function(snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Events");

    const objectId = snapshot.id;

    return index.deleteObject(objectId);
}