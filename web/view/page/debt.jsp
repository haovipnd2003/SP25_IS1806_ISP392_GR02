<%-- 
    Document   : debt
    Created on : Feb 19, 2025, 8:45:42 AM
    Author     : vietanhdang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Components &rsaquo; Toastr &mdash; Stisla</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
        <style>
            button {
                cursor: pointer;
            }
            /* The Modal (background) */
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                padding-top: 100px; /* Location of the box */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            }

            /* Modal Content */
            .modal-content {
                max-width: 800px;
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
            }
            
            .modal-content .row {
                width: 70%;
                margin: 5px 0;
                justify-content: space-between;
            }
            
            .modal-content .row input {
                width: 60%;
            }
            
            .display-flex-center {
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .display-flex-al-center {
                display: flex;
                align-items: center;
            }
            
            .justify-space-between {
                justify-content: space-between;
            }

            /* The Close Button */
            .close {
                color: #aaaaaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            } 
            
            .table-list-content {
                width: 100%;
                margin: 15px 0;
            }
            
            input#negative {
                width: 18px;
                height: 18px;
                filter: hue-rotate(142deg);
                margin-right: 15px
            }
            
            input#positive {
                width: 18px;
                height: 18px;
                filter: hue-rotate(276deg);
            }
        </style>
    </head>

    <body>
        <div id="app">
            <div class="main-wrapper">
                <div class="navbar-bg"></div>
                <nav class="navbar navbar-expand-lg main-navbar">
                    <form class="form-inline mr-auto">
                        <ul class="navbar-nav mr-3">
                            <li><a href="#" data-toggle="sidebar" class="nav-link nav-link-lg"><i class="ion ion-navicon-round"></i></a></li>
                            <li><a href="#" data-toggle="search" class="nav-link nav-link-lg d-sm-none"><i class="ion ion-search"></i></a></li>
                        </ul>

                    </form>
                    <ul class="navbar-nav navbar-right">
                        <li class="dropdown"><a href="#" data-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg">
                                <i class="ion ion-android-person d-lg-none"></i>
                                <div class="d-sm-none d-lg-inline-block">Hi, Ujang Maman</div></a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item has-icon">
                                    <i class="ion ion-android-person"></i> Profile
                                </a>
                                <a href="#" class="dropdown-item has-icon">
                                    <i class="ion ion-log-out"></i> Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>

                <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                <!--MAIN CONTENT-->
                <div class="main-content" style="min-height: 600px;">
                    <section class="section">
                        <div class="section-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h2>Debt</h2>
                                        </div>
                                        <div class="card-body">
                                            <!-- Trigger/Open The Modal -->
                                            <button id="addBtn" onclick="openModal('debtor')">Add new</button>
                                            <table class="table-list-content" border="1" cellpadding="5" cellspacing="5"> 
                                                <tr> 
                                                    <th>ID</th> 
                                                    <th>Name</th> 
                                                    <th>Phone</th> 
                                                    <th>Email</th> 
                                                    <th>Address</th>
                                                    <th>Total debt</th>
                                                    <th style="width: 60px;"></th>
                                                    <th style="width: 132px;"></th>
                                                    <th style="width: 132px;"></th>
                                                </tr> 

                                                <c:forEach var="debtor" items="${debtorList}"> 
                                                    <tr> 
                                                        <td>${debtor.id}</td> 
                                                        <td>${debtor.name}</td> 
                                                        <td>${debtor.phone}</td> 
                                                        <td>${debtor.email}</td> 
                                                        <td>${debtor.address}</td> 
                                                        <td>${debtor.totalDebt}</td>
                                                        <td style="width: 60px;">
                                                            <button onclick="openUpdateDebtorModal('${debtor.id}', '${debtor.name}', '${debtor.phone}', '${debtor.email}', '${debtor.address}', '${debtor.totalDebt}')">
                                                                Update
                                                            </button>
                                                        </td>
                                                        <td style="width: 132px;">
                                                            <button onclick="openModal('debenture', '${debtor.id}')">
                                                                Add a debenture
                                                            </button>
                                                        </td>
                                                        <td style="width: 132px;">
                                                            <a href="debenture.do?debtorId=${debtor.id}">Debenture detail</a>
                                                        </td>
                                                    </tr> 
                                                </c:forEach> 

                                            </table> 
                                            <%--For displaying Previous link except for the 1st page --%> 
                                            <div class="display-flex-al-center" style="justify-content: flex-end;">
                                                <c:if test="${currentPage != 1}"> 
                                                    <td><a href="debt.do?page=${currentPage - 1}">Previous</a></td> 
                                                </c:if> 

                                                <%--For displaying Page numbers. The when condition does not display 
                                                            a link for the current page--%> 

                                                <table style="margin: 0 5px;" border="1" cellpadding="5" cellspacing="5"> 
                                                    <tr> 
                                                        <c:forEach begin="1" end="${noOfPages}" var="i"> 
                                                            <c:choose> 
                                                                <c:when test="${currentPage eq i}"> 
                                                                    <td>${i}</td> 
                                                                </c:when> 
                                                                <c:otherwise> 
                                                                    <td><a href="debt.do?page=${i}">${i}</a></td> 
                                                                </c:otherwise> 
                                                            </c:choose> 
                                                        </c:forEach> 
                                                    </tr> 
                                                </table> 
                                                <%--For displaying Next link --%> 
                                                <c:if test="${currentPage lt noOfPages}"> 
                                                    <td><a href="debt.do?page=${currentPage + 1}">Next</a></td> 
                                                </c:if> 
                                            </div>
                                            <!-- The Modal -->
                                            <div id="debtor" class="modal">
                                                <!-- Modal content -->
                                                <div class="modal-content">
                                                    <div class="display-flex-al-center justify-space-between">
                                                        <h3></h3>
                                                        <div class="close" onclick="closeModal('debtor')">&times;</div>
                                                    </div>
                                                    <form class="form-signin" action="${pageContext.request.contextPath}/debt.do" method="post">
                                                        <input id="id" style="display: none;" name="id" type="text" name="search"/>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Full name (*)</h6>
                                                            <input id="name" name="name" type="text" name="search"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Address</h6>
                                                            <input id="address" name="address" type="text" name="search"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Phone number</h6>
                                                            <input id="phone" name="phone" type="text" name="search"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Email</h6>
                                                            <input id="email" name="email" type="text" name="search"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Total debt</h6>
                                                            <input id="debt" name="debt" type="text" name="search"/>
                                                        </div>
                                                        <button style="width: 80px; margin-top: 5px;" type="submit"></button>
                                                    </form>
                                                </div>
                                            </div>
                                            <div id="debenture" class="modal">
                                                <!-- Modal content -->
                                                <div class="modal-content">
                                                    <div class="display-flex-al-center justify-space-between">
                                                        <h3></h3>
                                                        <div class="close" onclick="closeModal('debenture')">&times;</div>
                                                    </div>
                                                    <form class="form-signin" action="${pageContext.request.contextPath}/debenture.do" method="post">
                                                        <input id="debtor" style="display: none;" name="debtor" type="text" name="search"/>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Note</h6>
                                                            <input name="note" type="text" name="search"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Type (*)</h6>
                                                            <div class="display-flex-al-center" style="width: 60%;">
                                                                <input id="negative" type="radio" name="type" value="0" checked>  <%-- "checked" makes it default --%>
                                                                <input id="positive" type="radio" name="type" value="1">
                                                            </div>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Amount (*)</h6>
                                                            <input name="amount" type="text" name="search"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Created date</h6>
                                                            <input name="created" type="date" name="search"/>
                                                        </div>
                                                        <button style="width: 80px; margin-top: 5px;" type="submit"></button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                     </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
        <script>
            function openModal(name, debtorIdToAddDebenture) {
                $("#" + name +".modal h3").html('Add a ' + name);
                $("#" + name +".modal button").html('Add');
                
                initializeInputValue();
                
                $("#" + name + ".modal").css('display', 'block');
                if (debtorIdToAddDebenture) {
                    $("#debenture.modal input#debtor").val(debtorIdToAddDebenture);
                }
            };
            function closeModal (name) {
                $("#" + name + ".modal").hide();
            };
            function openUpdateDebtorModal(id, name, phone, email, address, totalDebt) {
                $("#debtor.modal h3").html('Update a debtor');
                $("#debtor.modal button").html('Update');
                
                initializeInputValue(id, name, phone, email, address, totalDebt);
                
                $("#debtor.modal").css('display', 'block');
            }
            function initializeInputValue(id, name, phone, email, address, totalDebt) {
                $("#debtor.modal input#id").val(id);
                $("#debtor.modal input#name").val(name);
                $("#debtor.modal input#phone").val(phone);
                $("#debtor.modal input#email").val(email);
                $("#debtor.modal input#address").val(address);
                $("#debtor.modal input#debt").val(totalDebt);
            }
        </script>

        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/popper.js"></script>
        <script src="${pageContext.request.contextPath}/modules/tooltip.js"></script>
        <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/nicescroll/jquery.nicescroll.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/scroll-up-bar/dist/scroll-up-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sa-functions.js"></script>

        <script src="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
        <script src="${pageContext.request.contextPath}/js/demo.js"></script>
    </body>
</html>
