<%-- 
    Document   : sale
    Created on : 16 thg 2, 2025, 00:34:41
    Author     : binh2
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>

    <body>
            
                <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>
                <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                    <!--MAIN-SIDEBAR-JSP-INCLUDE-->


                    <!--                MAIN CONTENT-->
                    <div class="main-content" style="min-height: 600px;">
                        <section class="section">


                            <div class="section-body">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h2>Sale</h2>
                                            </div>
                                            <div class="card-body">
                                                <form action="${pageContext.request.contextPath}/sale" method="POST">
                                                    <table border="0">
                                                        <tbody>
                                                            <tr>
                                                                <td>Search:</td>
                                                                <td><t></t><input type="text" name="search" value="" placeholder="name or phone"/></td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </form>
                                                    
                                              

                                                <form>
                                                    <tbody id="content">
                                                        
                                                    </tbody>
                                                </form>
                                                <button onclick="loadMore">Load more</button>
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
                                                    function loadMore() {
                                                        $.ajax({
                                                            url: "/RiceManagement/loadCus",
                                                            type: "get",
                                                            success: function (data) {
                                                                var row = document.getElementById("content");
                                                                row.innerHTML += data;
                                                            },
                                                        });
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

