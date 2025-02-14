<%-- 
    Document   : homepage
    Created on : 9 thg 2, 2025, 10:03:34
    Author     : binh2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">


<!-- Mirrored from htmldemo.net/koparion/koparion/index-4.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 23 Feb 2024 17:29:52 GMT -->
<head>
	<meta charset="utf-8">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title>Koparion – Book Shop HTML5 Template</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Favicon -->
	<link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">

	<!-- all css here -->
	<!-- bootstrap v3.3.6 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
	<!-- animate css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
	<!-- meanmenu css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/meanmenu.min.css">
	<!-- owl.carousel css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.css">
	<!-- font-awesome css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<!-- flexslider.css-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/flexslider.css">
	<!-- chosen.min.css-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/chosen.min.css">
	<!-- style css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_1.css">
	<!-- responsive css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
	<!-- modernizr css -->
	<script src="${pageContext.request.contextPath}/js/vendor/modernizr-2.8.3.min.js"></script>
</head>

<body class="home-4">
	<!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->

	<!-- Add your site or application content here -->
	<!-- header-area-start -->
	<header>
		<!-- header-top-area-start -->
		<div class="header-top-area">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-6 col-12">
						<div class="language-area">
							<ul>
								<li><img src="img/flag/1.jpg" alt="flag" /><a href="#">English<i class="fa fa-angle-down"></i></a>
									<div class="header-sub">
										<ul>
											<li><a href="#"><img src="img/flag/2.jpg" alt="flag" />france</a></li>
											<li><a href="#"><img src="img/flag/3.jpg" alt="flag" />croatia</a></li>
										</ul>
									</div>
								</li>
								<li><a href="#">USD $<i class="fa fa-angle-down"></i></a>
									<div class="header-sub dolor">
										<ul>
											<li><a href="#">EUR €</a></li>
											<li><a href="#">USD $</a></li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<div class="col-lg-6 col-md-6 col-12">
						<div class="account-area text-end">
							<ul>
								<li><a href="my-account.html">My Account</a></li>
								<li><a href="checkout.html">Checkout</a></li>
								<li><a href="login.html">Sign in</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- header-top-area-end -->
		<!-- header-mid-area-start -->
		<div class="header-mid-area ptb-40">
			<div class="container">
				<div class="row">
					<div class="col-lg-3 col-md-4 col-12">
						<div class="logo-area">
							<a href="index.html"><img src="img/logo/3.png" alt="logo" /></a>
						</div>
					</div>
					<div class="col-lg-6 col-md-5 col-12">
						<div class="header-search">
							<form action="#">
								<input type="text" placeholder="Search entire store here..." />
								<a href="#"><i class="fa fa-search"></i></a>
							</form>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-12">
						<div class="my-cart">
							<ul>
								<li><a href="#"><i class="fa fa-shopping-cart"></i>My Cart</a>
									<span>2</span>
									<div class="mini-cart-sub">
										<div class="cart-product">
											<div class="single-cart">
												<div class="cart-img">
													<a href="#"><img src="img/product/1.jpg" alt="book" /></a>
												</div>
												<div class="cart-info">
													<h5><a href="#">Joust Duffle Bag</a></h5>
													<p>1 x £60.00</p>
												</div>
												<div class="cart-icon">
													<a href="#"><i class="fa fa-remove"></i></a>
												</div>
											</div>
											<div class="single-cart">
												<div class="cart-img">
													<a href="#"><img src="img/product/3.jpg" alt="book" /></a>
												</div>
												<div class="cart-info">
													<h5><a href="#">Chaz Kangeroo Hoodie</a></h5>
													<p>1 x £52.00</p>
												</div>
												<div class="cart-icon">
													<a href="#"><i class="fa fa-remove"></i></a>
												</div>
											</div>
										</div>
										<div class="cart-totals">
											<h5>Total <span>£12.00</span></h5>
										</div>
										<div class="cart-bottom">
											<a class="view-cart" href="cart.html">view cart</a>
											<a href="checkout.html">Check out</a>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- header-mid-area-end -->
		<!-- main-menu-area-start -->
		<div class="main-menu-area d-md-none d-none d-lg-block" id="header-sticky">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="menu-area">
							<nav>
								<ul>
									<li class="active"><a href="index.html">Home<i class="fa fa-angle-down"></i></a>
										<div class="sub-menu">
											<ul>
												<li><a href="index.html">Home-1</a></li>
												<li><a href="index-2.html">Home-2</a></li>
												<li><a href="index-3.html">Home-3</a></li>
												<li><a href="index-4.html">Home-4</a></li>
												<li><a href="index-5.html">Home-5</a></li>
												<li><a href="index-6.html">Home-6</a></li>
												<li><a href="index-7.html">Home-7</a></li>
											</ul>
										</div>
									</li>
									<li><a href="product-details.html">Book<i class="fa fa-angle-down"></i></a>
										<div class="mega-menu">
											<span>
												<a href="#" class="title">Jackets</a>
												<a href="shop.html">Tops & Tees</a>
												<a href="shop.html">Polo Short Sleeve</a>
												<a href="shop.html">Graphic T-Shirts</a>
												<a href="shop.html">Jackets & Coats</a>
												<a href="shop.html">Fashion Jackets</a>
											</span>
											<span>
												<a href="#" class="title">weaters</a>
												<a href="shop.html">Crochet</a>
												<a href="shop.html">Sleeveless</a>
												<a href="shop.html">Stripes</a>
												<a href="shop.html">Sweaters</a>
												<a href="shop.html">hoodies</a>
											</span>
											<span>
												<a href="#" class="title">Bottoms</a>
												<a href="shop.html">Heeled sandals</a>
												<a href="shop.html">Polo Short Sleeve</a>
												<a href="shop.html">Flat sandals</a>
												<a href="shop.html">Short Sleeve</a>
												<a href="shop.html">Long Sleeve</a>
											</span>
											<span>
												<a href="#" class="title">Jeans Pants</a>
												<a href="shop.html">Polo Short Sleeve</a>
												<a href="shop.html">Sleeveless</a>
												<a href="shop.html">Graphic T-Shirts</a>
												<a href="shop.html">Hoodies</a>
												<a href="shop.html">Jackets</a>
											</span>
										</div>
									</li>
									<li><a href="shop.html">Enable Cookies</a></li>
									<li><a href="product-details-2.html">pages<i class="fa fa-angle-down"></i></a>
										<div class="sub-menu sub-menu-2">
											<ul>
												<li><a href="shop.html">shop</a></li>
												<li><a href="shop-list.html">shop list view</a></li>
												<li><a href="product-details.html">product-details</a></li>
												<li><a href="product-details-affiliate.html">product-affiliate</a></li>
												<li><a href="blog.html">blog</a></li>
												<li><a href="blog-details.html">blog-details</a></li>
												<li><a href="contact.html">contact</a></li>
												<li><a href="about.html">about</a></li>
												<li><a href="login.html">login</a></li>
												<li><a href="register.html">register</a></li>
												<li><a href="my-account.html">my-account</a></li>
												<li><a href="cart.html">cart</a></li>
												<li><a href="compare.html">compare</a></li>
												<li><a href="checkout.html">checkout</a></li>
												<li><a href="wishlist.html">wishlist</a></li>
												<li><a href="404.html">404 Page</a></li>
											</ul>
										</div>
									</li>
									<li><a href="contact.html">contact us</a></li>
									<li><a href="#">blog<i class="fa fa-angle-down"></i></a>
										<div class="sub-menu">
											<ul>
												<li><a href="blog.html">blog</a></li>
												<li><a href="blog-details.html">blog-details</a></li>
											</ul>
										</div>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- main-menu-area-end -->
		<!-- mobile-menu-area-start -->
		<div class="mobile-menu-area d-lg-none d-block fix">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="mobile-menu">
							<nav id="mobile-menu-active">
								<ul id="nav">
									<li><a href="index.html">Home</a>
										<ul>
											<li><a href="index.html">Home-1</a></li>
											<li><a href="index-2.html">Home-2</a></li>
											<li><a href="index-3.html">Home-3</a></li>
											<li><a href="index-4.html">Home-4</a></li>
											<li><a href="index-5.html">Home-5</a></li>
											<li><a href="index-6.html">Home-6</a></li>
											<li><a href="index-7.html">Home-7</a></li>
										</ul>
									</li>
									<li><a href="shop.html">Enable Cookies</a></li>
									<li><a href="product-details.html">Pages</a>
										<ul>
											<li><a href="shop.html">shop</a></li>
											<li><a href="shop-list.html">shop list view</a></li>
											<li><a href="product-details.html">product-details</a></li>
											<li><a href="product-details-affiliate.html">product-affiliate</a></li>
											<li><a href="blog.html">blog</a></li>
											<li><a href="blog-details.html">blog-details</a></li>
											<li><a href="contact.html">contact</a></li>
											<li><a href="about.html">about</a></li>
											<li><a href="login.html">login</a></li>
											<li><a href="register.html">register</a></li>
											<li><a href="my-account.html">my-account</a></li>
											<li><a href="cart.html">cart</a></li>
											<li><a href="compare.html">compare</a></li>
											<li><a href="checkout.html">checkout</a></li>
											<li><a href="wishlist.html">wishlist</a></li>
											<li><a href="404.html">404 Page</a></li>
										</ul>
									</li>
									<li><a href="contact.html">contact us</a></li>
									<li><a href="#">blog</a>
										<ul>
											<li><a href="blog.html">Blog</a></li>
											<li><a href="blog-details.html">blog-details</a></li>
										</ul>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- mobile-menu-area-end -->
	</header>
	<!-- header-area-end -->
	
	<!-- home-main-area-start -->
	<div class="home-main-area mt-30">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-4 col-12">
					<!-- category-area-start -->
					<div class="category-area mb-30">
						<h3><a href="#">Category Menu <i class="fa fa-bars"></i></a></h3>
						<div class="category-menu">
							<nav class="menu">
								<ul>
									<li class="cr-dropdown"><a href="#">Book<i class="none-lg fa fa-angle-down"></i><i class="none-sm fa fa-angle-right"></i></a>
										<div class="left-menu">
											<span class="mb-30">
												<a href="#" class="title">Jackets</a>
												<a href="#">Tops & Tees</a>
												<a href="#">Polo Short Sleeve</a>
												<a href="#">Graphic T-Shirts</a>
												<a href="#">Jackets & Coats</a>
												<a href="#">Fashion Jackets</a>
											</span>
											<span class="mb-30">
												<a href="#" class="title">Bottoms</a>
												<a href="#">Heeled sandals</a>
												<a href="#">Polo Short Sleeve</a>
												<a href="#">Flat sandals</a>
												<a href="#">Short Sleeve</a>
												<a href="#">Long Sleeve</a>
											</span>
											<span>
												<a href="#" class="title">weaters</a>
												<a href="#">Crochet</a>
												<a href="#">Sleeveless</a>
												<a href="#">Stripes</a>
												<a href="#">Sweaters</a>
												<a href="#">hoodies</a>
											</span>
											<span>
												<a href="#" class="title">Jeans Pants</a>
												<a href="#">Polo Short Sleeve </a>
												<a href="#">Sleeveless</a>
												<a href="#">Graphic T-Shirts</a>
												<a href="#">Hoodies</a>
												<a href="#">Jackets</a>
											</span>
										</div>
										<ul>
											<li class="cr-sub-dropdown sub-style"><a href="#">Jackets <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop-grid-2-col.html">Tops & Tees</a></li>
													<li><a href="shop-grid-3-col.html">Polo Short Sleeve</a></li>
													<li><a href="shop.html">Graphic T-Shirts</a></li>
													<li><a href="shop-grid-6-col.html">Jackets & Coats</a></li>
													<li><a href="shop-grid-box.html">Fashion Jackets</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">Bottoms <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop-list.html">Heeled sandals</a></li>
													<li><a href="shop-list.html">Polo Short Sleeve</a></li>
													<li><a href="shop-list-2-col.html">Flat sandals</a></li>
													<li><a href="shop-list-3-col.html">Short Sleeve</a></li>
													<li><a href="shop-list-box.html">Long Sleeve</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">weaters <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="product-details.html">Sleeveless</a></li>
													<li><a href="product-details-sticky.html">Stripes</a></li>
													<li><a href="product-details-gallery.html">Sweaters</a></li>
													<li><a href="product-details-fixed-img.html">hoodies</a></li>
													<li><a href="product-details-fixed-img.html">Crochet</a></li>
													<li><a href="product-details-fixed-img.html">weaters</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">Jeans Pants <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop.html">Sleeveless</a></li>
													<li><a href="shop.html">Graphic T-Shirts</a></li>
													<li><a href="shop.html">Hoodies</a></li>
													<li><a href="shop.html">Jackets</a></li>
													<li><a href="shop.html">Polo Short Sleeve</a></li>
													<li><a href="shop.html">Jeans Pants</a></li>
												</ul>
											</li>
										</ul>
									</li>
									<li class="cr-dropdown"><a href="#">Audio books<i class="none-lg fa fa-angle-down"></i><i class="none-sm fa fa-angle-right"></i></a>
										<div class="left-menu">
											<span class="mb-30">
												<a href="#" class="title">Shirts</a>
												<a href="#">Tops & Tees</a>
												<a href="#">Sweaters</a>
												<a href="#">Hoodies</a>
												<a href="#">Jackets & Coats</a>
											</span>
											<span class="mb-30">
												<a href="#" class="title">Jackets</a>
												<a href="#">Sweaters</a>
												<a href="#">Hoodies</a>
												<a href="#">Wedges</a>
												<a href="#">Vests</a>
											</span>
											<span>
												<a href="#" class="title">Tops & Tees</a>
												<a href="#">Long Sleeve </a>
												<a href="#">Short Sleeve</a>
												<a href="#">Polo Short Sleeve</a>
												<a href="#">Sleeveless</a>
											</span>
											<span>
												<a href="#" class="title">Jeans pants</a>
												<a href="#">Polo Short Sleeve</a>
												<a href="#">Sleeveless</a>
												<a href="#">Graphic T-Shirts</a>
												<a href="#">Hoodies</a>
											</span>
										</div>
										<ul>
											<li class="cr-sub-dropdown sub-style"><a href="#">Jackets <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop-grid-2-col.html">Tops & Tees</a></li>
													<li><a href="shop-grid-3-col.html">Polo Short Sleeve</a></li>
													<li><a href="shop.html">Graphic T-Shirts</a></li>
													<li><a href="shop-grid-6-col.html">Jackets & Coats</a></li>
													<li><a href="shop-grid-box.html">Fashion Jackets</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">Bottoms <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop-list.html">Heeled sandals</a></li>
													<li><a href="shop-list.html">Polo Short Sleeve</a></li>
													<li><a href="shop-list-2-col.html">Flat sandals</a></li>
													<li><a href="shop-list-3-col.html">Short Sleeve</a></li>
													<li><a href="shop-list-box.html">Long Sleeve</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">weaters <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="product-details.html">Sleeveless</a></li>
													<li><a href="product-details-sticky.html">Stripes</a></li>
													<li><a href="product-details-gallery.html">Sweaters</a></li>
													<li><a href="product-details-fixed-img.html">hoodies</a></li>
													<li><a href="product-details-fixed-img.html">Crochet</a></li>
													<li><a href="product-details-fixed-img.html">weaters</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">Jeans Pants <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop.html">Sleeveless</a></li>
													<li><a href="shop.html">Graphic T-Shirts</a></li>
													<li><a href="shop.html">Hoodies</a></li>
													<li><a href="shop.html">Jackets</a></li>
													<li><a href="shop.html">Polo Short Sleeve</a></li>
													<li><a href="shop.html">Jeans Pants</a></li>
												</ul>
											</li>
										</ul>
									</li>
									<li class="cr-dropdown"><a href="#">children’s books<i class="none-lg fa fa-angle-down"></i><i class="none-sm fa fa-angle-right"></i></a>
										<div class="left-menu">
											<span class="mb-30">
												<a href="#" class="title">Tops</a>
												<a href="#">Shirts</a>
												<a href="#">Florals</a>
												<a href="#">Crochet</a>
												<a href="#">Stripes</a>
											</span>
											<span class="mb-30">
												<a href="#" class="title">Bottoms</a>
												<a href="#">Shoes</a>
												<a href="#">Heeled sandals</a>
												<a href="#">Flat sandals</a>
												<a href="#">Wedges</a>
											</span>
											<span>
												<a href="#" class="title">Shorts</a>
												<a href="#">Dresses</a>
												<a href="#">Trousers</a>
												<a href="#">Jeans</a>
											</span>
										</div>
										<ul>
											<li class="cr-sub-dropdown sub-style"><a href="#">Jackets <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop-grid-2-col.html">Tops & Tees</a></li>
													<li><a href="shop-grid-3-col.html">Polo Short Sleeve</a></li>
													<li><a href="shop.html">Graphic T-Shirts</a></li>
													<li><a href="shop-grid-6-col.html">Jackets & Coats</a></li>
													<li><a href="shop-grid-box.html">Fashion Jackets</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">Bottoms <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop-list.html">Heeled sandals</a></li>
													<li><a href="shop-list.html">Polo Short Sleeve</a></li>
													<li><a href="shop-list-2-col.html">Flat sandals</a></li>
													<li><a href="shop-list-3-col.html">Short Sleeve</a></li>
													<li><a href="shop-list-box.html">Long Sleeve</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">weaters <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="product-details.html">Sleeveless</a></li>
													<li><a href="product-details-sticky.html">Stripes</a></li>
													<li><a href="product-details-gallery.html">Sweaters</a></li>
													<li><a href="product-details-fixed-img.html">hoodies</a></li>
													<li><a href="product-details-fixed-img.html">Crochet</a></li>
													<li><a href="product-details-fixed-img.html">weaters</a></li>
												</ul>
											</li>
										</ul>
									</li>
									<li class="cr-dropdown"><a href="#">bussiness & money<i class="none-lg fa fa-angle-down"></i><i class="none-sm fa fa-angle-right"></i></a>
										<div class="left-menu">
											<span>
												<a href="#" class="title">Rings</a>
												<a href="#">Coats & Jackets</a>
												<a href="#">Blazers</a>
												<a href="#">Jackets</a>
												<a href="#">Raincoats</a>
												<a href="#">Trousers</a>
											</span>
											<span>
												<a href="#" class="title">Trousers</a>
												<a href="#">Joggers</a>
												<a href="#">Casual</a>
												<a href="#">Chinos</a>
												<a href="#">Tailored</a>
												<a href="#">Jeans</a>
											</span>
										</div>
										<ul>
											<li class="cr-sub-dropdown sub-style"><a href="#">Jackets <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop-grid-2-col.html">Tops & Tees</a></li>
													<li><a href="shop-grid-3-col.html">Polo Short Sleeve</a></li>
													<li><a href="shop.html">Graphic T-Shirts</a></li>
													<li><a href="shop-grid-6-col.html">Jackets & Coats</a></li>
													<li><a href="shop-grid-box.html">Fashion Jackets</a></li>
												</ul>
											</li>
											<li class="cr-sub-dropdown sub-style"><a href="#">Bottoms <i class="fa fa-angle-down"></i></a>
												<ul>
													<li><a href="shop-list.html">Heeled sandals</a></li>
													<li><a href="shop-list.html">Polo Short Sleeve</a></li>
													<li><a href="shop-list-2-col.html">Flat sandals</a></li>
													<li><a href="shop-list-3-col.html">Short Sleeve</a></li>
													<li><a href="shop-list-box.html">Long Sleeve</a></li>
												</ul>
											</li>
										</ul>
									</li>
									<li><a href="#">usedbooks</a></li>
									<li><a href="#">sales off</a></li>
									<li><a href="#">Biographies</a></li>
									<li><a href="#">Cookbooks</a></li>
									<li><a href="#">Education</a></li>
									<li><a href="#">Engineering</a></li>
									<li class="rx-child"><a href="shop.html">Health, Fitness</a></li>
									<li class="rx-parent">
										<a class="rx-default">
											<span class="cat-thumb fa fa-plus"></span>
											More categories
										</a>
										<a class="rx-show">
											<span class="cat-thumb fa fa-minus"></span>
											close menu
										</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
					<!-- category-area-end -->
					<!-- banner-area-start -->
					
					<!-- banner-area-end -->
					<!-- most-product-area-start -->
					
					<!-- most-product-area-end -->
					<!-- recent-post-area-start -->
					
					<!-- recent-post-area-end -->
					<!-- block-newsletter-area-start -->
					
					<!-- block-newsletter-area-end -->
				</div>
				
			</div>
		</div>
	</div>
	<!-- home-main-area-end -->
	<!-- banner-area-start -->
	
	<!-- banner-area-end -->
	<!-- social-group-area-start -->
	
	<!-- social-group-area-end -->
	<!-- footer-area-start -->
	<footer>
		<!-- footer-top-start -->
		<div class="footer-top">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="footer-top-menu bb-2">
							<nav>
								<ul>
									<li><a href="#">home</a></li>
									<li><a href="#">Enable Cookies</a></li>
									<li><a href="#">Privacy and Cookie Policy</a></li>
									<li><a href="#">contact us</a></li>
									<li><a href="#">blog</a></li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- footer-top-start -->
		<!-- footer-mid-start -->
		<div class="footer-mid ptb-50">
			<div class="container">
				<div class="row">
					<div class="col-lg-8 col-12">
						<div class="row">
							<div class="col-lg-4 col-md-4 col-12">
								<div class="single-footer br-2 xs-mb">
									<div class="footer-title mb-20">
										<h3>Products</h3>
									</div>
									<div class="footer-mid-menu">
										<ul>
											<li><a href="about.html">About us</a></li>
											<li><a href="#">Prices drop </a></li>
											<li><a href="#">New products</a></li>
											<li><a href="#">Best sales</a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-12">
								<div class="single-footer br-2 xs-mb">
									<div class="footer-title mb-20">
										<h3>Our company</h3>
									</div>
									<div class="footer-mid-menu">
										<ul>
											<li><a href="contact.html">Contact us</a></li>
											<li><a href="#">Sitemap</a></li>
											<li><a href="#">Stores</a></li>
											<li><a href="register.html">My account </a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-12">
								<div class="single-footer br-2 xs-mb">
									<div class="footer-title mb-20">
										<h3>Your account</h3>
									</div>
									<div class="footer-mid-menu">
										<ul>
											<li><a href="contact.html">Addresses</a></li>
											<li><a href="#">Credit slips </a></li>
											<li><a href="#"> Orders</a></li>
											<li><a href="#">Personal info</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-12">
						<div class="single-footer mrg-sm">
							<div class="footer-title mb-20">
								<h3>STORE INFORMATION</h3>
							</div>
							<div class="footer-contact">
								<p class="adress">
									<span>My Company</span>
									Your address goes here.
								</p>
								<p><span>Call us now:</span> 0123456789</p>
								<p><span>Email:</span> demo@example.com</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- footer-mid-end -->
		<!-- footer-bottom-start -->
		<div class="footer-bottom">
			<div class="container">
				<div class="row bt-2">
					<div class="col-lg-6 col-md-6 col-12">
						<div class="copy-right-area">
							<p>&copy; 2022 <strong> Koparion </strong> Mede with ❤️ by <a href="https://hasthemes.com/" target="_blank"><strong>HasThemes</strong></a></p>
						</div>
					</div>
					<div class="col-lg-6 col-md-6 col-12">
						<div class="payment-img text-end">
							<a href="#"><img src="img/1.png" alt="payment" /></a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- footer-bottom-end -->
	</footer>
	<!-- footer-area-end -->
	<!-- Modal -->
	<div class="modal fade" id="productModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-12">
							<div class="modal-tab">
								<div class="product-details-large tab-content">
									<div class="tab-pane active" id="image-1">
										<img src="img/product/quickview-l4.jpg" alt="" />
									</div>
									<div class="tab-pane" id="image-2">
										<img src="img/product/quickview-l2.jpg" alt="" />
									</div>
									<div class="tab-pane" id="image-3">
										<img src="img/product/quickview-l3.jpg" alt="" />
									</div>
									<div class="tab-pane" id="image-4">
										<img src="img/product/quickview-l5.jpg" alt="" />
									</div>
								</div>
								<div class="product-details-small quickview-active owl-carousel">
									<a class="active" href="#image-1"><img src="img/product/quickview-s4.jpg" alt="" /></a>
									<a href="#image-2"><img src="img/product/quickview-s2.jpg" alt="" /></a>
									<a href="#image-3"><img src="img/product/quickview-s3.jpg" alt="" /></a>
									<a href="#image-4"><img src="img/product/quickview-s5.jpg" alt="" /></a>
								</div>
							</div>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<div class="modal-pro-content">
								<h3>Chaz Kangeroo Hoodie3</h3>
								<div class="price">
									<span>$70.00</span>
								</div>
								<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet.</p>
								<div class="quick-view-select">
									<div class="select-option-part">
										<label>Size*</label>
										<select class="select">
											<option value="">S</option>
											<option value="">M</option>
											<option value="">L</option>
										</select>
									</div>
									<div class="quickview-color-wrap">
										<label>Color*</label>
										<div class="quickview-color">
											<ul>
												<li class="blue">b</li>
												<li class="red">r</li>
												<li class="pink">p</li>
											</ul>
										</div>
									</div>
								</div>
								<form action="#">
									<input type="number" value="1" />
									<button>Add to cart</button>
								</form>
								<span><i class="fa fa-check"></i> In stock</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal end -->


	<!-- all js here -->
	<!-- jquery latest version -->
	<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.12.4.min.js"></script>
	
	
	<!-- bootstrap js -->
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<!-- owl.carousel js -->
	<script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
	<!-- meanmenu js -->
	<script src="${pageContext.request.contextPath}/js/jquery.meanmenu.js"></script>
	<!-- wow js -->
	<script src="${pageContext.request.contextPath}/js/wow.min.js"></script>
	<!-- jquery.parallax-1.1.3.js -->
	<script src="${pageContext.request.contextPath}/js/jquery.parallax-1.1.3.js"></script>
	<!-- jquery.countdown.min.js -->
	<script src="${pageContext.request.contextPath}/js/jquery.countdown.min.js"></script>
	<!-- jquery.flexslider.js -->
	<script src="${pageContext.request.contextPath}/js/jquery.flexslider.js"></script>
	<!-- chosen.jquery.min.js -->
	<script src="${pageContext.request.contextPath}/js/chosen.jquery.min.js"></script>
	<!-- jquery.counterup.min.js -->
	<script src="${pageContext.request.contextPath}/js/jquery.counterup.min.js"></script>
	<!-- waypoints.min.js -->
	<script src="${pageContext.request.contextPath}/js/waypoints.min.js"></script>
	<!-- plugins js -->
	<script src="${pageContext.request.contextPath}/js/plugins.js"></script>
	<!-- main js -->
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>


<!-- Mirrored from htmldemo.net/koparion/koparion/index-4.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 23 Feb 2024 17:30:26 GMT -->
</html>