<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../../frame/top.jsp"%>
</head>

<body style="margin:0px 0px">
	<%@ include file="../../frame/head.jsp"%>
	<%@ include file="../../frame/left.jsp"%>
	<div>
		<table id="dg" title="查询结果" class="easyui-datagrid" style="width:700px;height:250px"
	        url="get_users.php"
	        toolbar="#toolbar" pagination="true"
	        rownumbers="true" fitColumns="true" singleSelect="true">
	    <thead>
	        <tr>
	            <th field="firstname" width="50">First Name</th>
	            <th field="lastname" width="50">Last Name</th>
	            <th field="phone" width="50">Phone</th>
	            <th field="email" width="50">Email</th>
	        </tr>
	    </thead>
		</table>
		<div id="toolbar">
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改</a>
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
		</div>
		
		<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
		        closed="true" buttons="#dlg-buttons">
		    <div class="ftitle">User Information</div>
		    <form id="fm" method="post" novalidate>
		        <div class="fitem">
		            <label>First Name:</label>
		            <input name="firstname" class="easyui-textbox" required="true">
		        </div>
		        <div class="fitem">
		            <label>Last Name:</label>
		            <input name="lastname" class="easyui-textbox" required="true">
		        </div>
		        <div class="fitem">
		            <label>Phone:</label>
		            <input name="phone" class="easyui-textbox">
		        </div>
		        <div class="fitem">
		            <label>Email:</label>
		            <input name="email" class="easyui-textbox" validType="email">
		        </div>
		    </form>
		</div>
		<div id="dlg-buttons">
		    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">Save</a>
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">Cancel</a>
		</div>
	</div>
	
	<script type="text/javascript">
	   var url;
	   function newUser(){
	       $('#dlg').dialog('open').dialog('center').dialog('setTitle','New User');
	       $('#fm').form('clear');
	       url = 'save_user.php';
	   }
	   function editUser(){
	       var row = $('#dg').datagrid('getSelected');
	       if (row){
	           $('#dlg').dialog('open').dialog('center').dialog('setTitle','Edit User');
	           $('#fm').form('load',row);
	           url = 'update_user.php?id='+row.id;
	       }else{
	    	   $.messager.alert('提示','请选择一条记录!','info');
	       }
	   }
	   function saveUser(){
	       $('#fm').form('submit',{
	           url: url,
	           onSubmit: function(){
	               return $(this).form('validate');
	           },
	           success: function(result){
	               var result = eval('('+result+')');
	               if (result.errorMsg){
	                   $.messager.show({
	                       title: 'Error',
	                       msg: result.errorMsg
	                   });
	               } else {
	                   $('#dlg').dialog('close');        // close the dialog
	                   $('#dg').datagrid('reload');    // reload the user data
	               }
	           }
	       });
	   }
	   function destroyUser(){
	       var row = $('#dg').datagrid('getSelected');
	       if (row){
	            $.messager.confirm('Confirm','Are you sure you want to destroy this user?',function(r){
	                if (r){
	                    $.post('destroy_user.php',{id:row.id},function(result){
	                        if (result.success){
	                            $('#dg').datagrid('reload');    // reload the user data
	                        } else {
	                            $.messager.show({    // show error message
	                                title: 'Error',
	                                msg: result.errorMsg
	                            });
	                        }
	                    },'json');
	                }
	            });
	        }
	    }
	</script>
	<style type="text/css">
	    #fm{
	        margin:0;
	        padding:10px 30px;
	    }
	    .ftitle{
	        font-size:14px;
	        font-weight:bold;
	        padding:5px 0;
	        margin-bottom:10px;
	        border-bottom:1px solid #ccc;
	    }
	    .fitem{
	        margin-bottom:5px;
	    }
	    .fitem label{
	        display:inline-block;
	        width:80px;
	    }
	    .fitem input{
	        width:160px;
	    }
	</style>
	
</body>
</html>