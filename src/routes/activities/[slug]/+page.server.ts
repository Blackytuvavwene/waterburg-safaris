
import { error } from "@sveltejs/kit";
import type { PageServerLoad,  } from './$types';
import type {  ActivitiesResponse } from "$lib/app-components/activities-components/activities.types";
import { activityData } from "$lib/firebase";

// const endpoint='https://6300056a9350a1e548e9706d.mockapi.io/activities';

// /** @type {import('./$types').PageServerLoad} */

export const load:PageServerLoad= async ({params}) => {
    const responseData = await activityData(params.slug);

    if(responseData ) {
        const data = responseData;
        const activity=data as ActivitiesResponse;
       
        return {
            activity: activity,
        } 
    }

    throw error(403,'failed to get data');
    
};


// export const prerender = 'auto';