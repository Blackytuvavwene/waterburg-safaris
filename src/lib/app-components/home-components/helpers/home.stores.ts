
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";
import { createStore, withProps } from "@ngneat/elf";
import { persistState, localStorageStrategy } from "@ngneat/elf-persist-state";
import type { HomeActivities, HomeModel } from "./home.firestore.helpers";

export const persistHomeDataStore = createStore(
    {name: 'homeData'},
    withProps<HomeModel>({})
);

export const homeDataPersist=persistState(persistHomeDataStore,{
    key: 'homeData',
    storage: localStorageStrategy,
});

export const setHomeDataPersist=(homeData:HomeModel) => {
   const newD=homeData;
    
    if (newD) {
        console.log("setHomeDataPersist not null",newD);
        return persistHomeDataStore.update((state)=>(state=newD)); 
    }
    
};

export const resetCurrentSelectedPersist=()=>{
    persistHomeDataStore.reset();
}