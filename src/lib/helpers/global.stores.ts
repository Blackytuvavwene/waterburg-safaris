import { writable } from "svelte/store";


// loading store
export const pageLoading = writable(false);

const isLoadingStore= () =>{
    const {subscribe, update, set}= writable({
        status: "idle",
        message: "",
    });

    function setNavigate(isNavigating: boolean) {
        update(() => {
          return {
            status: isNavigating ? 'navigating' : 'idle',
            message: '',
          };
        });
      }
    
      function setLoading(isLoading: boolean, message = '') {
        update(() => {
          return {
            status: isLoading ? 'loading' : 'idle',
            message: isLoading ? message : '',
          };
        });
      }

    return { subscribe, update, set, setNavigate, setLoading};
}

export const isLoading = isLoadingStore();

