import { createStore, setProps, withProps } from '@ngneat/elf';
import { writable } from 'svelte/store';
import { localStorageStrategy, persistState } from '@ngneat/elf-persist-state';
import type { ActivitiesResponse, Package } from '$lib/app-components/activities-components/activities.types';
import type { BookingFormModel } from './booking.types';



// store to handle booking selections

export type BookingStore={
    activity?:ActivitiesResponse|null;
    packageD?:Package| null;
}

export const bookingStore = createStore(
    {name: 'bookingStore'},
    withProps<BookingStore>({activity:null,packageD:null,},)
);

export const bookingPersist=persistState(bookingStore,{
    key: 'bookingStore',
    storage: localStorageStrategy,
});




export const   updateActivity = (newAc?:ActivitiesResponse) => {
        bookingStore.update(setProps({activity:newAc}));
    };

export const   updatePackage=(newPa?:Package) =>{
        bookingStore.update(setProps({packageD:newPa}));
    };


// handle booking state changes
function bookingStateChange  () {


    const {subscribe , update, set} =writable({
        status:'Idle',
        data: <BookingFormModel>{},
        submitted: false,
        failure:'',
        message:''
    });

    function setLoading(state:boolean){
        update(()=>{
            return {
                status: state ? 'Booking' : '',
                data:{},
                submitted: false,
                failure:'',
                message: 'Your booking is being processed'
            };
        });
    };

    function setSubmitted<T>(state:boolean,dataSubmitted:Partial<T>,code?:string){
        update(()=>{
            return {
                status: state ? 'Success' : '',
                data:dataSubmitted,
                submitted: state ? true : false,
                failure:'',
                message: `Your booking is successful! save this booking code ${code}`
            };
        });
    };

    function setError(state:boolean,dataError:Partial<string>){
        update(()=>{
            return {
                status: state ? 'Error' : '',
                data:{},
                submitted: state ? true : false,
                failure:dataError,
                message: 'Your booking is unsuccessful try again later'
            };
        });
    };

    function resetAll(){
        set({
            status:'Idle',
            data: {},
            submitted: false,
            failure:'',
            message:''
        })
    };

    return { 
        subscribe,
        update,
        set, 
        setLoading, 
        setSubmitted, 
        setError, 
        resetAll
    }
}


export const bookingState= bookingStateChange();