import { writable } from "svelte/store";
import type { Address, Contacts } from "../about-components/about.types"

export type FooterContactProps={
    address?:Address,
    contacts?:Contacts;
};


const footerProps:FooterContactProps={};

export const footerPropStore= writable(footerProps);