import { error } from "@sveltejs/kit";
import type { LayoutServerLoad } from './$types'; 
import { getHomeActivities,  type HomeModel } from "$lib/app-components/home-components/helpers/home.firestore.helpers";
import { setHomeDataPersist } from "$lib/app-components/home-components/helpers/home.stores";

// const endpoint='http://localhost:3000/api/about-company';

// /** @type {import('./$types').PageServerLoad} */

export const load:LayoutServerLoad= async () => {

    let errorR;
   
    const Hdata=await getHomeActivities()
    .then((data)=>data,)
    .catch((err)=>{
        errorR=err;
        console.error(err);
    },);

    if(Hdata) {
        const data = Hdata ;

     setHomeDataPersist(data);
        return {
            homeData: data,
        } 
    }

    // string interpolation
    console.error(`errorR: ${errorR}`);

    throw error(403,`failed to get data :${errorR}`);
    
};

// export const prerender = 'auto';