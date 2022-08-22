import { getAbout } from "$lib/app-components/about-components/about.api";
import { error } from "@sveltejs/kit";
import type { PageServerLoad, Action } from './$types';
import type { ActivitiesList, ActivitiesResponse } from "$lib/app-components/activities-components/activities.types";

const endpoint='https://6300056a9350a1e548e9706d.mockapi.io/activities';

// /** @type {import('./$types').PageServerLoad} */

export const load:PageServerLoad= async () => {
    const response = await getAbout('GET', endpoint);

    if(response.status === 200) {
        const data = await response.json();
        const activities= data as ActivitiesResponse[];
        return {
            activities: activities,
        } 
        
    }

    throw error(response.status);
    
};