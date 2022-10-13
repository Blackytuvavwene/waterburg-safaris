// Import the functions you need from the SDKs you need
import { getApps, initializeApp, type FirebaseApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { collection, doc, getDoc, getDocs, getFirestore} from "firebase/firestore";
import { aboutCompanyConverter } from "./app-components/about-components/about.types";
// import { 
//     VITE_FIREBASE_API_KEY, 
//     VITE_FIREBASE_APP_ID, 
//     VITE_FIREBASE_AUTH_DOMAIN, 
//     VITE_FIREBASE_MEASURING_ID, 
//     VITE_FIREBASE_MESSENGER_ID, 
//     VITE_FIREBASE_PROJECT_ID, 
//     VITE_FIREBASE_STORAGE_BUCKET } from "$env/static/private";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries


 


 
 

 

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  storageBucket: import.meta.env.VITE_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: import.meta.env.VITE_FIREBASE_MESSENGER_ID,
  appId: import.meta.env.VITE_FIREBASE_APP_ID,
  measurementId: import.meta.env.VITE_FIREBASE_MEASURING_ID
};



// const firebaseConfig = {
//     apiKey: "AIzaSyA5oKqp0yK3oljBdyVFk7EPL5E4vto3Ycw",
//     authDomain: "waterburg-safaris.firebaseapp.com",
//     projectId: "waterburg-safaris",
//     storageBucket: "waterburg-safaris.appspot.com",
//     messagingSenderId: "872126391062",
//     appId: "1:872126391062:web:03c551323fb6409897e637",
//     measurementId: "G-7YVD66BC10"
//   };

// Initialize Firebase
const appInit =()=>{
    if(!getApps().length) return initializeApp(firebaseConfig);
}
// const analytics = getAnalytics(app);

export const app:FirebaseApp=appInit() as FirebaseApp;
export const db =getFirestore(app);

const getAboutCompany=await getDoc(doc(db,'aboutCompany','ymV8H6FBRjfMBFhAh8o2').withConverter(aboutCompanyConverter));
    
const getActivities = await getDocs(collection(db,'activities'));

const getActivity = (activityID:string)=> getDoc(doc(db,'activities',activityID));
  
export const companyData=()=>{
if (getAboutCompany.exists()) {
    // console.log(getAboutCompany.data());
    const company=getAboutCompany.data();
   if (company != undefined){
    const companyData=company.toAboutResponse(company);
    return companyData;
   }
} else {
    console.error("No company data found");
}
}

// get all activities from firestore
export const activitiesData = async() =>{

        // console.log('hello world',getActivities.docs.values());
        return getActivities.docs.map(doc => doc.data());
    
}


// get activity data from firestore
export const activityData=async(docId?:string)=>{
    const data= await getActivity(docId?.toString() as string);
    if(data.exists()){
        return data.data();
    } else {
        throw "Failed to get activity data";
    }
}





