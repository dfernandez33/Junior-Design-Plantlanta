export const handler = function(snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Items");

    const objectId = snapshot.id;

    return index.deleteObject(objectId);
}