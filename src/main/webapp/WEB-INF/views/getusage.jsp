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
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Bootstrap Color Picker -->
    <link rel="stylesheet" href="/resources/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="/resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- Select2 -->
    <link rel="stylesheet" href="/resources/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="/resources/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <!-- Bootstrap4 Duallistbox -->
    <link rel="stylesheet" href="/resources/plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
    <!-- BS Stepper -->
    <link rel="stylesheet" href="/resources/plugins/bs-stepper/css/bs-stepper.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">

    <!-- Chips -->
  <%--  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
--%>
</head>
<style>
    .closebtn {
        padding-left: 10px;
        color: #888;
        font-weight: bold;
        float: right;
        font-size: 20px;
        cursor: pointer;
    }

    .closebtn:hover {
        color: #000;
    }
    .chip {
        display: inline-block;
        padding: 0 25px;
        height: 45px;
        font-size: 15px;
        line-height: 45px;
        border-radius: 25px;
        background-color: #f1f1f1;
    }
    .form-check{
        position:relative;
        display:inline-block;
        width:100px;
        margin-right:120px;
        margin-left:30px;
        line-height: 27px
    }

    .col-sp-1{
        -ms-flex: 0 0 13%;
        flex: 0 0 13%;
        max-width: 13%;
    }

</style>
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
                        <a href="/" class="nav-link active">
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
                                SLA Uptime Calculator
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
                        <h1>Get Usage</h1>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <!-- /.row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card card-default">
                            <div class="card-body p-0">
                                <div class="bs-stepper">
                                    <div class="bs-stepper-header" role="tablist">
                                        <!-- your steps here -->
                                        <div class="step" data-target="#getEAShard">
                                            <button type="button" class="step-trigger" role="tab" aria-controls="getEAShard" id="getEAShard-trigger">
                                                <span class="bs-stepper-circle">1</span>
                                                <span class="bs-stepper-label">getEAShard</span>
                                            </button>
                                        </div>
                                        <div class="line"></div>
                                        <div class="step" data-target="#selectOptions">
                                            <button type="button" class="step-trigger" role="tab" aria-controls="selectOptions" id="selectOptions-trigger">
                                                <span class="bs-stepper-circle">2</span>
                                                <span class="bs-stepper-label">Select Options</span>
                                            </button>
                                        </div>
                                        <div class="line"></div>
                                        <div class="step" data-target="#getQuery">
                                            <button type="button" class="step-trigger" role="tab" aria-controls="getQuery" id="getQuery-trigger">
                                                <span class="bs-stepper-circle">3</span>
                                                <span class="bs-stepper-label">Get query</span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="bs-stepper-content">
                                        <!-- your steps content here -->
                                        <div id="getEAShard" class="content" role="tabpanel" aria-labelledby="getEAShard-trigger">
                                            <div class="form-group">
                                                <div class="col-sm-6">
                                                    <label>Enrollment #</label>
                                                    <div class="input-group mb-2" style="width:300px">
                                                        <input type="text" class="form-control rounded-0" id="enroll_num">
                                                        <span class="input-group-append">
                                                            <button type="button" class="btn btn-secondary" id="getshard">Make Query</button>
                                                        </span>
                                                    </div>
                                                    <div class="callout callout-success" id="queryforshard">
                                                    </div>
                                                </div>
                                            </div>
                                            <button class="btn btn-primary" onclick="stepper.next()">Next</button>
                                        </div>
                                        <div id="selectOptions" class="content" role="tabpanel" aria-labelledby="selectOptions-trigger">
                                            <!-- Date range -->
                                            <div class="form-group">
                                                <label>Date range:</label>
                                                <div class="input-group" style="width:350px">
                                                    <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <i class="far fa-calendar-alt"></i>
                                                    </span>
                                                    </div>
                                                    <input type="text" class="form-control float-right" id="dateRange">
                                                </div>
                                            </div>
                                            <div class="form-group" id="sub_area">
                                                <label>Subscription IDs:</label>
                                                <div class="input-group mb-2" style="width:650px">
                                                    <input type="text" class="form-control rounded-0" id="add_subs">
                                                    <span class="input-group-append">
                                                            <button type="button" class="btn btn-secondary" id="addSubs_btn">Add</button>
                                                    </span>
                                                    <div style="margin-right:10px"></div>
                                                        <div class="custom-file">
                                                            <input type="file" id="SubList" class="custom-file-input" style="ime-mode:inactive;" >
                                                            <label class="custom-file-label" for="SubList" id="sub_name"></label>
                                                        </div>
                                                        <button type="button" class="btn btn-block btn-outline-danger btn-sm" style="width:75px;" id="sub_cancel">cancel</button>
                                                </div>
                                                <div id="file_sub_List" style="display: none;">
                                                </div>
                                                <div id="chips_area">
                                                    <div class="chip" id="all_chip">
                                                        All
                                                        <span class="closebtn" onclick="removeChip(this)" >&times;</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Cost Type</label>
                                                <select class="form-control" style="width:350px" id="costType">
                                                    <option>Actual</option>
                                                    <option>Amortized</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label>Columns</label>
                                                <div class="row" id="columns"></div>
                                            </div>

                                            <div class="form-group">
                                                <label>Meter Category</label>
                                                <select class="select2bs4" multiple="multiple" data-placeholder="Select Meter Category" style="width: 100%;">
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label>Add Options</label>
                                                <ul style="list-style: none">
                                                    <li>
                                                        <div class="row">
                                                            <div style="width:60px">
                                                                <label></label>
                                                            </div>
                                                            <div class="col-sm-1">
                                                                <label>and/or</label>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label>Field</label>
                                                            </div>
                                                            <div class="col-sp-1">
                                                                <label>Operator</label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <label>Value</label>
                                                            </div>
                                                            <div class="col-sp-2">
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="options">
                                                <ul style="list-style: none">
                                                    <li>
                                                        <div class="form-group">
                                                            <div class="row">
                                                                <div style="width:60px">
                                                                    <i class="fa fa-plus" style="color:mediumblue;"></i>
                                                                </div>
                                                                <div class="col-sm-1">
                                                                </div>
                                                                <div class="col-sm-2" >
                                                                    <select class="field_select form-control" onchange="isRId(this)"></select>
                                                                </div>
                                                                <div class="operator col-sp-1">
                                                                    <select class="ops form-control">
                                                                        <option>==</option>
                                                                        <option>!=</option>
                                                                        <option>contains</option>
                                                                        <option>does not contain</option>
                                                                    </select>
                                                                </div>
                                                                <div class="col-sm-4">
                                                                    <input type="text" class="value form-control" name="valuein" onkeyup="valueIn(this)"/>
                                                                </div>
                                                            </div>
                                                            <div class="isAttach" style="display:none;">N</div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                                    <button class="btn btn-primary" onclick="stepper.previous()">Previous</button>
                                                    <button type="submit" class="btn btn-primary" id="submit_form">Submit</button>
                                        </div>
                                        <div id="getQuery" class="content" role="tabpanel" aria-labelledby="getQuery-trigger">
                                            <!-- Date range -->
                                            <div class="form-group">
                                                <label>Query Results</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <div id="results"></div>
                                                    </div>
                                                </div>
                                                <!-- /.input group -->
                                            </div>
                                            <button class="btn btn-primary" id="queryReset" >Previous</button>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.card -->
                    </div>
                </div>
                <!-- /.row -->
            <!-- /.container-fluid -->
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

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
 .
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Select2 -->
<script src="/resources/plugins/select2/js/select2.full.min.js"></script>
<!-- Bootstrap4 Duallistbox -->
<script src="/resources/plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
<!-- InputMask -->
<script src="/resources/plugins/moment/moment.min.js"></script>
<script src="/resources/plugins/inputmask/jquery.inputmask.min.js"></script>
<!-- date-range-picker -->
<script src="/resources/plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap color picker -->
<script src="/resources/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="/resources/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- BS-Stepper -->
<script src="/resources/plugins/bs-stepper/js/bs-stepper.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>

<!-- Page specific script -->
<script>


    var enroll_num;

    var colunms_list = ["Provider",  "BillingMonth", "ConsumedService", "Cost", "CostCenter", "EffectivePrice", "EnrollmentNumber", "IsMonetaryCommitmentService", "MeterId", "OfferId",
        "OfferName", "OrderNumber", "PartnerId", "PartNumber", "PlanId", "PlanName", "ProductId", "ProductOrderId", "ProductOrderName", "PublisherId", "PublisherName", "BenefitId", "Quantity",
        "ReservationId", "ReservationName", "ResourceGroup", "ResourceGuid", "ResourceLocation", "ResourceName", "ResourceType", "Tags", "UnitOfMeasure", "UnitPrice",
        "ChargeType", "PublisherType", "Frequency", "ChargeTypeInternal", "UnitPriceUSD", "UnitPriceScaled", "PayGPrice", "PayGPriceUSD", "Currency", "PriceModel", "ReservationUpFrontValue",
        "TermUnit", "CostType", "MeterResourceId", "ProductName", "MeterGuid", "MeterSubCategory", "MeterRegion", "UnitOfMeasure1", "IsMonetaryCommitmentService1",
        "ServiceTier", "UnitOfMeasureUCDD"];

    var column_list_checked=["Date","SubscriptionGuid","MeterCategory","MeterSubCategory", "MeterName","ResourceId", "AdditionalInfo","ChargeType","ChargeTypeInternal", "EffectivePrice"];
    var field_list = ["MeterCategory","MeterName","ResourceId", "AdditionalInfo","ChargeTypeInternal", "BenefitName"];

    var meterCategory_list=["Unassigned","All","Compute","Storage","SQL","CDN","Service Bus","Access Control","Cache","SQL Reporting","VPN Gateway","Media","Media Services","Backup","Virtual Machines","Virtual Machines Licenses",
        "Cloud Services","BizTalk Services","Integration","Azure App Service","Multi-Factor Authentication","Data Management","Mobile Services","Notification Hubs","Scheduler","Identity","Visual Studio","Networking","HDInsight","Websites",
        "Windows Azure CDN","Traffic Manager","Recovery Services","Windows Azure Storage","Data Services","Linux Support","App Services","Virtual Network","SQL Database","Windows Azure - All Services","Bandwidth","Redis Cache","API Management",
        "Batch","Business Analytics","Event Hubs","Automation","RemoteApp","VNet Gateway","ExpressRoute","Azure Site Recovery","Machine Learning Studio","Azure Search","Azure Cosmos DB","Log Analytics","Application Gateway","Stream Analytics",
        "Azure Data Catalog","Key Vault","Azure Data Factory","Azure IoT Hub","Content Delivery Network","Azure DevOps","Cognitive Services","ML API Services","Power BI","IoT Hub","Security Center","Data Catalog","SQL Data Warehouse",
        "Visual Studio Subscription","CDN Data Transfer","Functions","Logic Apps","SQL Server Stretch Database","Power BI Embedded","Insight and Analytics","Automation and Control","Analysis Services","Azure DNS","Dynamics 365 for Customer Insights",
        "Application Insights","Azure Active Directory Domain Services","Data Lake Analytics","Data Lake Store","Azure Active Directory B2C","Citrix","Xamarin Test Cloud","App Center","Xamarin University","Time Series Insights","Azure Database for MySQL",
        "Azure Database for Postgres","Service Fabric","Azure Monitor","Azure Analysis Services","SQL Advanced Threat Protection","Container Registry","Azure Stack","Event Grid","Container Instances","IoT Hub Device Provisioning","Machine Learning","Kusto",
        "Azure Database for PostgreSQL","Microsoft Genomics","IoT Central","Network Watcher","Azure Location Based Services","Azure Bot Service","Cost Management","Data Box","Azure NetApp Files","Azure Databricks","SignalR","Load Balancer",
        "Azure DDOS Protection","Azure Lab Services","Windows 10 IoT Core Services","Azure Firewall","Azure Maps","Service Fabric mesh","Azure Data Factory v2","Azure Database for MariaDB","Virtual WAN","Advanced Threat Protection","Machine Learning Service",
        "Azure Front Door Service","Datacenter Capacity","Data Explorer","Digital Twins","PlayFab","Spatial Anchors","NAT Gateway","Azure Database Migration Service","Advanced Data Security","Azure Data Explorer","Azure Blockchain","Specialized Compute",
        "Azure Bastion","Azure Data Share","HPCCache","Sentinel","SQL DB Edge","Visual Studio Online","GitHub","Azure Spring Cloud","Mixed Reality","Azure Firewall Manager","Microsoft Azure Peering Service","Azure Synthetics","Azure Machine Learning",
        "Azure API for FHIR","Azure Stack Hub","Azure Stack Edge","Microsoft Azure Internet Analyzer","Azure Remote Rendering","Gov Consumption","App Configuration","Private Mobile Network","Azure Synapse Analytics","Azure Cognitive Search",
        "Azure Kubernetes Service","Azure VM Image Builder","Azure Stack HCI","Azure IoT Security","Azure Orbital","Azure Arc","LogicApps","Azure Arc Enabled Databases","HPC Cache","SQL Managed Instance","Azure Active Directory for External Identities",
        "Visual Studio Codespaces","Azure Policy","Azure SQL Edge","Azure Resource Mover","MS Bing Services","Network Traversal","GHEM","AKS on Azure Stack HCI","Azure Purview","Quantum Computing","Microsoft Graph data connect",
        "Azure Managed Instance for Apache Cassandra","Azure Percept","Azure Route Server","Web PubSub","GitHub AE","Azure Defender","Azure WVD Promo","Intelligent Recommendations","Windows Virtual Desktop","Fraud Protection",
        "Business Applications Embedded","Azure HPC Workbench","Azure Applied AI Services","Dataverse","Power Platform Request","Power Apps","Microsoft Graph Services","Azure Chaos Studio","Azure Container Apps","Azure Load Testing",
        "Microsoft Azure Payment HSM","Hybrid Data Services","Azure Fluid Relay","Azure Grafana Service","Project Caspian","Power Automate","Azure confidential ledger","Syntex","Microsoft Dev Box","Azure Orbital Edge",
        "Microsoft Playwright Testing","Azure Arc-enabled AKS","Energy Data Manager","Analytics","Azure Singularity","Voice Core","AKS Edge Essentials","AI Ops","Update Management","Microsoft Fabric",
        "Azure Modeling and Simulation Workbench","Routing","Phone Numbers","Azure Operator Nexus","Import / Export","Visual Studio Team Services",
        "Application Dependency Monitor","SQL StreamInsight","ExpressRoute (IXP)","All Services","ExpressRoute (Carrier)","MySQL Database on Azure","Domains","Microsoft IoT Central",
        "Azure Container Service","Database Compute Unit","Web Sites","Cloud Connection Service","Visual Studio Connected Environment","Sonar DaaS","Software Pre Pay",
        "Machine Learning Services","Cosmos DB","Arcadia","Azure Arcadia Analytics","Bing ObjectStore","Footprint","Falcon Compute","SAP Embrace","Azure Modular Data Center","Azure Usage Billing",
        "Cosmic","RoundingAdjustment","Azure Code Scanning","Azure","Virtual Machine Licenses"];

    var subListFile = "N";
    var subList;

    $(function () {


        $('.nav-link').on('click', function (){
            $('.nav-link').removeClass('active');
            $(this).addClass('active');
        });


        $('#getshard').click(function(){
            enroll_num = $('#enroll_num').val();
            var html = "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\" id=\"qremove\">&times;</button>"
            html += "GetEAEnrollmentShardMap(en=\"";
            html +=  enroll_num + "\")";
            html += "<br />";
            html += "| project ShardedDatabase";
            $('#queryforshard').append(html);
        });

        $(document).on("click", "#qremove", function(event){
            document.getElementById("queryforshard").innerText = "";
        });


        $('#SubList').on("change", function(e){

            subListFile = "Y";

            var file = $(this)[0].files[0];
            $('#sub_name')[0].innerText = file.name;
            $('#chips_area').remove();

            var fr = new FileReader();
            fr.readAsText(file);
            fr.onload = () => {
                //console.log(fr.result);
                $('#file_sub_List')[0].innerText = fr.result;
            }
            e.target.value='';

        });


        $('#sub_cancel').click(function(){
            subListFile="N";
            $('#sub_name')[0].innerText = '';
            var html = "<div id=\"chips_area\">";
            html += "<div class=\"chip\" id=\"all_chip\">";
            html += "All";
            html += "<span class=\"closebtn\" onclick=\"this.parentElement.style.display='none'\">&times;</span>";
            html += "</div></div>"

            $('#sub_area').append(html);

        });

        $('#addSubs_btn').click(function() {


            var chips_num = 1;
            var subscription_id = $("#add_subs").val();

            if(subscription_id.length <= 0){
                alert("Please Input subscriptionGUID");
            }
            else{
                $('#all_chip').remove();
                if(subscription_id.indexOf(',') > 0){

                    var list = subscription_id.split(',');
                    for(var i in list){
                        var html = "";
                        html += "<div class=\"chip\" id=\"ch" + chips_num + "\">";
                        html += list[i].trim();
                        html += "<span class=\"closebtn\" onclick=\"removeChip(this)\">&times;</span>";
                        html += "</div>"
                        $("#chips_area").append(html);
                        chips_num++;
                    }

                }
                else{
                    var html = "";
                    html += "<div class=\"chip\" id=\"ch" + chips_num + "\">";
                    html += subscription_id;
                    html += "<span class=\"closebtn\" onclick=\"removeChip(this)\">&times;</span>";
                    html += "</div>"

                    $("#chips_area").append(html);
                    chips_num++;
                }
            }
            $("#add_subs").val('');
        });

        column_list_checked.forEach(function(data){
            const template= "<div class=\"form-check\">"+
                "<input class=\"form-check-input\" type=\"checkbox\" checked> " +
                "<label class=\"form-check-label\">" + data + "</label> </div>";

           $("#columns").append(template);
        });

        // //columns_uncheck
        colunms_list.forEach(function(data){
            const template="<div class=\"form-check\">"+
                "<input class=\"form-check-input\" type=\"checkbox\"> " +
                "<label class=\"form-check-label\">" + data + "</label> </div>";

            $("#columns").append(template);
        });

        //Initialize Select2 Elements
        $('.select2bs4').select2({
            theme: 'bootstrap4'
        });

        meterCategory_list.forEach(function (data){
            var option = document.createElement('option');
            option.innerText = data;
            document.querySelector('.select2bs4').append(option);
        });

        var list = field_list.concat(colunms_list);

        list.forEach(function (data){
            var option = document.createElement('option');
            option.innerText = data;
            document.querySelector('.field_select').append(option);
        });

        $(document).on('click', '.fa-plus', function (e){
            var html =  "<li><div class=\"form-group\"><div class=\"row\"><div style=\"width:60px\">" +
                "<div> <i class=\"fa fa-plus\" style=\"color:#7f7ff8\"></i>" +
                       "<i class=\"fa fa-minus\" style=\"color:red; margin-left:20px\"></i></div></div>" +
                "<div class=\"col-sm-1\"> <select class=\"clause form-control\"><option>and</option><option>or</option></select></div>"+
                "<div class=\"col-sm-2\"> <select class=\"field_select form-control\" onchange=\"isRId(this)\"></select> </div>"+
                "<div class=\"operator col-sp-1\"> <select class=\"ops form-control\"><option>==</option> <option>!=</option> "+
                "<option>contains</option> <option>does not contain</option></select> </div>"+
                "<div class=\"col-sm-4\"> <input type=\"text\" class=\"value form-control\" name=\"valuein\" onkeyup=\"valueIn(this)\"/> </div></div>" +
                "<div class=\"isAttach\" style=\"display:none;\">N</div></div></li>";

            $('.options').find('ul').append(html);

            list.forEach(function (data){
                var option = document.createElement('option');
                option.innerText = data;
                $('.field_select').append(option);
            });
        });

        $(document).on('click', '.fa-minus', function (e){
            p = this.closest('li');
            p.remove(this);
        });

        $('#submit_form').click(function (){

            //date range
            var dateRange = $("#dateRange").val();
            var sd = dateRange.split("-")[0];
            var ed = dateRange.split("-")[1];

            var stM = sd.split("/")[0].trim();
            var stD = sd.split("/")[1].trim();
            var stY = sd.split("/")[2].trim();

            var edM = ed.split("/")[0].trim();
            var edD = ed.split("/")[1].trim();
            var edY = ed.split("/")[2].trim();

            var startDate = stY + "-" +stM + "-" + stD;
            var endDate = edY + "-" + edM + "-" + edD;

            console.log(startDate + ", " + endDate);

            var subsList=[];

            if(subListFile=="N"){
                var subs = document.querySelector('#chips_area').children;
                var subs_num = subs.length;
                var s ;

                if(subs_num == 1){
                    s = subs[0].innerText.slice(0, -2);
                    subsList.push(s);
                }
                else if(subs_num>1) {
                    for (var i = 0; i < subs_num; i++) {
                        s = subs[i].innerText.slice(0, -2);
                        subsList.push(s);
                    }
                }
                else{
                    subsList.push("All");
                }
            }
            else{
                subsList = $('#file_sub_List')[0].innerHTML.split('<br>');
                subsList.pop();
                console.log(subsList);
            }

            //cost type
            var costType= $("#costType").val();
            console.log(costType);
            //info.costType = costType;

            //columns list
            var columns = [];
            $('input[type="checkbox"]:checked').each(function(){
                columns.push($(this)[0].nextElementSibling.innerHTML);
            });
            columns.pop();
            console.log(columns);
            //info.columns = columns;

            //meter category
            var meter_category =[];
            $(".select2bs4").next().find("li").each(function(){
                var cate = $(this)[0].innerText.slice(2);
                meter_category.push(cate);
            });
            meter_category.pop();
            console.log(meter_category);
            //info.meterCategory = meter_category;

            //options
            /**
             * [{clause : And/or,
             * field: date,
             * operator: ==,
             * value: ''},]
             */

            var operations =[];
            var formData = new FormData();
            $('.options').find('li').each(function(){

                var clause = $(this).find('.clause').val();
                var field = $(this).find('.field_select').val();
                var ops = $(this).find('.ops').val();
                var vals = $(this).find('.value').val();
                var isAttach = $(this).find('.isAttach')[0].innerHTML;

                var data = new Object();
                data.clause = clause;
                data.field = field;
                data.ops = ops;

                if(isAttach == 'Y'){

                    var file = $(this).find('.file_upload')[0].files[0];
                    data.val = "UP";
                    formData.append("files", file);
                }
                else{
                    data.val = vals;
                }
                operations.push(data);
            });

            const obj = new Object();
            obj.enrollNum = enroll_num;
            obj.startDate = startDate;
            obj.endDate = endDate;
            obj.subIds = subsList;
            obj.costType = costType;
            obj.columns = columns;
            obj.meterCategory = meter_category;
            obj.operations = operations;

            const blob = new Blob([JSON.stringify(obj)], {type:'application/json'});
            formData.append('infos', blob);


            $.ajax({
                type:'post',
                url:'getusage',
                data: formData,
                processData: false,
                contentType: false,
                success:function(data){
                    console.log(data.query);
                    $('#results').append(data.query);
                    stepper.next();
                },
                error:function(data, xhr, status, error){
                    console.log(data.query);
                    console.log(status, error);
                }
            });

        });

        $('#queryReset').click(function(){
            stepper.previous();
            $('#results').empty();
        });

        //Datemask dd/mm/yyyy
        $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
        //Datemask2 mm/dd/yyyy
        $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
        //Money Euro
        $('[data-mask]').inputmask()

        //Date picker
        $('#reservationdate').datetimepicker({
            format: 'L'
        });


        //Date range picker
        $('#dateRange').daterangepicker()

        //Date range as a button
        $('#daterange-btn').daterangepicker(
            {
                ranges   : {
                    'Today'       : [moment(), moment()],
                    'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month'  : [moment().startOf('month'), moment().endOf('month')],
                    'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                startDate: moment().subtract(29, 'days'),
                endDate  : moment()
            },
            function (start, end) {
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
            }
        )

        //Timepicker
        $('#timepicker').datetimepicker({
            format: 'LT'
        })

        //Bootstrap Duallistbox
        $('.duallistbox').bootstrapDualListbox();


        $("input[data-bootstrap-switch]").each(function(){
            $(this).bootstrapSwitch('state', $(this).prop('checked'));
        });

        // $('input[name="valuein"]').on("propertychange change keyup paste input", function() {
        //
        //     html = "<option>in~</option> <option>not in~</option> "+
        //         "<option>has_any</option> <option>not has_any</option>";
        //
        //     var currentVal = $(this).val();
        //     if(currentVal.endsWith(",")){
        //         $(this)[0].parentNode.parentNode.childNodes[7].childNodes[1].innerHTML = html;
        //     }
        // });


    });


    // BS-Stepper Init
    document.addEventListener('DOMContentLoaded', function () {
        window.stepper = new Stepper(document.querySelector('.bs-stepper'))
    });

    function removeChip(obj){
        $(obj)[0].parentNode.remove();
    }


    function isRId(obj){
        var html = '';
        var selected = $(obj).val();
        var isAttached = obj.closest('.form-group').lastElementChild;

        if(selected == "ResourceId" || selected =="ResourceName" || selected =="ProductOrderId" || selected =="AdditionalInfo"){

            if(isAttached.innerHTML == "N"){
                html += "<div class = \"up\">";
                html += "<input type=\"file\" class= \"file_upload\" id=\"uploadFile\" style=\"ime-mode:inactive;\" >";
                html += "<label for=\"uploadFile\"></label>";
                html += "<button type=\"button\" id=\"upload_cancel\">cancel</button></div>";

                isAttached.innerHTML = 'Y'
                obj.closest('.row').insertAdjacentHTML('beforeend',html);
            }

        }
        else{
            //파일업로드 있으면
            if(isAttached.innerText == "Y"){
                obj.closest('.row').lastChild.remove();
                isAttached.innerHTML = 'N'
            }
        }
    }

    $(document).on('click', '#upload_cancel', function (e) {
        $(this)[0].parentElement.firstChild.value='';
    });

    function valueIn(obj){
       var html = "<option>in~</option> <option>not in~</option> "+
            "<option>has_any</option> <option>not has_any</option>";

        var defaulthtml = "<option>==</option> <option>!=</option> "+
            "<option>contains</option> <option>does not contain</option>";

        var currentVal = $(obj).val();
        var optionsParent = $(obj)[0].parentNode.parentNode;
        if(currentVal.endsWith(",")){

            if(optionsParent.childNodes.length > 5){
                optionsParent.childNodes[7].childNodes[1].innerHTML = html;
            }
            else{
                optionsParent.childNodes[3].childNodes[1].innerHTML = html;
            }
        }

       else if(currentVal.split(",").length > 1){
            if(optionsParent.childNodes.length > 5){
                optionsParent.childNodes[7].childNodes[1].innerHTML = html;
            }
            else{
                optionsParent.childNodes[3].childNodes[1].innerHTML = html;
            }
        }

        else{
            if(optionsParent.childNodes.length > 5){
                optionsParent.childNodes[7].childNodes[1].innerHTML = defaulthtml;
            }
            else{
                optionsParent.childNodes[3].childNodes[1].innerHTML = defaulthtml;
            }
        }
    }


</script>
</body>
</html>
