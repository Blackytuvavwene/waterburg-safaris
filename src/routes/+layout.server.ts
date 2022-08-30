import { getAbout } from "$lib/app-components/about-components/about.api";
import { error } from "@sveltejs/kit";
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";
import type { LayoutServerLoad } from './$types'; 
import { companyData } from "$lib/firebase";
import { setFooterProps, type FooterContactProps } from "$lib/app-components/footer/footerprops.types";

// const endpoint='http://localhost:3000/api/about-company';

// /** @type {import('./$types').PageServerLoad} */

export const load:LayoutServerLoad= async () => {
    const responseData = await companyData();

    if(responseData ) {
        const data = responseData;
        const aboutCompanyInfo=data as AboutCompanyResponse;

     setFooterProps(aboutCompanyInfo?.companyDetails );


       
        return {
            about: aboutCompanyInfo,
        } 
    }

    throw error(403,'failed to get data');
    
};