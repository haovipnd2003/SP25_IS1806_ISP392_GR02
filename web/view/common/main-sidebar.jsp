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
            <li>
                <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Product</span></a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Sale</span></a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Customer Management</span></a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Invoice</span></a>        
            </li>

            <c:if test="${sessionScope.acc.roletype == 1}">
                <li>
                    <a href="${pageContext.request.contextPath}/debt.do"><i class="ion ion-clipboard"></i><span>Debt Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Invoice</span></a>        
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Account Management</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Staff Management</span></a>
                </li>
            </c:if>
            <c:if test="${sessionScope.acc.roletype == 2}">

                <li>
                    <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Debt</span></a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Staff Management</span></a>
                </li>
            </c:if>



        </ul>
    </aside>
</div>
