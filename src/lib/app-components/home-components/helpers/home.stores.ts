import { writable } from "svelte/store";
import type { HomeModel } from "./home.firestore.helpers";



// create store
export const homeDataStore = () => {
    // initialize store
    const { subscribe, set, update } = writable<HomeModel>({
        aboutCompany: {},
        homeActivities: []
    });

    // function to update store
    const updateStore = (data: HomeModel) => {
        update((store) => {
            return { ...store, ...data };
        });
    };

    // set initial value
    const init = (data: HomeModel) => {
        set(data);
    };

    // return store, update, updateStore, init function
    return {
        subscribe,
        update,
        updateStore,
        init,
    };
}