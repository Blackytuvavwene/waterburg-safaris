<script lang="ts">
import ContactIconContainer from "./ContactIconContainer.svelte";

</script>

<section class="flex flex-col bg-primary w-[100%] h-full px-4 py-6 justify-center items-center">
    <h1 class="text-3xl font-extrabold text-onPrimary m-6">Contact us</h1>
    <div class="w-[100%] sm:pl-10 sm:flex-row flex flex-col justify-between items-center">
        <div class="w-[100%] md:w-[30%] lg:w-[45%] p-4 flex flex-col items-center justify-center">
            <h2 class="text-2xl w-[100%] text-center font-bold text-onPrimary md:text-start">Contact information</h2>
            <div class="flex flex-col w-[100%] items-center justify-center">
                <ContactIconContainer iconData="fa-solid fa-phone" contactData="+267 71 234 567"/>
                <ContactIconContainer iconData="fa-solid fa-envelope-open" contactData="waterburgsafaris@gmail.com"/>
                <ContactIconContainer iconData="fa-solid fa-map-location-dot" contactData="Plot 1111, Kazungula Botswana"/>
            </div>
        </div>
        <form class="w-[100%] sm:w-[60%] flex flex-col items-center bg-onPrimary p-6 rounded
         justify-center" action="" method="post">
            <fieldset class=" flex w-full flex-col justify-center mb-8">
                <div>
                    <label class="" for="names">Full names</label>
                    <input class="border-2 border-primary rounded-md p-2 mb-6 w-full" 
                    placeholder="Enter full names" type="text" name="names" id="names">
                </div>
                <div>
                    <label for="email">Email</label>
                    <input class="border-2 border-primary rounded-md p-2 w-full bg-surfaceVariant" 
                    placeholder="Input email" type="email" name="email" id="email">
                </div>
            </fieldset>
           <fieldset class="w-full">
            <label for=""></label>
            <textarea class="w-full p-4 border-primary border-2 
            rounded-md" name="" id="" cols="30" rows="5"></textarea>
           </fieldset>
           <input class="w-full bg-onPrimaryContainer text-primaryContainer my-6 p-2
            rounded-md" type="submit" value="Submit">
        </form>
        
    </div>
</section>
