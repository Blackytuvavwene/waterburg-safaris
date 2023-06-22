import type { CompanyGallery } from "../about-components/about.types";

export interface ActivitiesList{
    activities:ActivitiesResponse[];
}

export interface ActivitiesResponse {
    activityId?: string;
    activityName?:string;
    seoDescription?: string;
    activityGallery?:CompanyGallery[];
    packages?:Package[];
    overview: string;
    tags?: string[];
    createdAt?:   Date;
    updatedAt?:   Date;
}

export interface Package {
    packageId?:        string;
    coupon?:string;
    keywords?:string[];
    description?: string;
    packageName?:      string;
    price?:     number;
    lastPrice?: number;
    rating?: number;
    discountPercentage?:  number;
    packageOffers?:  string[];
    createdAt?: Date;
    updatedAt?: Date;
}