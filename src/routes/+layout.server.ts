import { getAbout } from "$lib/app-components/about-components/about.api";
import { error } from "@sveltejs/kit";
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";
import type { LayoutServerLoad } from './$types'; 
import { companyData } from "$lib/firebase";
import { setFooterProps, type FooterContactProps } from "$lib/app-components/footer/footerprops.types";
import { getHomeActivities, type HomeActivities, type HomeModel } from "$lib/app-components/home-components/helpers/home.firestore.helpers";
import { setHomeDataPersist } from "$lib/app-components/home-components/helpers/home.stores";

// const endpoint='http://localhost:3000/api/about-company';

// /** @type {import('./$types').PageServerLoad} */

export const load:LayoutServerLoad= async () => {
   
    const Hdata=await getHomeActivities();

    if(Hdata) {
        const data = Hdata as HomeModel;

     setHomeDataPersist(data);


       
        return {
            homeData: JSON.parse(JSON.stringify(Hdata)) as HomeModel,
        } 
    }

    throw error(403,'failed to get data');
    
};

export const prerender = 'auto';