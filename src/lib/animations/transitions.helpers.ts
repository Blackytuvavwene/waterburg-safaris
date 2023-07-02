import { quintOut } from 'svelte/easing';



export interface FlyTransistion{
    delay?:number | 500;
    duration?:number | 1000;
    y?:number  | 0;
    x:number | 0;
    easing?:(t:number)=>number;
}