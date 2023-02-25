import { error } from "@sveltejs/kit";
import type { LayoutServerLoad } from './$types'; 
import { getHomeActivities,  type HomeModel } from "$lib/app-components/home-components/helpers/home.firestore.helpers";
import { setHomeDataPersist } from "$lib/app-components/home-components/helpers/home.stores";

// const endpoint='http://localhost:3000/api/about-company';

// /** @type {import('./$types').PageServerLoad} */

export const load:LayoutServerLoad= async () => {
   
    const Hdata=await getHomeActivities().then(data=>data);

    if(Hdata) {
        const data = Hdata as HomeModel;

     setHomeDataPersist(data);


       
        return {
            homeData: data,
        } 
    }

    throw error(403,'failed to get data');
    
};

// export const prerender = 'auto';