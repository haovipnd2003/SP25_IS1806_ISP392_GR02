<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
        <style>
            .main-content {
                margin-left: 250px;
                padding: 20px;
                border-collapse: collapse;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                text-align: left;
                vertical-alignment: middle;
            }

            th {
                background-color: #f8f9fa;
            }

            .section-body {
                font-family: Arial, sans-serif;
                /* max-width: 1000px; */
                /* margin: 40px auto; */
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .description-cell {
                max-width: 100px; /* Adjust as needed */
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                cursor: pointer;
            }
            .description-cell:hover {
                white-space: normal;
                overflow: visible;
            }
        </style>
    </head>
    <body>

        <div id="app">
            <div class="main-wrapper">

                <!-- Sidebar -->
                <!-- MAIN-SIDEBAR-JSP-INCLUDE -->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                    <!-- MAIN-SIDEBAR-JSP-INCLUDE -->

                    <!-- Main Content -->
                    <div class="main-content" style="margin-left: 250px; padding: 20px;">
                        <section class="section">
                            <div class="section-header">
                                <h1>Product List</h1>
                            </div>

                            <a href="products?action=add" class="btn btn-primary">Add Product</a>
                            <!-- Product Table -->
                            <table class="table table-bordered section-body">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Zone ID</th>
                                        <th>Active</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty productList}">
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td class="description-cell" title="${fn:escapeXml(product.describe)}">
                                                    ${fn:escapeXml(product.describe)}
                                                </td>
                                                <td>${product.price}</td>
                                                <td>${product.quantity}</td>
                                                <td>${product.zoneId}</td>
                                                <td>${product.active ? 'Yes' : 'No'}</td>
                                                <td>
                                                    <a href="" class="btn btn-danger">Delete</a>
                                                    <a href="updateProduct.jsp?id=${product.id}" class="btn btn-danger">Update</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr><td colspan="9" class="text-center">No products found.</td></tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>

                        <!-- Required Scripts -->
                        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
                        <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.bundle.min.js"></script>
                </div>
            </div>
        </div>


        <script>
            function deleteProduct(productId) {
                if (confirm('Are you sure you want to delete this product?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/products';

                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'action';
                    input.value = 'delete';

                    const idInput = document.createElement('input');
                    idInput.type = 'hidden';
                    idInput.name = 'id';
                    idInput.value = productId;

                    form.appendChild(input);
                    form.appendChild(idInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            }
        </script>
        <!-- Required Scripts -->
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