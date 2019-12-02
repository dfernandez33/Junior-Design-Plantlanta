export const handler = function(snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Users");

    const objectId = snapshot.id;

    return index.deleteObject(objectId);
}