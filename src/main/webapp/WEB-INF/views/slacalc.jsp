<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AdminLTE 3 | Advanced form elements</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
    <!-- daterange picker -->
    <link rel="stylesheet" href="/resources/plugins/daterangepicker/daterangepicker.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="/resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <!-- Navbar -->
    <%--    <nav class="main-header navbar navbar-expand navbar-white navbar-light">--%>
    <!-- Left navbar links -->
    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4" style="width:200px">
        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Sidebar user (optional) -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="info">
                    <a href="#" class="d-block">ASMS QTip</a>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                    <!-- Add icons to the links using the .nav-icon class
                         with font-awesome or any other icon font library -->
                    <li class="nav-item">
                        <a href="/" class="nav-link">
                            <i class="nav-icon fas fa-tachometer-alt"></i>
                            <p>
                                Get Usage
                            </p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="slacalc" class="nav-link">
                            <i class="nav-icon fas fa-th"></i>
                            <p>
                                SLA Calculator
                            </p>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="margin-left:205px">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>SLA Calculator</h1>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
                <!-- SELECT2 EXAMPLE -->
                    <!-- /.card-header -->
            <div class="row">
                    <div class="col-md-4">
                        <div class="card card-primary">
                            <div class="card-body">
                                <!-- Date -->
                                <div class="form-group">
                                    <label>ISSUE START DATE:</label>
                                    <div class="input-group date" id="issue_start" data-target-input="nearest">
                                        <input type="text" id="issue_start_txt" class="form-control datetimepicker-input" data-target="#issue_start"/>
                                        <div class="input-group-append" data-target="#issue_start" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Date and time -->
                                <div class="form-group">
                                    <label>ISSUE END DATE:</label>
                                    <div class="input-group date" id="issue_end" data-target-input="nearest">
                                        <input type="text" id="issue_end_txt" class="form-control datetimepicker-input" data-target="#issue_end"/>
                                        <div class="input-group-append" data-target="#issue_end" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <button type="button" class="btn btn-block btn-outline-primary" id="range_calc">
                                        Calculate
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="card card-primary">
                            <div class = "card-header">
                                <h3 class = "card-title">Uptime Percentage</h3>
                            </div>
                            <div class = "card-body">
                                <dl class = "row">
                                    <dt class="col-sm-6" style="font-size:15px">Down Time (Min)</dt>
                                    <dd class="col-sm-6" id="downtime"></dd>
                                    <dt class="col-sm-6"style="font-size:15px">Available Minutes</dt>
                                    <dd class="col-sm-6" id="availtime"></dd>
                                    <dt class="col-sm-6"style="font-size:15px">Uptime Minutes<br>
                                        <div style="color:gray; font-size:12px">
                                        (Available Time - Down Time)
                                        </div></dt>
                                    <dd class="col-sm-6" id="uptime"></dd>
                                    <dt class="col-sm-6" style="font-size:15px">Uptime Percentage</dt>
                                    <dd class="col-sm-6" id="percent"></dd>
                                    <dt class="col-sm-8" style="color:gray; font-size:12px">(Uptime Minute/Available Time) * 100</dt>
                                    <dd class="col-sm-6" style="font-size:15px" ></dd>
                                </dl>
                            </div>
                        </div>
                </div>
                <div class="col-md-8">
                    <div class="card card-primary">
                        <div class="card-body">
                            <div class="iframe-container">
                                <iframe class="responsive-iframe" src="/resources/SLA_Aug_2023.htm"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /.content -->


    </div>


    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<style>
    .iframe-container{
        position: relative;
        width: 100%;
        overflow: hidden;
        padding-top: 75%;
    }
    .responsive-iframe{
        position: absolute;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
        width: 100%;
        height: 100%;
        border: none;
    }
</style>

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>>

<!-- date-range-picker -->
<script src="/resources/plugins/daterangepicker/daterangepicker.js"></script>
<!-- InputMask -->
<script src="/resources/plugins/moment/moment.min.js"></script>
<script src="/resources/plugins/inputmask/jquery.inputmask.min.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="/resources/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>

<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>

<!-- Page specific script -->
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>

<script>
    $(function () {
        //Datemask dd/mm/yyyy
        $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
        //Datemask2 mm/dd/yyyy
        $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
        //Money Euro
        $('[data-mask]').inputmask()

        //Date and time picker
        $('#issue_start').datetimepicker({ icons: { time: 'far fa-clock' } });
        $('#issue_end').datetimepicker({ icons: { time: 'far fa-clock' } });

        $('#range_calc').click(function(){

            var start = $('#issue_start_txt').val();
            var end = $('#issue_end_txt').val()

            const st = dayjs(start);
            const ed = dayjs(end);

            if(st>ed){
                alert("Issue End Date is greater than Issue Start Date." +
                    "Please change date range")
            }
            else{

                const diffSec = ed.diff(st);
                const diffMin = diffSec / (60*1000);
                var downtime = diffMin;
                //var totalDate ;

                calc(downtime,30*24*60);
            }
        });

        function calc(downtime, availtime){
            document.querySelector("#downtime").innerText=downtime;
            document.querySelector("#availtime").innerText=availtime;
            document.querySelector("#uptime").innerText = availtime - downtime;
            document.querySelector("#percent").innerText = ((availtime-downtime)/availtime) *100;
        }

    });
</script>
</body>
</html>
