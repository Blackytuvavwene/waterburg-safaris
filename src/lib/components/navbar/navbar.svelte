<nav>
    <div class="logo">
Logo
    </div>
    <button class="menu">&#9776;</button>
    <ul class="nav-links">
        <li><a href="">Home</a></li>
        <li><a href="">About</a></li>
        <li><a href="">Contact</a></li>
        <li><a href="">Login</a></li>
    </ul>
</nav>

<style lang="scss">
    nav {
        background: white;
        display: flex;
        flex-direction: row;
        .logo {
            height: 30px;
            width: 30px;
            background: var(--logoGreen);
            border-radius: 50%;
            margin:10px auto;
        }

        .nav-links {
            display: flex;
            justify-content: space-between;
            width: 100%;
            padding: 0 1rem;

            

            li {
                list-style: none;
                margin: 0.5rem;
                text-align: center;

                a {
                    color: var(--mainWhite);
                    text-transform: capitalize;
                    text-decoration: none;
                }

                a:hover {
                    color: var(--mainGreen);
                }
    
            }
        }

        @media (max-width: 576px) {
            .nav-links {
                display: none;
            }
        }

    }

    
</style>