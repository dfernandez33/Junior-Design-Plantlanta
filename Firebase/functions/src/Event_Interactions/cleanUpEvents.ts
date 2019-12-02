export const handler = async function(context, firestore: FirebaseFirestore.Firestore) {
    const passedEvents = await firestore.collection("Events").where("date", "<=", new Date()).where("passed", "==", "false").get();
    console.log(passedEvents);
    let batch = firestore.batch();
    passedEvents.forEach((event) => {
        console.log(event);
        batch.update(event.ref, {
            passed: true
        });
    });
    return batch.commit();
}