<script lang="ts">
import ContactIconContainer from "./ContactIconContainer.svelte";

</script>

<section class="flex flex-col bg-primary-900 w-full h-full px-4 py-6 justify-center items-center">
    <h1 class="text-3xl font-extrabold text-onPrimary m-6">Contact us</h1>
    <div class="w-full mb-6 flex flex-col justify-between items-center">
        
        <form class="w-[100%] sm:w-[60%] lg:w-[30%] flex flex-col items-center bg-onPrimary p-6 rounded
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
