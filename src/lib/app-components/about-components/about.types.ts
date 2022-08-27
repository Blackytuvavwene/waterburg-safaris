export interface AboutApiResponse {
    docs?:          AboutCompanyResponse[];
    hasNextPage?:   boolean;
    hasPrevPage?:   boolean;
    limit?:         number;
    nextPage?:      null;
    page?:          number;
    pagingCounter?: number;
    prevPage?:      null;
    totalDocs?:     number;
    totalPages?:    number;
   }
   
   export interface AboutCompanyResponse {
    address?:         Address;
    companyDetails?:  CompanyDetails;
    companyGallery?:  CompanyGallery[];
    companyOverview?: string;
    companyStaff?:    CompanyStaff[];
    createdAt?:       Date;
    id?:              string;
    seo?:             SEO;
    updatedAt?:       Date;
   }
   
   export interface Address {
    cityOrTown?:      string;
    country?:         string;
    physicalAddress?: PhysicalAddress;
    postalAddress?:   string;
    street?:          string;
   }
   
   export interface PhysicalAddress {
    plotNo?: string;
    ward?:   string;
   }
   
   export interface CompanyDetails {
    companyName?:        string;
    contacts?:           Contacts;
    registrationNumber?: string;
    vatNo?:              string;
   }
   
   export interface Contacts {
    cellPhoneNos?: CellPhoneNo[];
    email?:        string;
    telphoneNo?:   string;
   }
   
   export interface CellPhoneNo {
    cellPhoneNo?: string;
    id?:          string;
   }
   
   export interface CompanyGallery {
    id?:    string;
    image?: string;
   }
   
   export interface CompanyStaff {
    companyStaffDetails?: CompanyStaffDetails;
    id?:                  string;
   }
   
   export interface CompanyStaffDetails {
    companyStaffEmail?:       string;
    companyStaffName?:        string;
    companyStaffPhoneNumber?: string;
    jobTitle?:                string;
    title?:                   string;
   }
   
   export interface SEO {
    seoDescription?: string;
    seoTitle?:       string;
   }
   