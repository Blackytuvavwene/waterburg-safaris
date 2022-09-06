import type { HomeModel } from "$lib/app-components/home-components/helpers/home.firestore.helpers";
import { error } from "@sveltejs/kit";
import type { PageServerLoad } from "./$types";

export const load:PageServerLoad= async ({parent}) => {
    const responseData = await parent();

    if(responseData ) {
        const data = responseData.homeData;
        const homeData=data as HomeModel;
        console.debug(homeData);
       
        return {
            homeData: homeData,
        } 
    }

    throw error(403,'failed to get data');
    
};