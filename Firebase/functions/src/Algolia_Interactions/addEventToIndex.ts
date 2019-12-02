import { Event } from "../Interface/Event_Interactions_Interface/event";

export const handler = function(snapshot, algoliaClient) {
    const index = algoliaClient.initIndex("Events");

    const data: Event = snapshot.data();
    const objectID = snapshot.id;

    return index.addObject({
        name: data.name,
        location: data.location,
        type: data.type,
        objectID: objectID
    });
}