export interface Event {
    eventId: string;
    name: string;
    location: string;
    description: string;
    date;
    startTime: string;
    endTime: string;
    participants: string[];
    confirmed_participants: string[];
    createdBy: string;
    createdOn: string;
}
