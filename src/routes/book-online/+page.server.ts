import { getAbout } from "$lib/app-components/about-components/about.api";
import { error } from "@sveltejs/kit";
import type { PageServerLoad} from './$types';
import type {  Package } from "$lib/app-components/activities-components/activities.types";
import { currentActivity } from "$lib/app-components/activities-components/activity.stores";


let activity:string;


currentActivity.subscribe(id=>activity=id);

const endpoint=`https://6300056a9350a1e548e9706d.mockapi.io/activities/1/packages`;

// /** @type {import('./$types').PageServerLoad} */

export const load:PageServerLoad= async ({params}) => {
    const response = await getAbout('GET', `${endpoint}/${params.slug}`);

    if(response.status === 200) {
        const data = await response.json();
        const activity= data as Package;
        return {
            activity: activity,
        } 
        
    }

    throw error(response.status,response.json.toString());
    
};