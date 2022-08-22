



export interface AboutResponse {
    id?:                 string;
    companyName?:        string;
    registrationNumber?: string;
    seoDescription?:     string;
    overview?:           string;
    slogan?:             string;
    contact?:            Contact;
    companyStaff?:       CompanyStaff[];
    gallery?:            string[];
    createdAt?:          Date;
    updatedAt?:          Date;
}

export interface CompanyStaff {
    fullName?: string;
    title?:    string;
}

export interface Contact {
    phone?:   string;
    email?:   string;
    address?: Address;
}

export interface Address {
    countryCode?:      string;
    country?:          string;
    formattedAddress?: string;
    geoPoints?:        GeoPoints;
    socialLinks?:      SocialLink[];
}

export interface GeoPoints {
    lat?: string;
    lng?: string;
}

export interface SocialLink {
    name?: string;
    url?:  string;
}