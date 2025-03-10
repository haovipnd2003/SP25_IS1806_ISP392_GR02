<%-- 
    Document   : schedule
    Created on : Mar 6, 2025, 9:23:56 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Lịch làm việc</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            .schedule-table {
                width: 100%;
                text-align: center;
            }
            .schedule-header {
                background-color: #f8f9fa;
                font-weight: bold;
            }
            .shift-cell {
                background-color: #e7f1ff;
                border-radius: 10px;
                padding: 5px;
                margin: 2px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h3>Lịch làm việc</h3>
            <div class="d-flex justify-content-between mb-3">
                <input type="text" class="form-control w-25" placeholder="Tìm kiếm nhân viên">
                <div>
                    <button class="btn btn-light">&lt;</button>
                    <span class="mx-2">Tuần 1 - Th.3 2025</span>
                    <button class="btn btn-light">&gt;</button>
                    <button class="btn btn-outline-primary ms-2">Tuần này</button>
                </div>
            </div>

            <table class="table table-bordered schedule-table">
                <thead>
                    <tr class="schedule-header">
                        <th>Nhân viên</th>
                        <th>Thứ 2 <br> 3/3</th>
                        <th>Thứ 3 <br> 4/3</th>
                        <th>Thứ 4 <br> 5/3</th>
                        <th>Thứ 5 <br> 6/3</th>
                        <th>Thứ 6 <br> 7/3</th>
                        <th>Thứ 7 <br> 8/3</th>
                        <th>Chủ nhật <br> 9/3</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Hảo <br> NV000001</td>
                        <td><div class="shift-cell">Ca1</div> <button class="btn btn-sm btn-light">+ Thêm ca</button></td>
                        <td><div class="shift-cell">Ca1</div></td>
                        <td><div class="shift-cell">Ca1</div></td>
                        <td><div class="shift-cell">Ca1</div></td>
                        <td><div class="shift-cell">Ca1</div></td>
                        <td><div class="shift-cell">Ca1</div></td>
                        <td><div class="shift-cell">Ca1</div></td>
                    </tr>
                    <tr>
                        <td>Hảo2 <br> NV000002</td>
                        <td><div class="shift-cell">Ca1</div></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>

    </body>
</html>
