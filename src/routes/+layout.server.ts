import { getAbout } from "$lib/app-components/about-components/about.api";
import { error } from "@sveltejs/kit";
import type { AboutResponse } from "$lib/app-components/about-components/about.types";
import type { LayoutServerLoad } from './$types';

const endpoint='https://6300056a9350a1e548e9706d.mockapi.io/about';

// /** @type {import('./$types').PageServerLoad} */

export const load:LayoutServerLoad= async () => {
    const response = await getAbout('GET', endpoint);

    if(response.status === 200) {
        const data = await response.json();
        return {
            about: data[0] as AboutResponse,
        } 
    }

    throw error(response.status);
    
};