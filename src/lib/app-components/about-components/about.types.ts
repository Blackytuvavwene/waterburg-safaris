
   
   export interface AboutCompanyResponse {
    companyDetails?: CompanyDetails;
    companyGallery?: CompanyGallery[];
    companyStaff?:CompanyStaff[];
    createdAt?: Date;
    companyId?:string;
    updatedAt?: Date;
   }
   
  
   export interface CompanyDetails {
    companyName?: string;
    registrationNumber?:string;
    vatNo?:string;
    companyAddress?: string;
    telNo?: string;
    companyLogoUrl?: string;
    cellPhoneNos?: string[];
    overview?: string;
    seoDescription?: string;
    email?: string;
   }
   


   
   export interface CompanyGallery {
    imageUrl?:    string;
    imageDescription?: string;
    imageTitle?: string;
   }
   
   export interface CompanyStaff {
    jobTitle?:string;
    imageUrl?:string;
    jobDescription?:string;
    fullName?:string;
    phoneNos?:string[];
    title?:string;
    email?:string;
   }
   
  
   