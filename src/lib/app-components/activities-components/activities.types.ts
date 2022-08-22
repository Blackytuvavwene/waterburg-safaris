export interface ActivitiesList{
    activities:ActivitiesResponse[];
}

export interface ActivitiesResponse {
    id?:          string;
    activity?:    string;
    description?: string;
    gallery?:     string[];
    packages?:    Package[];
    tags?:        string[];
    createdAt?:   Date;
    updatedAt?:   Date;
}

export interface Package {
    id?:        string;
    name?:      string;
    price?:     string;
    lastPrice?: string;
    discount?:  number;
    includes?:  string[];
    createdAt?: Date;
    updatedAt?: Date;
}