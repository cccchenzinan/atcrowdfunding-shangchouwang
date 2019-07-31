 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${ctx}/static/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctx}/static/css/font-awesome.min.css">
	<link rel="stylesheet" href="${ctx}/static/css/main.css">
	<link rel="stylesheet" href="${ctx}/static/css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>
  <%pageContext.setAttribute("title", "角色维护");%>
  
  
  
<%@include file="/include/top-nav.jsp"%>
    
    <div class="container-fluid">
      <div class="row">
      <%@include file="/include/side-bar.jsp"%>
      
      
      
      
      
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="${ctx}/static/#">首页</a></li>
				  <li><a href="${ctx}/static/#">数据列表</a></li>
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline">
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
						<!-- multiple为多选 -->
						<select id="unAssignSelect" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
							<c:forEach items="${unRoles }" var="role">
								<option value="${role.id }">${role.name }</option>
							</c:forEach>>
                   	    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li id="addRoleBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                            <br>
                            <li id="removeRoleBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select id="assignSelect" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
							<c:forEach items="${roles }" var="role">
								<option value="${role.id }">${role.name }</option>
							</c:forEach>>
                    </select>
				  </div>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
		</div>
	  </div>
	</div>
  
  <%@include file="/include/common-js.jsp"%>
	<script type="text/javascript">
		$("#addRoleBtn").click(function() {
			var rids="";
			$("#unAssignSelect option:selected").each(function(){
				rids+=$(this).val()+",";
			});
			
			//拿用户id  1通过session域  2通过请求参数
			//EL表达式，取请求参数中的某个值
			var uid="${param.id}";
			location.href="${ctx}/user/assign/role?uid="+uid+"&rids="+rids;
		});
		
		
		$("#removeRoleBtn").click(function() {
			var rids="";
			$("#assignSelect option:selected").each(function(){
				rids+=$(this).val()+",";
			});
			
			//拿用户id  1通过session域  2通过请求参数
			//EL表达式，取请求参数中的某个值
			var uid="${param.id}";
			location.href="${ctx}/user/unassign/role?uid="+uid+"&rids="+rids;
		});
	</script>








</body>
</html>
