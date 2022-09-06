// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { collection, doc, getDoc, getDocs, getFirestore} from "firebase/firestore";
import { aboutCompanyConverter } from "./app-components/about-components/about.types";
// import { 
//     FIREBASE_API_KEY, 
//     FIREBASE_APP_ID, 
//     FIREBASE_AUTH_DOMAIN, 
//     FIREBASE_MEASURING_ID, 
//     FIREBASE_MESSENGER_ID, 
//     FIREBASE_PROJECT_ID, 
//     FIREBASE_STORAGE_BUCKET } from "$env/static/private";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries


 


 
 

 

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: import.meta.env.FIREBASE_API_KEY,
  authDomain: import.meta.env.FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.FIREBASE_PROJECT_ID,
  storageBucket: import.meta.env.FIREBASE_STORAGE_BUCKET,
  messagingSenderId: import.meta.env.FIREBASE_MESSENGER_ID,
  appId: import.meta.env.FIREBASE_APP_ID,
  measurementId: import.meta.env.FIREBASE_MEASURING_ID
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);
export const db =getFirestore(app);

const getAboutCompany=await getDoc(doc(db,'aboutCompany','ymV8H6FBRjfMBFhAh8o2').withConverter(aboutCompanyConverter));
    
const getActivities=await getDocs(collection(db,'activities'));

const getActivity=async (activityID:string)=>await getDoc(doc(db,'activities',activityID));
  
export const companyData=()=>{
if (getAboutCompany.exists()) {
    // console.log(getAboutCompany.data());
    const company=getAboutCompany.data();
   if (company != undefined){
    const companyData=company.toAboutResponse(company);
    return companyData;
   }
} else {
    console.log("No company data found");
}
}

// get all activities from firestore
export const activitiesData=()=>{
    if (getAboutCompany.exists()) {
        // console.log(getActivities.docs.values());
        return getActivities.docs.map(doc => doc.data());
    } else {
        console.log("No company data found");
    }
}


// get activity data from firestore
export const activityData=async(docId?:string)=>{
    const data= await getActivity(docId!);
    if(data.exists()){
        return data.data();
    } else {
        throw "Failed to get activity data";
    }
}

