export const handler = function(snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Items");

    const data = snapshot.after.data();
    const objectId = snapshot.after.id;

    return index.saveObject({
        name: data.name,
        brand: data.brand,
        objectID: objectId
    });
}