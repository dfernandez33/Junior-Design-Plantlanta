interface userRegistrationInterface {
    name:string;
    dob: string;
    profile_picture: string;
    phone: string;
    address: string;
    preferences: Preferences;
}

interface Preferences {
    event_type: string[];
    sporadic: boolean;
    proximity: string;
}