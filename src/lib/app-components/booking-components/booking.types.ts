import type { ActivitiesResponse, Package } from "../activities-components/activities.types";

export interface BookingFormModel{
    bookingCode?: string;
    customerDetails?:CustomerDetails;
    activityDetails?:ActivityDetails;
    departureDate?:Date;
    arrivalDate?:Date;
    paid?:boolean;
    amountPaid?:number;
}

export interface CustomerDetails{
    fullNames?:string;
    email?:string;
    creditCardDetails?:CreditCardModel;
}

export interface CreditCardModel{
    cardNumber?:string;
    cardHolderNames?:string;
    expiryDate?:Date;
    cvv?:string;
}

export interface BookedPackage{
packageId?:string;
packageName?:string;
}

export interface ActivityDetails{
    activityName?:string;
    activityId?:string;
    bookedPackage?:BookedPackage;
}