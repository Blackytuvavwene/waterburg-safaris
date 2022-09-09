import { createStore, select, withProps } from '@ngneat/elf';
import type { CompanyDetails } from "../about-components/about.types";
import { localStorageStrategy, persistState } from '@ngneat/elf-persist-state';
import { writable } from 'svelte/store';
import { browser } from '$app/environment';

export interface FooterContactProps{
   companyDetails?:CompanyDetails;
};

// const footData =browser && localStorage.getItem('footData');

// export const footerPropStore= writable(footData ? JSON.parse(footData):'');

// if(browser){
//     footerPropStore.subscribe(data=>localStorage.footData=data);
// }

// export const setFooterProps=(footerData:FooterContactProps['companyDetails'])=>{
//     footerPropStore.update((data)=>data=JSON.stringify(footerData));
// }



const footData:CompanyDetails={};

export const footerPropStore= writable<CompanyDetails>({});

export const setFooterProps=(footerData?:CompanyDetails)=>{
  
    if(footerData){
        // console.log('set footer properties',footerData);
        footerPropStore.set(footerData);
    }
    
}





