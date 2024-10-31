<%@page import="user.UserDTO"%>
<%@page import="Jewelry.JewelryDTO"%>
<%@page import="java.util.List"%>
<%@page import="Jewelry.JewelryDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Shoppers &mdash; Colorlib e-Commerce Template</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mukta:300,400,700"> 
        <link rel="stylesheet" href="fonts/icomoon/style.css">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">


        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/style.css">

    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("home.jsp");
                return;
            }
        %>    
        <%-- searh bar --%>
        <div class="site-wrap">
            <header class="site-navbar" role="banner">
                <div class="site-navbar-top">
                    <div class="container">
                        <div class="row align-items-center">

                            <div class="col-6 col-md-4 order-2 order-md-1 site-search-icon text-left">
                                <form action="MainController" method="POST" class="site-block-top-search">
                                    <span class="icon icon-search2"></span>
                                    <input type="text" name="search" class="form-control border-0" placeholder="Search">
                                    <input type="hidden" name="action" value="Search">
                                </form>
                            </div>

                            <div class="col-12 mb-3 mb-md-0 col-md-4 order-1 order-md-2 text-center">
                                <div class="site-logo">
                                    <a href="home.jsp" class="js-logo-clone">MY Jewelry</a>
                                </div>
                            </div>
                            <%--login-cart-update account information -logout--%>
                            <div class="col-6 col-md-4 order-3 order-md-3 text-right">
                                <form action="MainController" method="POST">
                                    <div class="site-top-icons">
                                        <ul>
                                            <% if (loginUser == null) { %>
                                            <li><a href="login.jsp"><span class="icon icon-person"></span> Login</a></li>
                                            <li><a href="register.jsp"><span class="icon icon-person"></span> Register</a></li>
                                                <% } else { %>
                                            <li><a href="LogoutController"></span>LOG OUT</a></li>
                                            <li><a href="update.jsp"><span class="icon icon-person"></span></a></li>
                                                    <% } %>

                                            <li class="d-inline-block d-md-none ml-md-0"><a href="#" class="site-menu-toggle js-menu-toggle"><span class="icon-menu"></span></a></li>
                                        </ul>
                                    </div> 
                                </form>    
                            </div>

                        </div>
                    </div>
                </div> 
                <nav class="site-navigation text-right text-md-center" role="navigation">
                    <div class="container">
                        <ul class="site-menu js-clone-nav d-none d-md-block">
                            <li><a href="home.jsp">Home</a></li>
                            <% if (loginUser != null && loginUser.getRoleID().equals("US")) { %>
                    <li class="has-children">
                        <a href="shop.jsp">JEWELRY</a>

                        <ul class="dropdown" style="list-style-type: none;">
                            <form action="MainController" method="POST">
                                <li><a href="SearchCategoriesController?category=Bracelet" class="d-flex">Bracelet</a></li>
                                <li><a href="SearchCategoriesController?category=Chain" class="d-flex">Chain</a></li>
                                <li><a href="SearchCategoriesController?category=Earring" class="d-flex">Earring</a></li>
                                <li><a href="SearchCategoriesController?category=Ring" class="d-flex">Ring</a></li>
                                <li><a href="SearchCategoriesController?category=Pendant" class="d-flex">Pendant</a></li>
                                <li><a href="SearchCategoriesController?category=Other" class="d-flex">Other...</a></li>
                            </form>
                        </ul>
                    </li>
                    <li><a href="about.jsp">About</a></li>
                        <%}%>
                                <% if (loginUser != null && loginUser.getRoleID().equals("AD")) { %>
                            <li><a href="createJewelry.jsp">Add new product</a></li>
                            <li><a href="user.jsp">Manage User</a></li>
                            <li><a href="invoice.jsp">Manage Invoice</a></li>
                            <li><a href="Jewelry.jsp">Update Jewelry</a></li>
                             <li><a href="update.jsp">Account</a></li>

                                <%} %>


                        </ul>
                    </div>
                </nav>
            </header>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="admin.jsp">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">Shop Manage</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">

                    <div class="row mb-5">
                        <%--show case--%>    
                        <%
                            JewelryDAO dao = new JewelryDAO();
                            List<JewelryDTO> JewelryList = null;
                            if (request.getAttribute("Jewelry_List") != null) {
                                JewelryList = (List<JewelryDTO>) request.getAttribute("Jewelry_List");
                            } else {
                                JewelryList = dao.getAllJewelry();
                            }
                        %>
                        <div class="col-md-9 order-2">
                            <div class="row">
                                <div class="col-md-12 mb-5">
                                    <div class="float-md-left mb-4"><h2 class="text-black h5">Shop All</h2></div>
                                    <%
                                        String message = (String) request.getAttribute("message");
                                        if (message == null) {
                                            message = "";
                                        }
                                    %>
                                    <div class="d-flex justify-content-center">
                                        <h3 style="color: red;"><%= message%></h3>
                                    </div> 
                                </div>
                            </div>
                            <div class="row mb-5">
                                <% for (JewelryDTO Jewelry : JewelryList) {%>
                                <div class="col-sm-6 col-lg-4 mb-4" data-aos="fade-up">
                                    <div class="block-4 text-center border">
                                        <figure class="block-4-image">
                                            <img src="images/<%= Jewelry.getImage()%>" alt="image placeholder" class="img-fluid">
                                        </figure>
                                        <form action="MainController" method="POST">
                                            <div class="block-4-text p-4">
                                                <p><input type="text" name="JewelryName" value="<%= Jewelry.getJewelryName()%>" /></p>
                                                <p class="mb-3"><input type="text" name="description" value="<%= Jewelry.getDescription()%>" /></p>
                                                <p class="text-primary font-weight-bold"><input type="text" name="Price" value="<%= Jewelry.getPrice()%>" /></p>
                                                <p>Type: <input type="text" name="type" value="<%= Jewelry.getType()%>" /></p>
                                                <input type="hidden" name="image" value="<%= Jewelry.getImage()%>">
                                                <input type="hidden" name="JewelryId" value="<%= Jewelry.getJewelryId()%>">
                                                <button type="submit" name="action" value="Delete" class="btn btn-primary">Delete</button>
                                                <input type="hidden" name="JewelryId" value="<%= Jewelry.getJewelryId()%>">
                                                <button type="submit" name="action" value="UpdateJewelry" class="btn btn-primary">Update</button>

                                            </div>
                                        </form>       
                                    </div>
                                </div>
                                <% }%>
                            </div>
                        </div>

                        <%--Searching bar--%>

                        

                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="site-section site-blocks-2">
                                <div class="row justify-content-center text-center mb-5">
                                    <div class="col-md-7 site-section-heading pt-4">
                                        <h2>Categories</h2>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6 col-md-6 col-lg-4 mb-4 mb-lg-0" data-aos="fade" data-aos-delay="">
                                        <a class="block-2-item" href="#">
                                            <figure class="image">
                                                <img src="images/women.jpg" alt="" class="img-fluid">
                                            </figure>
                                            <div class="text">
                                                <span class="text-uppercase">Collections</span>
                                                <h3>Women</h3>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0" data-aos="fade" data-aos-delay="100">
                                        <a class="block-2-item" href="#">
                                            <figure class="image">
                                                <img src="images/children.jpg" alt="" class="img-fluid">
                                            </figure>
                                            <div class="text">
                                                <span class="text-uppercase">Collections</span>
                                                <h3>Children</h3>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0" data-aos="fade" data-aos-delay="200">
                                        <a class="block-2-item" href="#">
                                            <figure class="image">
                                                <img src="images/men.jpg" alt="" class="img-fluid">
                                            </figure>
                                            <div class="text">
                                                <span class="text-uppercase">Collections</span>
                                                <h3>Men</h3>
                                            </div>
                                        </a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <footer class="site-footer border-top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 mb-5 mb-lg-0">
                            <div class="row">
                                <div class="col-md-12">
                                    <h3 class="footer-heading mb-4">Navigations</h3>
                                </div>
                                <div class="col-md-6 col-lg-4">
                                    <ul class="list-unstyled">
                                        <li><a href="register.jsp">Create new account</a></li>
                                        <li><a href="login.jsp">Login</a></li>
                                        <li><a href="home.jsp">Menu</a></li>

                                    </ul>
                                </div>
                                <div class="col-md-6 col-lg-4">
                                    <ul class="list-unstyled">
                                        <li><a href="shop.jsp">Shop</a></li>

                                        <li><a href="about.jsp">About</a></li>

                                    </ul>
                                </div>

                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">

                        </div>
                        <div class="col-md-6 col-lg-3">
                            <div class="block-5 mb-5">
                                <h3 class="footer-heading mb-4">Contact Info</h3>
                                <ul class="list-unstyled">
                                    <li class="Address">FPT university</li>
                                    <li class="phone"><a href="tel://1234567">+2 392 3929 210</a></li>
                                    <li class="email">SE180481emailAddress@gmail.com</li>
                                </ul>
                            </div>


                        </div>
                    </div>

                </div>
            </footer>
        </div>


        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/aos.js"></script>

        <script src="js/main.js"></script>

    </body>
</html>