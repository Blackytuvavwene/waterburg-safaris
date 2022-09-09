import type {BookingFormModel } from "$lib/app-components/booking-components/booking.types";
import { db } from "$lib/firebase";
import { collection, doc, getDoc, getDocs, setDoc, type DocumentData, type FirestoreDataConverter, type QueryDocumentSnapshot, type SnapshotOptions } from "firebase/firestore";


// firestore converter
export const firestoreConverter= <T>() => ({
    toFirestore (data:Partial<T>) {
       return data;
    },
    fromFirestore(snapshot:QueryDocumentSnapshot,
        options:SnapshotOptions){
          return  snapshot.data(options) as T;
        }
});

// firestore database points

// return  await setDoc(docRef,event.detail.bookingModel)


const docRef=<T>(collectionPath:string,id?:string)=>{
    if(id){
        return  doc(db,collectionPath,id).withConverter(firestoreConverter<Partial<T>>());
    }else{
        return doc(db,collectionPath).withConverter(firestoreConverter<Partial<T>>());
    }
}

const docsRef=<T>(collectionPath:string,id?:string)=>{
    if(id){
        return  collection(db,collectionPath,id).withConverter(firestoreConverter<Partial<T>>());
    }else{
        return collection(db,collectionPath).withConverter(firestoreConverter<Partial<T>>());
    }
}

const setData=async <T>(collectionPath:string,id?:string,data?:T)=>{
   return await setDoc(docRef<T>(collectionPath,id),data);
}


const getData=async <T>(collectionPath:string,id?:string)=>{
    return await getDoc(docRef<T>(collectionPath,id));
}

const getDocuments=async <T>(collectionPath:string)=>{
    return await getDocs(docsRef<T>(collectionPath));
}

export const DatabaseHandler ={
    setBooking:(id:string,data:BookingFormModel)=> setData<BookingFormModel>('bookings',id,data),
    getBooking: (id:string)=>getData<BookingFormModel>('bookings',id),
}
