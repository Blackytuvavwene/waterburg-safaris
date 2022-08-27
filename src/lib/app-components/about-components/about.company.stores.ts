import { writable } from "svelte/store";
import type { AboutCompanyResponse } from "$lib/app-components/about-components/about.types";

const company:AboutCompanyResponse={};

const aboutCompanyDataStore= writable(company);