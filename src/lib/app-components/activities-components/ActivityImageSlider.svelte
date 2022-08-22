<script lang="ts">
    export let images:string[];

    let imageIndex:number=0;

  function  next(){
        if(imageIndex < images.length -1){
            imageIndex+=1;
        }
    }

    function prev(){
        if(imageIndex > 0){
            imageIndex-=1;
        }
    }

</script>

<div>
        <img src={images[imageIndex]} alt="" class="image"/>
        <p>{imageIndex}</p>
    <div>
        <button on:click={next} >Next</button>
        <button on:click={prev}>Prev</button>
    </div>
    
  
</div>