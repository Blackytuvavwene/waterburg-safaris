import type { ActivitiesResponse } from "$lib/app-components/activities-components/activities.types";
import { activitiesData } from "$lib/firebase";
import { error } from "@sveltejs/kit";
import type { PageServerLoad } from "./$types";

export const load:PageServerLoad= async () => {
    const responseData = await activitiesData();

    if(responseData ) {
        const data = responseData;
        const activities=data as ActivitiesResponse[];
       
        return {
            activities: activities,
        } 
    }

    throw error(403,'failed to get data');
    
};