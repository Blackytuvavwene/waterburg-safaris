
import { error } from "@sveltejs/kit";
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";
import type { PageServerLoad, Action } from './$types';
import { companyData } from "$lib/firebase";


// /** @type {import('./$types').PageServerLoad} */

export const load:PageServerLoad= async () => {
    const responseData = await companyData();

    if(responseData ) {
        const data = responseData;

      
        return {
            about: data,
        } 
    }

    throw error(403,'failed to get data');
    
};

// export const prerender = true;


