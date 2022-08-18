<script lang="ts">
    export let title:string;
    export let backGroundColor:string;
    export let fontColor:string;
    export let fontSize:string;
    export let fontWeight:string;
    export let padding:string;
    export let margin:string;
    export let borderRadius:string;
    import '../../../app.css';
</script>

<button style="color:{fontColor}; background-color:{backGroundColor}; font-size:{fontSize};
font-variation-settings: 'wght',{fontWeight}; padding:{padding}; margin:{margin}; border-radius:{borderRadius}">
   {title}
</button>

<style lang="scss">
    button {
        background-color: var(--primary-container);
        border: none;
        border-radius: 5px;
        padding: 16px;
        margin-top: 16px;
        font-variation-settings: 'wght', 800;
    }

    @media (min-width: 768px) {
        button {
            font-size: 1.4rem;
        }
    }

    button:hover{
        background-color:var(--on-primary-container);
        color: var(--primary-container);
        cursor: pointer;
    }
</style>