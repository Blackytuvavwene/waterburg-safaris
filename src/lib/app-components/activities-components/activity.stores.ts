import { createStore, withProps } from '@ngneat/elf';
import { writable } from 'svelte/store';
import { localStorageStrategy, persistState } from '@ngneat/elf-persist-state';
import type { ActivitiesResponse, Package } from './activities.types';

export type currentA={
    activity?:ActivitiesResponse|null;
    packageD?:Package|null;
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
    withProps<currentA>({activity:null,packageD:null})
);

export const currentPersist=persistState(persistCurrentSelectedStore,{
    key: 'currentSelected',
    storage: localStorageStrategy,
});

export const setCurrentSelectedPersist=(activityNew:ActivitiesResponse,packageID:Package) => {
   
    const newC:currentA={
       activity:activityNew,
        packageD:packageID
    }
    return persistCurrentSelectedStore.update((state)=>(state=newC));
};

export const resetCurrentSelectedPersist=()=>{
    persistCurrentSelectedStore.reset();
}




