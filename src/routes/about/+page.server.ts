import { getAbout } from "$lib/app-components/about-components/about.api";
import { error } from "@sveltejs/kit";
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";
import type { PageServerLoad, Action } from './$types';

const endpoint='http://localhost:3000/api/about-company';

// /** @type {import('./$types').PageServerLoad} */

export const load:PageServerLoad= async () => {
    const response = await getAbout('GET', endpoint);

    if(response.status === 200) {
        const data = await response.json();
        const aboutCompanyInfo=data['docs'][0] as AboutCompanyResponse;

      
        return {
            about: aboutCompanyInfo,
        } 
    }

    throw error(response.status);
    
};


