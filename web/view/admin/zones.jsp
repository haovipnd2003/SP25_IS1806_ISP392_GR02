<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Zone Management</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
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
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .pagination {
                margin-top: 20px;
            }

            .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
            }

            .page-link {
                color: #007bff;
            }

            .page-link:hover {
                color: #0056b3;
            }
            
            .main-sidebar {
                transition: all 0.3s ease;
            }

            .main-content {
                transition: margin-left 0.3s ease;
            }
            
            .section-header {
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .section-header h1 {
                margin: 0;
                font-size: 24px;
                font-weight: 600;
            }
            
            .search-filter-container {
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            
            .badge {
                padding: 8px 12px;
                font-size: 12px;
                border-radius: 20px;
            }
            
            .bg-success {
                background-color: #28a745 !important;
                color: white;
            }
            
            .bg-danger {
                background-color: #dc3545 !important;
                color: white;
            }
            
            .btn-action-container {
                display: flex;
                gap: 5px;
            }
        </style>
    </head>
    <body>
            <!-- Before update -->
        <div id="app">
            <div class="main-wrapper">

                <!-- Sidebar -->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>

                <!-- Main Content -->
                <div class="main-content" style="margin-left: 250px; padding: 20px;">
                    <button id="sidebarToggle" class="btn btn-secondary mb-3">
                        <i class="fas fa-bars"></i>
                    </button>
                    <section class="section">
                        <div class="section-header">
                            <h1>Zone Management</h1>
                            <c:if test="${roletype == '2'}">
                                <a href="zoneControl?action=add" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add New Zone
                                </a>
                            </c:if>
                        </div>

                        <div class="section-body">
                            <div class="search-filter-container">
                                <div class="row">
                                    <div class="col-md-8">
                                        <form action="zoneControl" method="get" class="d-flex">
                                            <input type="hidden" name="action" value="search">
                                            <input type="text" name="keyword" class="form-control" placeholder="Search by name or ID" value="${keyword}">
                                            <button type="submit" class="btn btn-primary ml-2">
                                                <i class="fas fa-search"></i> Search
                                            </button>
                                        </form>
                                    </div>
                                    <div class="col-md-4">
                                        <form action="zoneControl" method="get" class="d-flex">
                                            <input type="hidden" name="action" value="filter">
                                            <select name="isActive" class="form-control" style="width: auto;">
                                                <option value="default" ${param.isActive == 'default' ? 'selected' : ''}>All Status</option>
                                                <option value="true" ${param.isActive == 'true' ? 'selected' : ''}>Active</option>
                                                <option value="false" ${param.isActive == 'false' ? 'selected' : ''}>Inactive</option>
                                            </select>
                                            <button type="submit" class="btn btn-primary ml-2">
                                                <i class="fas fa-filter"></i> Filter
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th width="10%">ID</th>
                                            <th width="25%">Name</th>
                                            <th width="30%">Description</th>
                                            <th width="10%">Status</th>
                                            <th width="10%">Products</th>
                                            <th width="15%">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="zone" items="${zoneList}">
                                            <tr>
                                                <td>${zone.id}</td>
                                                <td>${zone.name}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty zone.description}">
                                                            <c:out value="${fn:substring(zone.description, 0, 100)}" />
                                                            <c:if test="${fn:length(zone.description) > 100}">...</c:if>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">No description</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span class="badge ${zone.isActive ? 'bg-success' : 'bg-danger'}">
                                                        ${zone.isActive ? 'Active' : 'Inactive'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-info">${zone.productCount} products</span>
                                                </td>
                                                <td>
                                                    <div class="btn-action-container">
                                                        <a href="zoneControl?action=details&id=${zone.id}" class="btn btn-info btn-sm">
                                                            <i class="fas fa-eye"></i> View
                                                        </a>
                                                        <c:if test="${roletype == '2'}">
                                                            <a href="zoneControl?action=edit&id=${zone.id}" class="btn btn-primary btn-sm">
                                                                <i class="fas fa-edit"></i> Edit
                                                            </a>
<!--                                                            <form action="zoneControl" method="post" style="display: inline;" onsubmit="return deleteZone(event)">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="${zone.id}">
                                                                <button type="submit" class="btn btn-danger btn-sm">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </form>-->
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        
                                        <c:if test="${empty zoneList}">
                                            <tr>
                                                <td colspan="6" class="text-center">No zones found</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Debug information -->
<!--                            <div class="alert alert-info">
                                <p>Debug Info:</p>
                                <p>Current Page: ${currentPage}</p>
                                <p>Total Pages: ${totalPages}</p>
                                <p>Total Zones: ${totalZones}</p>
                                <p>Page Size: 10</p>
                            </div>-->

                            <!-- Pagination - Always show, even with just one page -->
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="zoneControl?page=${currentPage - 1}${not empty param.keyword ? '&action=search&keyword='.concat(param.keyword) : ''}${not empty param.isActive && param.isActive != 'default' ? '&action=filter&isActive='.concat(param.isActive) : ''}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages > 0 ? totalPages : 1}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="zoneControl?page=${i}${not empty param.keyword ? '&action=search&keyword='.concat(param.keyword) : ''}${not empty param.isActive && param.isActive != 'default' ? '&action=filter&isActive='.concat(param.isActive) : ''}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="zoneControl?page=${currentPage + 1}${not empty param.keyword ? '&action=search&keyword='.concat(param.keyword) : ''}${not empty param.isActive && param.isActive != 'default' ? '&action=filter&isActive='.concat(param.isActive) : ''}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </section>
                </div>
            </div>
        </div>

        <script>
            // Toggle sidebar
            document.getElementById('sidebarToggle').addEventListener('click', function () {
                const sidebar = document.querySelector('.main-sidebar');
                const mainContent = document.querySelector('.main-content');

                if (sidebar.style.display === 'none') {
                    sidebar.style.display = 'block';
                    mainContent.style.marginLeft = '250px';
                } else {
                    sidebar.style.display = 'none';
                    mainContent.style.marginLeft = '0';
                }
            });
        </script>

        <script>
            function deleteZone(event) {
                event.preventDefault(); // Prevent the form from submitting immediately
                
                // Thay thế confirm bằng iziToast với confirm option
                iziToast.question({
                    timeout: 20000,
                    close: false,
                    overlay: true,
                    displayMode: 'once',
                    id: 'question',
                    zindex: 999,
                    title: 'Confirmation',
                    message: 'Are you sure you want to delete this zone?',
                    position: 'center',
                    buttons: [
                        ['<button><b>YES</b></button>', function (instance, toast) {
                            instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                            event.target.submit(); // Submit the form if user confirms
                        }, true],
                        ['<button>NO</button>', function (instance, toast) {
                            instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                        }, false],
                    ]
                });
                return false; // Prevent form submission if user cancels
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var toastMessage = "${sessionScope.toastMessage}";
                var toastType = "${sessionScope.toastType}";
                if (toastMessage) {
                    iziToast.show({
                        title: toastType === 'success' ? 'Success' : 'Error',
                        message: toastMessage,
                        position: 'topRight',
                        color: toastType === 'success' ? 'green' : 'red',
                        timeout: 5000
                    });
                    
                    // Clear toast messages from session immediately after showing
                    <% 
                        session.removeAttribute("toastMessage");
                        session.removeAttribute("toastType");
                    %>
                }
            });
        </script>
    </body>
</html>