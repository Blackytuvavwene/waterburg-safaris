export interface ButtonProps {
    title?:string;
    backGroundColor?:string;
    fontColor?:string;
    fontSize?:string;
    fontWeight?:string;
    padding?:string;
    margin?:string;
    borderRadius?:string;
    bgHoverColor?:string;
    fontHoverColor?:string;
}

export function buttonPropDataToList(button?:ButtonProps){
   
   let buttonPropDataList:string[]=[];

    const list=[
        button?.backGroundColor,
        button?.fontColor,
        button?.fontSize,
        button?.fontWeight,
        button?.padding,
        button?.margin,
        button?.borderRadius,
        button?.bgHoverColor,
        button?.fontHoverColor,
    ];

    return buttonPropDataList=list as string[];
  

}

