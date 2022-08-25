<script lang="ts"></script>

<section class="flex flex-col bg-primary w-[100%] h-full px-4 py-6 justify-center items-center">
    <h1>Contact us</h1>
    <div class="w-[100%] mx-20 sm:flex-row flex flex-col justify-between items-center">
        <div>
            <h2>Want to know more</h2>
            <div >
                <span class="fill-red-500">
                    <i class="fa-solid fa-location-dot"></i>
                </span>
                
            </div>
        </div>
        <form class="w-[100%] sm:w-96 flex flex-col items-center bg-onPrimary p-6 rounded
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