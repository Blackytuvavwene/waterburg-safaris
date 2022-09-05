import type { ActivitiesResponse, Package } from "../activities-components/activities.types";

export interface BookingFormModel{
    bookingCode?: string;
    packageData?:Package;
    customerDetails?:CustomerDetails;
    activityDetails?:ActivitiesResponse;
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
    expiryDate?:string;
    cvv?:string;
}