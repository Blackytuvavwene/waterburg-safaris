
import { error } from "@sveltejs/kit";
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";
import type { PageServerLoad, Action } from './$types';
import { companyData } from "$lib/firebase";


// /** @type {import('./$types').PageServerLoad} */

export const load:PageServerLoad= async () => {
    const responseData = await companyData();

    if(responseData ) {
        const data = responseData;
        const aboutCompanyInfo=data as AboutCompanyResponse;

      
        return {
            about: aboutCompanyInfo,
        } 
    }

    throw error(403,'failed to get data');
    
};


