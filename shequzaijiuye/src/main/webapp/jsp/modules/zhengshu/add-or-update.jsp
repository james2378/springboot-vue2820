<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="../../static/head.jsp" %>
    <link href="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/css/datetimepicker.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-select.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" charset="utf-8">
        window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/resources/ueditor/"; //UEDITOR_HOME_URL、config、all这三个顺序不能改变
    </script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<style>
    .error {
        color: red;
    }
</style>
<body>
<!-- Pre Loader -->
<div class="loading">
    <div class="spinner">
        <div class="double-bounce1"></div>
        <div class="double-bounce2"></div>
    </div>
</div>
<!--/Pre Loader -->
<div class="wrapper">
    <!-- Page Content -->
    <div id="content">
        <!-- Top Navigation -->
        <%@ include file="../../static/topNav.jsp" %>
        <!-- Menu -->
        <div class="container menu-nav">
            <nav class="navbar navbar-expand-lg lochana-bg text-white">
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="ti-menu text-white"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul id="navUl" class="navbar-nav mr-auto">

                    </ul>
                </div>
            </nav>
        </div>
        <!-- /Menu -->
        <!-- Breadcrumb -->
        <!-- Page Title -->
        <div class="container mt-0">
            <div class="row breadcrumb-bar">
                <div class="col-md-6">
                    <h3 class="block-title">编辑证书</h3>
                </div>
                <div class="col-md-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/index.jsp">
                                <span class="ti-home"></span>
                            </a>
                        </li>
                        <li class="breadcrumb-item">证书管理</li>
                        <li class="breadcrumb-item active">编辑证书</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /Page Title -->

        <!-- /Breadcrumb -->
        <!-- Main Content -->
        <div class="container">

            <div class="row">
                <!-- Widget Item -->
                <div class="col-md-12">
                    <div class="widget-area-2 lochana-box-shadow">
                        <h3 class="widget-title">证书信息</h3>
                        <form id="addOrUpdateForm">
                            <div class="form-row">
                            <!-- 级联表的字段 -->
                                    <div class="form-group col-md-6 aaaaaa renyuan">
                                        <label>再就业人员</label>
                                        <div>
                                            <select style="width: 450px" id="renyuanSelect" name="renyuanSelect"
                                                    class="selectpicker form-control"  data-live-search="true"
                                                    title="请选择" data-header="请选择" data-size="5" data-width="650px">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 renyuan">
                                        <label>再就业人员姓名</label>
                                        <input style="width: 450px" id="renyuanName" name="renyuanName" class="form-control"
                                               placeholder="再就业人员姓名" readonly>
                                    </div>
                                    <div class="form-group col-md-6 renyuan">
                                        <label>再就业人员手机号</label>
                                        <input style="width: 450px" id="renyuanPhone" name="renyuanPhone" class="form-control"
                                               placeholder="再就业人员手机号" readonly>
                                    </div>
                                    <div class="form-group col-md-6 renyuan">
                                        <label>再就业人员头像</label>
                                        <img id="renyuanPhotoImg" src="" width="100" height="100">
                                    </div>
                            <!-- 当前表的字段 -->
                                    <input id="updateId" name="id" type="hidden">
                                <input id="renyuanId" name="renyuanId" type="hidden">
                                    <div class="form-group col-md-6 zhengshuUuidNumberDiv">
                                        <label>证书编号</label>
                                        <input style="width: 450px" id="zhengshuUuidNumber" name="zhengshuUuidNumber" class="form-control"
                                               placeholder="证书编号">
                                    </div>
                                    <div class="form-group col-md-6 zhengshuNameDiv">
                                        <label>证书名称</label>
                                        <input style="width: 450px" id="zhengshuName" name="zhengshuName" class="form-control"
                                               placeholder="证书名称">
                                    </div>
                                    <div class="form-group col-md-6 zhengshuTypesDiv">
                                        <label>证书类型</label>
                                        <select style="width: 450px" id="zhengshuTypesSelect" name="zhengshuTypes" class="form-control">
                                        </select>
                                    </div>
                                    <div class="form-group col-md-6 zhengshuPhotoDiv">
                                        <label>证书文件</label>
                                        <img id="zhengshuPhotoImg" src="" width="100" height="100">
                                        <input name="file" type="file" id="zhengshuPhotoupload"
                                               class="form-control-file">
                                        <input name="zhengshuPhoto" id="zhengshuPhoto-input" type="hidden">
                                    </div>
                                    <div class="form-group  col-md-6 zhengshuContentDiv">
                                        <label>备注</label>
                                        <input id="zhengshuContentupload" name="file" type="file">
                                        <script id="zhengshuContentEditor" type="text/plain"
                                                style="width:100%;height:230px;"></script>
                                        <script type = "text/javascript" >
                                        //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
                                        //相见文档配置属于你自己的编译器
                                        var zhengshuContentUe = UE.getEditor('zhengshuContentEditor', {
                                            toolbars: [
                                                [
                                                    'undo', //撤销
                                                    'bold', //加粗
                                                    'redo', //重做
                                                    'underline', //下划线
                                                    'horizontal', //分隔线
                                                    'inserttitle', //插入标题
                                                    'cleardoc', //清空文档
                                                    'fontfamily', //字体
                                                    'fontsize', //字号
                                                    'paragraph', //段落格式
                                                    'inserttable', //插入表格
                                                    'justifyleft', //居左对齐
                                                    'justifyright', //居右对齐
                                                    'justifycenter', //居中对
                                                    'justifyjustify', //两端对齐
                                                    'forecolor', //字体颜色
                                                    'fullscreen', //全屏
                                                    'edittip ', //编辑提示
                                                    'customstyle', //自定义标题
                                                ]
                                            ]
                                        });
                                        </script>
                                        <input type="hidden" name="zhengshuContent" id="zhengshuContent-input">
                                    </div>
                                    <div class="form-group col-md-12 mb-3">
                                        <button id="submitBtn" type="button" class="btn btn-primary btn-lg">提交</button>
                                        <button id="exitBtn" type="button" class="btn btn-primary btn-lg">返回</button>
                                    </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- /Widget Item -->
            </div>
        </div>
        <!-- /Main Content -->
    </div>
    <!-- /Page Content -->
</div>
<!-- Back to Top -->
<a id="back-to-top" href="#" class="back-to-top">
    <span class="ti-angle-up"></span>
</a>
<!-- /Back to Top -->
<%@ include file="../../static/foot.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/vue.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.ui.widget.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.fileupload.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/jquery.validate.min.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/messages_zh.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/card.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" charset="utf-8"
                 src="${pageContext.request.contextPath}/resources/js/bootstrap-select.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/laydate.js"></script>
<script>
    <%@ include file="../../utils/menu.jsp"%>
    <%@ include file="../../static/setMenu.js"%>
    <%@ include file="../../utils/baseUrl.jsp"%>

    var tableName = "zhengshu";
    var pageType = "add-or-update";
    var updateId = "";
    var crossTableId = -1;
    var crossTableName = '';
    var ruleForm = {};
    var crossRuleForm = {};


    // 下拉框数组
        <!-- 当前表的下拉框数组 -->
    var zhengshuTypesOptions = [];
        <!-- 级联表的下拉框数组 -->
    var renyuanOptions = [];

    var ruleForm = {};


    // 文件上传
    function upload() {

        <!-- 当前表的文件上传 -->
        $('#zhengshuPhotoupload').fileupload({
            url: baseUrl + 'file/upload',
            headers: {token: window.sessionStorage.getItem("token")},
            dataType: 'json',
            done: function (e, data) {
                var photoUrl= baseUrl + 'file/download?fileName=' + data.result.file;
                document.getElementById('zhengshuPhotoImg').setAttribute('src',photoUrl);
                document.getElementById('zhengshuPhoto-input').setAttribute('value',photoUrl);
            }
        });


        $('#zhengshuContentupload').fileupload({
            url: baseUrl + 'file/upload',
            headers: {token: window.sessionStorage.getItem("token")},
            dataType: 'json',
            done: function (e, data) {
                UE.getEditor('zhengshuContentEditor').execCommand('insertHtml', '<img src=\"' + baseUrl + 'upload/' + data.result.file + '\" width=900 height=560>');
            }
        });


    }

    // 表单提交
    function submit() {
        if (validform() == true && compare() == true) {
            let data = {};
            getContent();
            if(window.sessionStorage.getItem('role') != '再就业人员'){//当前登录用户不为这个
                if($("#renyuanId") !=null){
                    var renyuanId = $("#renyuanId").val();
                    if(renyuanId == null || renyuanId =='' || renyuanId == 'null'){
                        alert("再就业人员不能为空");
                        return;
                    }
                }
            }
            let value = $('#addOrUpdateForm').serializeArray();
            $.each(value, function (index, item) {
                data[item.name] = item.value;
            });
            let json = JSON.stringify(data);
            var urlParam;
            var successMes = '';
            if (updateId != null && updateId != "null" && updateId != '') {
                urlParam = 'update';
                successMes = '修改成功';
            } else {
                urlParam = 'save';
                    successMes = '添加成功';

            }
            httpJson("zhengshu/" + urlParam, "POST", data, (res) => {
                if(res.code == 0){
                    window.sessionStorage.removeItem('addzhengshu');
                    window.sessionStorage.removeItem('updateId');
                    let flag = true;
                    if (flag) {
                        alert(successMes);
                    }
                    if (window.sessionStorage.getItem('onlyme') != null && window.sessionStorage.getItem('onlyme') == "true") {
                        window.sessionStorage.removeItem('onlyme');
                        window.sessionStorage.setItem("reload","reload");
                        window.parent.location.href = "${pageContext.request.contextPath}/index.jsp";
                    } else {
                        window.location.href = "list.jsp";
                    }
                }
            });
        } else {
            alert("表单未填完整或有错误");
        }
    }

    // 查询列表
        <!-- 查询当前表的所有列表 -->
        function zhengshuTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=zhengshu_types", "GET", {}, (res) => {
                if(res.code == 0){
                    zhengshuTypesOptions = res.data.list;
                }
            });
        }
        <!-- 查询级联表的所有列表 -->
        function renyuanSelect() {
            //填充下拉框选项
            http("renyuan/page?page=1&limit=100&sort=&order=", "GET", {}, (res) => {
                if(res.code == 0){
                    renyuanOptions = res.data.list;
                }
            });
        }

        function renyuanSelectOne(id) {
            http("renyuan/info/"+id, "GET", {}, (res) => {
                if(res.code == 0){
                ruleForm = res.data;
                renyuanShowImg();
                renyuanShowVideo();
                renyuanDataBind();
            }
        });
        }



    // 初始化下拉框
    <!-- 初始化当前表的下拉框 -->
        function initializationZhengshutypesSelect(){
            var zhengshuTypesSelect = document.getElementById('zhengshuTypesSelect');
            if(zhengshuTypesSelect != null && zhengshuTypesOptions != null  && zhengshuTypesOptions.length > 0 ){
                for (var i = 0; i < zhengshuTypesOptions.length; i++) {
                    zhengshuTypesSelect.add(new Option(zhengshuTypesOptions[i].indexName,zhengshuTypesOptions[i].codeIndex));
                }
            }
        }

        function initializationrenyuanSelect() {
            var renyuanSelect = document.getElementById('renyuanSelect');
            if(renyuanSelect != null && renyuanOptions != null  && renyuanOptions.length > 0 ) {
                for (var i = 0; i < renyuanOptions.length; i++) {
                        renyuanSelect.add(new Option(renyuanOptions[i].renyuanName, renyuanOptions[i].id));
                }

                $("#renyuanSelect").change(function(e) {
                        renyuanSelectOne(e.target.value);
                });
            }

        }



    // 下拉框选项回显
    function setSelectOption() {

        <!-- 当前表的下拉框回显 -->

        var zhengshuTypesSelect = document.getElementById("zhengshuTypesSelect");
        if(zhengshuTypesSelect != null && zhengshuTypesOptions != null  && zhengshuTypesOptions.length > 0 ) {
            for (var i = 0; i < zhengshuTypesOptions.length; i++) {
                if (zhengshuTypesOptions[i].codeIndex == ruleForm.zhengshuTypes) {//下拉框value对比,如果一致就赋值汉字
                        zhengshuTypesSelect.options[i].selected = true;
                }
            }
        }
        <!--  级联表的下拉框回显  -->
            var renyuanSelect = document.getElementById("renyuanSelect");
            if(renyuanSelect != null && renyuanOptions != null  && renyuanOptions.length > 0 ) {
                for (var i = 0; i < renyuanOptions.length; i++) {
                    if (renyuanOptions[i].id == ruleForm.renyuanId) {//下拉框value对比,如果一致就赋值汉字
                        renyuanSelect.options[i+1].selected = true;
                        $("#renyuanSelect" ).selectpicker('refresh');
                    }
                }
            }
    }


    // 填充富文本框
    function setContent() {

        <!-- 当前表的填充富文本框 -->
        if (ruleForm.zhengshuContent != null && ruleForm.zhengshuContent != 'null' && ruleForm.zhengshuContent != '' && $("#zhengshuContentupload").length>0) {

            var zhengshuContentUeditor = UE.getEditor('zhengshuContentEditor');
            zhengshuContentUeditor.ready(function () {
                var mes = '';
                if(ruleForm.zhengshuContent != null){
                    mes = ''+ ruleForm.zhengshuContent;
                    // mes = mes.replace(/\n/g, "<br>");
                }
                zhengshuContentUeditor.setContent(mes);
            });
        }
    }
    // 获取富文本框内容
    function getContent() {

        <!-- 获取当前表的富文本框内容 -->
        if($("#zhengshuContentupload").length>0) {
            var zhengshuContentEditor = UE.getEditor('zhengshuContentEditor');
            if (zhengshuContentEditor.hasContents()) {
                $('#zhengshuContent-input').attr('value', zhengshuContentEditor.getContent());
            }
        }
    }
    //数字检查
        <!-- 当前表的数字检查 -->

    function exit() {
        window.sessionStorage.removeItem("updateId");
        window.sessionStorage.removeItem('addzhengshu');
        window.location.href = "list.jsp";
    }
    // 表单校验
    function validform() {
        return $("#addOrUpdateForm").validate({
            rules: {
                renyuanId: "required",
                zhengshuUuidNumber: "required",
                zhengshuName: "required",
                zhengshuTypes: "required",
                zhengshuPhoto: "required",
                zhengshuContent: "required",
            },
            messages: {
                renyuanId: "再就业人员不能为空",
                zhengshuUuidNumber: "证书编号不能为空",
                zhengshuName: "证书名称不能为空",
                zhengshuTypes: "证书类型不能为空",
                zhengshuPhoto: "证书文件不能为空",
                zhengshuContent: "备注不能为空",
            }
        }).form();
    }

    // 获取当前详情
    function getDetails() {
        var addzhengshu = window.sessionStorage.getItem("addzhengshu");
        if (addzhengshu != null && addzhengshu != "" && addzhengshu != "null") {
            //注册表单验证
            $(validform());
            $("#zhengshuUuidNumber").val(new Date().getTime()+Math.ceil(Math.random()*10));//设置唯一号

            $('#submitBtn').text('新增');

        } else {
            $('#submitBtn').text('修改');
            var userId = window.sessionStorage.getItem('userId');
            updateId = userId;//先赋值登录用户id
            var uId  = window.sessionStorage.getItem('updateId');//获取修改传过来的id
            if (uId != null && uId != "" && uId != "null") {
                //如果修改id不为空就赋值修改id
                updateId = uId;
            }
            window.sessionStorage.removeItem('updateId');
            http("zhengshu/info/" + updateId, "GET", {}, (res) => {
                if(res.code == 0)
                {
                    ruleForm = res.data
                    // 是/否下拉框回显
                    setSelectOption();
                    // 设置图片src
                    showImg();
                    // 设置视频src
                    showVideo();
                    // 数据填充
                    dataBind();
                    // 富文本框回显
                    setContent();
                    //注册表单验证
                    $(validform());
                }

            });
        }
    }

    // 清除可能会重复渲染的selection
    function clear(className) {
        var elements = document.getElementsByClassName(className);
        for (var i = elements.length - 1; i >= 0; i--) {
            elements[i].parentNode.removeChild(elements[i]);
        }
    }

    function dateTimePick() {
        var insertTime = laydate.render({
            elem: '#insertTime-input'
            ,type: 'datetime'
        });
    }


    function dataBind() {


    <!--  级联表的数据回显  -->
        renyuanDataBind();


    <!--  当前表的数据回显  -->
        $("#updateId").val(ruleForm.id);
        $("#renyuanId").val(ruleForm.renyuanId);
        $("#zhengshuUuidNumber").val(ruleForm.zhengshuUuidNumber);
        $("#zhengshuName").val(ruleForm.zhengshuName);
        $("#zhengshuContent").val(ruleForm.zhengshuContent);

    }
    <!--  级联表的数据回显  -->
    function renyuanDataBind(){

                    <!-- 把id赋值给当前表的id-->
        $("#renyuanId").val(ruleForm.id);

        $("#renyuanName").val(ruleForm.renyuanName);
        $("#renyuanPhone").val(ruleForm.renyuanPhone);
        $("#renyuanIdNumber").val(ruleForm.renyuanIdNumber);
        $("#renyuanEmail").val(ruleForm.renyuanEmail);
    }


    //图片显示
    function showImg() {
        <!--  当前表的图片  -->
        $("#zhengshuPhotoImg").attr("src",ruleForm.zhengshuPhoto);

        <!--  级联表的图片  -->
        renyuanShowImg();
    }


    <!--  级联表的图片  -->

    function renyuanShowImg() {
        $("#renyuanPhotoImg").attr("src",ruleForm.renyuanPhoto);
    }



    //视频回显
    function showVideo() {
    <!--  当前表的视频  -->

    <!--  级联表的视频  -->
        renyuanShowVideo();
    }


    <!--  级联表的视频  -->

    function renyuanShowVideo() {
        $("#renyuanPhotoV").attr("src",ruleForm.renyuanPhoto);
    }



    $(document).ready(function () {
        //设置右上角用户名
        $('.dropdown-menu h5').html(window.sessionStorage.getItem('username'))
        //设置项目名
        $('.sidebar-header h3 a').html(projectName)
        //设置导航栏菜单
        setMenu();
        $('#exitBtn').on('click', function (e) {
            e.preventDefault();
            exit();
        });
        //初始化时间插件
        dateTimePick();
        //查询所有下拉框
            <!--  当前表的下拉框  -->
            zhengshuTypesSelect();
            <!-- 查询级联表的下拉框(用id做option,用名字及其他参数做名字级联修改) -->
            renyuanSelect();



        // 初始化下拉框
            <!--  初始化当前表的下拉框  -->
            initializationZhengshutypesSelect();
            <!--  初始化级联表的下拉框  -->
            initializationrenyuanSelect();

        $(".selectpicker" ).selectpicker('refresh');
        getDetails();
        //初始化上传按钮
        upload();
    <%@ include file="../../static/myInfo.js"%>
                $('#submitBtn').on('click', function (e) {
                    e.preventDefault();
                    //console.log("点击了...提交按钮");
                    submit();
                });
        readonly();
        window.sessionStorage.removeItem('addzhengshu');
    });

    function readonly() {
        if (window.sessionStorage.getItem('role') == '管理员') {
            //$('#jifen').attr('readonly', 'readonly');
            //$('#role').attr('style', 'pointer-events:none;width:450px;');
        }
		else if (window.sessionStorage.getItem('role') == '再就业人员') {
            // $(".aaaaaa").remove();
            $(".renyuan").remove();//删除当前用户的信息
        }
		else if (window.sessionStorage.getItem('role') == '老师') {
            // $(".aaaaaa").remove();
            $(".laoshi").remove();//删除当前用户的信息
        }
        else{
            // alert("未知情况.......");
            // var replyTextUeditor = UE.getEditor('replyTextEditor');
            // replyTextUeditor.ready(function () {
            //     replyTextUeditor.setDisabled('fullscreen');
            // });
        }
    }

    //比较大小
    function compare() {
        var largerVal = null;
        var smallerVal = null;
        if (largerVal != null && smallerVal != null) {
            if (largerVal <= smallerVal) {
                alert(smallerName + '不能大于等于' + largerName);
                return false;
            }
        }
        return true;
    }


    // 用户登出
    <%@ include file="../../static/logout.jsp"%>
</script>
</body>

</html>
