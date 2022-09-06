import type { AboutCompanyResponse, CompanyGallery } from "$lib/app-components/about-components/about.types";
import { activitiesData, companyData, db } from "$lib/firebase";
import { collection, FirestoreError, getDocs } from "firebase/firestore";

export interface HomeActivities{
    activityId?: string;
    activityName?: string;
    tags?: string[];
    activityDetails?: string;
    image?:CompanyGallery;
   

}

export interface HomeModel{
    aboutCompany?:AboutCompanyResponse;
    homeActivities?:HomeActivities[];
}

export const getHomeActivities=async()=>{
try {
    const data= await getDocs(collection(db,'activities'));
    const cData= companyData();
    if (data && cData) {



       const home= data.docs.map(doc => {
           const newD = doc.data();
           const newH: HomeActivities = {
               activityId: newD.activityId,
               activityName: newD.activityName,
               tags: newD.tags,
               activityDetails: newD.seoDescription,
               image: newD.activityGallery[0],
           };


           return newH as HomeActivities;
       });

       

        const homeData:HomeModel={
            aboutCompany:cData as AboutCompanyResponse,
            homeActivities:home as HomeActivities[],
        }

        // console.log(homeData.homeActivities![0].activityId);

        return homeData;
    }
} catch (error) {
    console.error('failed super',error);
}
}