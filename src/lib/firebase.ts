// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { collection, doc, getDoc, getDocs, getFirestore} from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyA5oKqp0yK3oljBdyVFk7EPL5E4vto3Ycw",
  authDomain: "waterburg-safaris.firebaseapp.com",
  projectId: "waterburg-safaris",
  storageBucket: "waterburg-safaris.appspot.com",
  messagingSenderId: "872126391062",
  appId: "1:872126391062:web:03c551323fb6409897e637",
  measurementId: "G-7YVD66BC10"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);
const db =getFirestore(app);

const getAboutCompany=await getDoc(doc(db,'aboutCompany','ymV8H6FBRjfMBFhAh8o2'));
    
const getActivities=await getDocs(collection(db,'activities'));

const getActivity=async (activityID:string)=>await getDoc(doc(db,'activities',activityID));
  
export const companyData=()=>{
if (getAboutCompany.exists()) {
    // console.log(getAboutCompany.data());
    return getAboutCompany.data();
} else {
    console.log("No company data found");
}
}

// get all activities from firestore
export const activitiesData=()=>{
    if (getAboutCompany.exists()) {
        console.log(getActivities.docs.values());
        return getActivities.docs.map(doc => doc.data());
    } else {
        console.log("No company data found");
    }
}


// get activity data from firestore
export const activityData=async(docId:string)=>{
    const data= await getActivity(docId);
    if(data.exists()){
        return data.data();
    } else {
        throw "Failed to get activity data";
    }
}

