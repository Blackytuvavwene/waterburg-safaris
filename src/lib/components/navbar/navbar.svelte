<script lang="ts">
import { onMount } from "svelte";


    let mobileNavBarShow = false;
    // hide and open navigation drawer
    function toggleNavBar() {
        mobileNavBarShow = !mobileNavBarShow;
    };

    // close navigation drawer when clicked outside of it
    function closeNavBar() {
       
        mobileNavBarShow = false;
    };

    // watch media query and close navigation drawer when it's small
    onMount(() => {
        const mq = window.matchMedia("(max-width: 600px)");
       if(mq.matches) {
        mq.addListener(closeNavBar);
       }
    }
    );

   

</script>



<nav>
    <div class="logo">
        Logo
    </div>
    <div class="menu-icon" on:click={toggleNavBar}>
        <div class="menu-icon-bar"></div>
        <div class="menu-icon-bar"></div>
        <div class="menu-icon-bar"></div>
    </div>
    <ul class={mobileNavBarShow ? "mobile-links" : "nav-links"}>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="b">Contact</a></li>
        <li><a href="c">{mobileNavBarShow}</a></li>
        <li><a href="c">{mobileNavBarShow ? "mobile-links" : "nav-links"}</a></li>
    </ul>
</nav>

<style lang="scss">
    nav {
        background: var(--on-primary-container);
        position: fixed;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        z-index: 10;
        top: 0;
        height: fit-content;

        /* Extra small devices (phones, 600px and down) */
        @media (max-width: 600px) {
            display: block;
        }

        /* Small devices (portrait tablets and large phones, 600px and up) */
        @media only screen and (min-width: 600px) {
            display: block;
        }

        /* Medium devices (landscape tablets, 768px and up) */
        @media only screen and (min-width: 768px) {
        }

        /* Large devices (laptops/desktops, 992px and up) */
        @media only screen and (min-width: 992px) {
        }

        /* Extra large devices (large laptops and desktops, 1200px and up) */
        @media only screen and (min-width: 1200px) {
        }

        ul{
            width: 100%;
            height: fit-content;
            padding: 0;
            margin:0 auto;
            list-style-type: none;
        
            /* Extra small devices (phones, 600px and down) */
            @media (max-width: 600px) {
            }

            /* Small devices (portrait tablets and large phones, 600px and up) */
            @media only screen and (min-width: 600px) {
            }

            /* Medium devices (landscape tablets, 768px and up) */
            @media only screen and (min-width: 768px) {
            }

            /* Large devices (laptops/desktops, 992px and up) */
            @media only screen and (min-width: 992px) {
            }

            /* Extra large devices (large laptops and desktops, 1200px and up) */
            @media only screen and (min-width: 1200px) {
            }

            li{
                float: right;

                a{
                    color: var(--on-primary);
                }
            }
        }



        .logo {
            height: 30px;
            width: 30px;
            background: var(--logoGreen);
            border-radius: 50%;
            float: left;
            margin-right: 10px;
            padding: 10px;
            color: var(--on-primary);

            /* Extra small devices (phones, 600px and down) */
            @media (max-width: 600px) {
                float: left;
            }

            /* Small devices (portrait tablets and large phones, 600px and up) */
            @media only screen and (min-width: 600px) {
            }

            /* Medium devices (landscape tablets, 768px and up) */
            @media only screen and (min-width: 768px) {
            }

            /* Large devices (laptops/desktops, 992px and up) */
            @media only screen and (min-width: 992px) {
            }

            /* Extra large devices (large laptops and desktops, 1200px and up) */
            @media only screen and (min-width: 1200px) {
            }
        }

        .menu-icon{
            width: 10%;
            height: 5vh;
            display: flex;
            float: right;
            align-items: center;
            justify-content: center;
            flex-direction: column;

            /* Extra small devices (phones, 600px and down) */
            @media (max-width: 600px) {
            }

            /* Small devices (portrait tablets and large phones, 600px and up) */
            @media only screen and (min-width: 600px) {
                display: none;
            }

            /* Medium devices (landscape tablets, 768px and up) */
            @media only screen and (min-width: 768px) {
                display: none;
            }

            /* Large devices (laptops/desktops, 992px and up) */
            @media only screen and (min-width: 992px) {
            }

            /* Extra large devices (large laptops and desktops, 1200px and up) */
            @media only screen and (min-width: 1200px) {
            }

            .menu-icon-bar {
                background-color: var(--primary);
                width: 70%;
                height: 2px;
                padding: 1px;
                margin:2px;

                /* Extra small devices (phones, 600px and down) */
                @media (max-width: 600px) {
                }

                /* Small devices (portrait tablets and large phones, 600px and up) */
                @media only screen and (min-width: 600px) {
                }

                /* Medium devices (landscape tablets, 768px and up) */
                @media only screen and (min-width: 768px) {
                }

                /* Large devices (laptops/desktops, 992px and up) */
                @media only screen and (min-width: 992px) {
                }

                /* Extra large devices (large laptops and desktops, 1200px and up) */
                @media only screen and (min-width: 1200px) {
                }
            }
        }

        .nav-links {
            height: 100%;

            /* Extra small devices (phones, 600px and down) */
            @media (max-width: 600px) {
                display: none;
            }

            /* Small devices (portrait tablets and large phones, 600px and up) */
            @media only screen and (min-width: 600px) {
            }

            /* Medium devices (landscape tablets, 768px and up) */
            @media only screen and (min-width: 768px) {
                display: block;
               
            }

            /* Large devices (laptops/desktops, 992px and up) */
            @media only screen and (min-width: 992px) {
               
            }

            /* Extra large devices (large laptops and desktops, 1200px and up) */
            @media only screen and (min-width: 1200px) {
            }

            li {
                list-style-type: none;
                float: right;
                display: flex;
                align-items: flex-start;
                text-align: center;
                height: 100%;

                /* Extra small devices (phones, 600px and down) */
                @media (max-width: 600px) {
                }

                /* Small devices (portrait tablets and large phones, 600px and up) */
                @media only screen and (min-width: 600px) {
                }

                /* Medium devices (landscape tablets, 768px and up) */
                @media only screen and (min-width: 768px) {
                }

                /* Large devices (laptops/desktops, 992px and up) */
                @media only screen and (min-width: 992px) {
                }

                /* Extra large devices (large laptops and desktops, 1200px and up) */
                @media only screen and (min-width: 1200px) {
                }

                a {
                    color: var(--on-primary);
                    text-transform: capitalize;
                    text-decoration: none;
                    font-size: 1.2rem;
                    padding: 12px;

                    /* Extra small devices (phones, 600px and down) */
                    @media (max-width: 600px) {
                    }

                    /* Small devices (portrait tablets and large phones, 600px and up) */
                    @media only screen and (min-width: 600px) {
                    }

                    /* Medium devices (landscape tablets, 768px and up) */
                    @media only screen and (min-width: 768px) {
                    }

                    /* Large devices (laptops/desktops, 992px and up) */
                    @media only screen and (min-width: 992px) {
                    }

                    /* Extra large devices (large laptops and desktops, 1200px and up) */
                    @media only screen and (min-width: 1200px) {
                    }
                }

                a:hover {
                    color: var(--on-primary-container);
                    background-color: var(--primary-container);

                    /* Extra small devices (phones, 600px and down) */
                    @media (max-width: 600px) {
                    }

                    /* Small devices (portrait tablets and large phones, 600px and up) */
                    @media only screen and (min-width: 600px) {
                    }

                    /* Medium devices (landscape tablets, 768px and up) */
                    @media only screen and (min-width: 768px) {
                    }

                    /* Large devices (laptops/desktops, 992px and up) */
                    @media only screen and (min-width: 992px) {
                    }

                    /* Extra large devices (large laptops and desktops, 1200px and up) */
                    @media only screen and (min-width: 1200px) {
                    }
                }

            }
            

            
        }

        
        
        .mobile-links{

            margin-top: 50px;
            margin-right: 20px;
            
            /* Extra small devices (phones, 600px and down) */
            @media only screen and (max-width: 600px) {
                display: flex;
                flex-direction: column;
                align-items:center;
                justify-content:center;
                list-style-type: none;
                transition: transform 0.9s ease-in-out;
            }

            /* Small devices (portrait tablets and large phones, 600px and up) */
            @media only screen and (min-width: 600px) {
                display: flex;
                flex-direction: column;
                align-items:center;
                justify-content:center;
                list-style-type: none;
                transition: transform 0.9s ease-in-out;
            }

            /* Medium devices (landscape tablets, 768px and up) */
            @media only screen and (min-width: 768px) {
                display: none;
            }

            /* Large devices (laptops/desktops, 992px and up) */
            @media only screen and (min-width: 992px) {
                display: none;
            }

            /* Extra large devices (large laptops and desktops, 1200px and up) */
            @media only screen and (min-width: 1200px) {
                display: none;
            }


                li {
                    text-align: center;
                    border: 1px solid var(--on-primary-container);
                    width: 100%;
                    padding: 10px;
                    background-color: var(--primary-container);

                    /* Extra small devices (phones, 600px and down) */
                    @media (max-width: 600px) {
                    }

                    /* Small devices (portrait tablets and large phones, 600px and up) */
                    @media only screen and (min-width: 600px) {
                    }

                    /* Medium devices (landscape tablets, 768px and up) */
                    @media only screen and (min-width: 768px) {
                    }

                    /* Large devices (laptops/desktops, 992px and up) */
                    @media only screen and (min-width: 992px) {
                    }

                    /* Extra large devices (large laptops and desktops, 1200px and up) */
                    @media only screen and (min-width: 1200px) {
                    }

                    a {
                        color: var(--on-primary-container);
                        text-transform: capitalize;
                        text-decoration: none;
                        font-size: 1.2rem;
                        font-weight: bold;
                        transition: transform 0.9s ease-in-out;
                    }

                
                }
        }
        

    }

    
</style>