import { createStore, withProps } from '@ngneat/elf';
import { writable } from 'svelte/store';
import { localStorageStrategy, persistState } from '@ngneat/elf-persist-state';
import type { ActivitiesResponse } from './activities.types';

export type currentA={
    activity?:ActivitiesResponse|null;
    pID?:string|null;
}

// export const currentSelected = writable<currentA>();

// export const setCurrentSelected=(activityID:string,packageID:string) => {
//     console.log('hello select ',packageID,activityID);
//     const newC:currentA={
//         aID:activityID,
//         pID:packageID
//     }
//     return currentSelected.set(newC);
// };

export const persistCurrentSelectedStore = createStore(
    {name: 'currentSelected'},
    withProps<currentA>({activity:null,pID:null})
);

export const currentPersist=persistState(persistCurrentSelectedStore,{
    key: 'currentSelected',
    storage: localStorageStrategy,
});

export const setCurrentSelectedPersist=(activityNew:ActivitiesResponse,packageID:string) => {
   
    const newC:currentA={
       activity:activityNew,
        pID:packageID
    }
    return persistCurrentSelectedStore.update((state)=>(state=newC));
};

export const resetCurrentSelectedPersist=()=>{
    persistCurrentSelectedStore.reset();
}


