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


export interface PaymentRequest{
    profile_id?: string;
    tran_type?: string | 'sale';
    tran_class?: string | 'ecom';
    cart_description?: string;
    cart_id?: string;
    cart_currency?: string;
    cart_amount?: number;
    callback?: string;
    return?: string;
}

export interface PaymentResponse{
    tran_ref?: string;
    cart_id?: string;
    cart_description?: string;
    cart_currency?: string;
    cart_amount?: number;
    customer_details?: PaymentCustomerDetails;
    payment_result?: PaymentResult;
    payment_info?: PaymentInfo;
}

export interface PaymentCustomerDetails{
    name?: string;
    email?: string;
    phone?: string;
    street1?: string;
    city?: string;
    state?: string;
    country?: string;
    ip?: string;
}

export interface PaymentResult{
    response_status?: string;
    response_code?: string;
    response_message?: string;
    acquirer_message?: string;
    acquirer_rrn?: string;
    transaction_time?: Date;
}

export interface PaymentInfo{
    card_type?: string;
    card_scheme?: string;
    payment_description?: string;
}

export interface PaymentRedirection{
    tran_ref?: string,
    cart_id?: string,
    cart_description?: string,
    cart_currency?: string,
    cart_amount?: string,
    callback?: string,
    return?: string,
    redirect_url?: string
}