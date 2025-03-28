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
                    <a href="${pageContext.request.contextPath}/debt.do"><i class="ion ion-clipboard"></i><span>Debt Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/shift"><i class="ion ion-briefcase"></i><span>Shift Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/schedule"><i class="ion ion-calendar"></i><span>Schedule Management</span></a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/zoneControl"><i class="ion ion-bag"></i><span>Zone Management</span></a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/statistics"><i class="ion ion-bag"></i><span>Statistics</span></a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/stock-audit"><i class="ion ion-bag"></i><span>Stock Audit</span></a>
                </li>
            </c:if>
            <c:if test="${sessionScope.acc.roletype == 3}">
                <li>
                    <a href="${pageContext.request.contextPath}/products"><i class="ion ion-bag"></i><span>Product</span></a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/zoneControl"><i class="ion ion-bag"></i><span>Zone Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-person-stalker"></i><span>Customer Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/schedule"><i class="ion ion-calendar"></i><span>Schedule View</span></a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/stock-audit"><i class="ion ion-bag"></i><span>Stock Audit</span></a>
                </li>

            </c:if>    

        </ul>
    </aside>
</div>
