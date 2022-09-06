
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";
import { createStore, withProps } from "@ngneat/elf";
import { persistState, localStorageStrategy } from "@ngneat/elf-persist-state";
import type { HomeActivities, HomeModel } from "./home.firestore.helpers";

export const persistHomeDataStore = createStore(
    {name: 'homeData'},
    withProps<HomeModel>({
        aboutCompany:null,
        homeActivities:null,
    })
);

export const homeDataPersist=persistState(persistHomeDataStore,{
    key: 'homeData',
    storage: localStorageStrategy,
});

export const setHomeDataPersist=(homeData:HomeModel) => {
   
    // console.log("setHomeDataPersist",homeData);
    return persistHomeDataStore.update((state)=>(state=homeData));
};

export const resetCurrentSelectedPersist=()=>{
    persistHomeDataStore.reset();
}