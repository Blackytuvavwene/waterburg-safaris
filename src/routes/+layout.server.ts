import { error } from "@sveltejs/kit";
import type { LayoutServerLoad } from './$types'; 
import { getHomeActivities } from "$lib/app-components/home-components/helpers/home.firestore.helpers";
import { homeDataStore } from "$lib/app-components/home-components/helpers/home.stores";

// const endpoint='http://localhost:3000/api/about-company';

// /** @type {import('./$types').PageServerLoad} */

export const load:LayoutServerLoad= async () => {

    let errorR;
   
    const Hdata = await getHomeActivities()
                                .then((data)=>data,)
                                .catch((err)=>{
                                        errorR=err;
                                        console.error(err);
                                    },);

    if(Hdata) {
        const data = Hdata ;
        // save to store
        homeDataStore().updateStore(data);     
        return {
            homeData: data,
        } 
    }

    // string interpolation
    console.error(`errorR: ${errorR}`);

    throw error(403,`failed to get data :${errorR}`);
    
};

// export const prerender = 'auto';