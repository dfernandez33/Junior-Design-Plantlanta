export const handler = function(snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Items");

    const data = snapshot.data();
    const objectID = snapshot.id;

    return index.addObject({
        name: data.name,
        brand: data.brand,
        objectID: objectID
    });
}