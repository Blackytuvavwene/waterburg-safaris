import { createStore, setProps, withProps } from '@ngneat/elf';
import { writable } from 'svelte/store';
import { localStorageStrategy, persistState } from '@ngneat/elf-persist-state';
import type { ActivitiesResponse, Package } from '$lib/app-components/activities-components/activities.types';



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
