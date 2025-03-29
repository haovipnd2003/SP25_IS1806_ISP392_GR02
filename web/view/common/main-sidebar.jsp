<%-- 
    Document   : main-sidebar
    Created on : 16 thg 2, 2025, 00:43:03
    Author     : binh2
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="main-sidebar">
    <aside id="sidebar-wrapper">

        <ul class="sidebar-menu">

            <li class="menu-header">Menu</li>

            <c:if test="${sessionScope.acc.roletype == 2}">
                <li>
                    <a href="${pageContext.request.contextPath}/manageaccount"><i class="ion ion-person"></i><span>Account Management</span></a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/products"><i class="ion ion-bag"></i><span>Product</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/customer"><i class="ion ion-person-stalker"></i><span>Customer Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-document-text"></i><span>Invoice</span></a>        
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/invoiceStatistic"><i class="ion ion-person-stalker"></i><span>Invoice Statistic</span></a>
                </li>
                
                <li>
                    <a href="${pageContext.request.contextPath}/debtor.do"><i class="ion ion-clipboard"></i><span>Debt Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/shift"><i class="ion ion-briefcase"></i><span>Shift Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/schedule"><i class="ion ion-calendar"></i><span>Schedule Management</span></a>
                </li>
                <li class="menu-dropdown">
                    <a href="#">
                        <i class="ion ion-stats-bars"></i>
                        <span style="margin-left: 8px;">Statistical</span>
                    </a>
                    <ul class="treeview-menu" style="padding-left: 20px; display: none;">
                        <li>
                            <a href="${pageContext.request.contextPath}/revenuestatistics">
                                <i class="ion ion-cash"></i>
                                <span style="margin-left: 8px;">Revenue Statistics</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/purchaseorderstatistics">
                                <i class="ion ion-archive"></i>
                                <span style="margin-left: 8px;">Supplier Invoice Statistics</span>
                            </a>
                        </li>
                    </ul>
                </li>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        document.querySelector(".menu-dropdown > a").addEventListener("click", function (e) {
                            e.preventDefault();
                            let submenu = this.nextElementSibling;
                            submenu.style.display = submenu.style.display === "none" ? "block" : "none";
                        });
                    });
                </script>

            </c:if>
            <c:if test="${sessionScope.acc.roletype == 3}">
                <li>
                    <a href="${pageContext.request.contextPath}/products"><i class="ion ion-bag"></i><span>Product</span></a>
                </li>


                <li>
                    <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-person-stalker"></i><span>Customer Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/schedule"><i class="ion ion-calendar"></i><span>Schedule View</span></a>
                </li>

            </c:if>    

        </ul>
    </aside>
</div>
