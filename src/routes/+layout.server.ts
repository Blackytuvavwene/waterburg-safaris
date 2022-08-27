import { getAbout } from "$lib/app-components/about-components/about.api";
import { error } from "@sveltejs/kit";
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";
import type { LayoutServerLoad } from './$types';
import {footerPropStore, type FooterContactProps} from '$lib/app-components/footer/footerprops.types';

const endpoint='http://localhost:3000/api/about-company';

// /** @type {import('./$types').PageServerLoad} */

export const load:LayoutServerLoad= async () => {
    const response = await getAbout('GET', endpoint);

    if(response.status === 200) {
        const data = await response.json();
        const aboutCompanyInfo=data['docs'][0] as AboutCompanyResponse;

      const newFootProps:FooterContactProps={
            address:aboutCompanyInfo.address,
            contacts: aboutCompanyInfo.companyDetails?.contacts,
       };


        footerPropStore.set(newFootProps);
        return {
            about: data['docs'][0] as AboutCompanyResponse,
        } 
    }

    throw error(response.status);
    
};