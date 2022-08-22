// function to get about page data
export const getAbout = async (method:string, endpoint:string) => {
    return await fetch(endpoint, {
        method: method,
        // headers: {
        //     'Content-Type': 'application/json'
        // }
    });
}