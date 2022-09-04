<script>

import ContactIconContainer from "./ContactIconContainer.svelte";
import ContactPageIcon from "./ContactPageIcon.svelte";

</script>
<main class="flex flex-col bg-primaryContainer w-[100%] lg:px-32 h-full s:px-2 px-10 py-6 justify-center items-center">
    
    <div class="w-[100%]  lg:flex-row flex flex-col justify-between items-center">
        <section class="flex flex-col justify-center items-center lg:items-start w-full">
            <h1 class="text-3xl font-extrabold text-onPrimaryContainer ">Contact us</h1>
            <div class="w-[100%]  lg:w-[45%] my-6 flex flex-col items-center justify-center">
                <h2 class="text-lg w-[100%] text-center  text-onPrimaryContainer lg:text-start">We would love to hear from you</h2>
                <div class="flex flex-col gap-2 w-[100%] md:flex-row lg:flex-col lg:items-start lg:justify-start h-full items-center justify-center">
                    <ContactPageIcon iconData="fa-solid fa-phone" contactData="+267 71 234 567"/>
                    <ContactPageIcon iconData="fa-solid fa-envelope-open" contactData="waterburgsafaris@gmail.com"/>
                    <ContactPageIcon iconData="fa-solid fa-map-location-dot" contactData="Plot 1111, Kazungula Botswana"/>
                </div>
            </div>
        </section>
        <form class="w-[100%] sm:w-[92%] lg:w-[70%] flex flex-col items-center s:p-4 bg-onPrimary  p-8 rounded
         justify-center" action="" method="post">
            <fieldset class=" flex w-full flex-col justify-center mb-8">
                <div>
                    <label class="" for="names">Full names</label>
                    <input class="border-2 border-primary rounded-md p-2 mb-6 w-full" 
                    placeholder="Enter full names" type="text" name="names" id="names">
                </div>
                <div>
                    <label for="email">Email</label>
                    <input class="border-2 border-primary rounded-md p-2 w-full " 
                    placeholder="Input email" type="email" name="email" id="email">
                </div>
            </fieldset>
           <fieldset class="w-full">
            <label for=""></label>
            <textarea class="w-full p-4 border-primary border-2 
            rounded-md" name="" id="" cols="30" rows="5"></textarea>
           </fieldset>
           <input class="w-full  bg-onPrimaryContainer text-primaryContainer mt-6 p-6
            rounded-md" type="submit" value="Submit">
        </form>
        
    </div>
</main>