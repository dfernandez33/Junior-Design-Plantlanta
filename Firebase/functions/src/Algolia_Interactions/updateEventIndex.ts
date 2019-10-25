import { Event } from "../Interface/Event_Interactions_Interface/event";

export const handler = function(snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Events");

    const data: Event = snapshot.after.data();
    const objectId = snapshot.after.id;

    return index.saveObject({
        name: data.name,
        location: data.location,
        objectID: objectId
    });
}