import type { DocumentData, QueryDocumentSnapshot, SnapshotOptions, Timestamp } from "firebase/firestore";

   
   export interface AboutCompanyResponse {
    companyDetails?: CompanyDetails;
    companyGallery?: CompanyGallery[];
    companyStaff?:CompanyStaff[];
   //  createdAt?: Date;
    companyId?:string;
   //  updatedAt?: Date;
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

   // create firestore converter model for about company
   class AboutCompany{
      companyDetails?: CompanyDetails;
      companyGallery?: CompanyGallery[];
      companyStaff?:CompanyStaff[];
      createdAt?: Date;
      companyId?:string;
      updatedAt?: Date;


      constructor(
         companyDetails: CompanyDetails,
         companyGallery: CompanyGallery[],
         companyStaff: CompanyStaff[],
         createdAt?: Date,
         updatedAt?: Date,
         companyId?:string) {
            this.companyDetails = companyDetails;
            this.companyGallery = companyGallery;
            this.companyStaff = companyStaff;
            this.createdAt = createdAt;
            this.updatedAt = updatedAt;
            this.companyId = companyId;
         }

         toAboutResponse(data:AboutCompany){
            const newC:AboutCompanyResponse={
               companyDetails: data.companyDetails,
               companyGallery: data.companyGallery,
               companyStaff: data.companyStaff,
               // createdAt: data.createdAt,
               // updatedAt: data.updatedAt,
               companyId: data.companyId,
            }
            return newC;
         }

   }

   class DetailsOfCompany{
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

    constructor(
      companyName?: string,
       registrationNumber?:string,
       vatNo?:string,
       companyAddress?: string,
      telNo?: string,
      companyLogoUrl?: string,
      cellPhoneNos?: string[],
      overview?: string,
      seoDescription?: string,
      email?: string,){
         this.companyName = companyName;
         this.registrationNumber = registrationNumber;
         this.vatNo = vatNo;
         this.companyAddress = companyAddress;
         this.telNo = telNo;
         this.overview = overview;
         this.seoDescription = seoDescription;
         this.email = email;
         this.companyLogoUrl = companyLogoUrl;
         this.cellPhoneNos = cellPhoneNos;
      }

      
   }

   export const aboutCompanyConverter={
      toFirestore (aboutCompany:AboutCompany):DocumentData {
         return aboutCompany;
      },

      fromFirestore(snapshot:QueryDocumentSnapshot,
         options:SnapshotOptions):AboutCompany{
            const data=snapshot.data(options);
// const createdAt=new Date(data.createdAt.toDate());
// const updatedAt=new Date(data.updatedAt.toDate());
            return new AboutCompany(
               data.companyDetails,
            data.companyGallery,
            data.companyStaff,
            // createdAt,
            // updatedAt,
            data.companyId,
            );
         }
   }
   
  
   