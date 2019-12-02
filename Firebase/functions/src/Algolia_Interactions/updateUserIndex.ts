export const handler = function(snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Users");

    const data = snapshot.after.data();
    const objectId = snapshot.after.id;

    return index.saveObject({
        name: data.name,
        phone: data.phone,
        picture: data.picture,
        objectID: objectId
    });
}