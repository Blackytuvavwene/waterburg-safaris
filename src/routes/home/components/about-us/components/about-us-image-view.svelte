<script lang="ts">
    export const lionImage='$lib/lion.JPG';
</script>

<div class="image-container">
    <img src="$lib/lion.JPG" alt="lion" sizes=""/>
</div>

<style lang="scss">
    .image-container{
        height: 30vh;
        width: 90vw;
        background: var(--mainWhite);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin: 20px;

        img{
            height: 100%;
            width: 100%;
            object-fit: cover;
            border: 1px solid black;
        }
    }


</style>