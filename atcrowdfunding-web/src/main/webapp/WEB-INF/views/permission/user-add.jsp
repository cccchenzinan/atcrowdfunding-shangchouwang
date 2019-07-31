<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet"
	href="${ctx}/static/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctx}/static/css/font-awesome.min.css">
<link rel="stylesheet" href="${ctx}/static/css/main.css">
<link rel="stylesheet" href="${ctx}/static/css/doc.min.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}
</style>
</head>

<body>

	<%
		pageContext.setAttribute("title", "用户维护");
	%>
	<%@include file="/include/top-nav.jsp"%>

	<div class="container-fluid">
		<div class="row">

			<!-- 侧边栏 -->
			<%@include file="/include/side-bar.jsp"%>


			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
					<li><a href="${ctx}/static/#">首页</a></li>
					<li><a href="${ctx}/static/#">数据列表</a></li>
					<li class="active">新增</li>
				</ol>
				<div class="panel panel-default">
					<div class="panel-heading">
						表单数据
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<form role="form" action="${ctx }/user/add" method="post">
							<c:if test="${!empty loginacctmsg }">
								<div class="alert alert-danger" role="alert">${loginacctmsg }</div>
							</c:if>
							<div class="form-group">
								<label for="exampleInputPassword1">登陆账号</label> <input
									type="text" class="form-control" name="loginacct"
									value="${TAdmin.loginacct }" placeholder="请输入登陆账号">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">用户名称</label> <input
									type="text" class="form-control" name="username"
									value="${TAdmin.username }" placeholder="请输入用户名称">
							</div>
							<c:if test="${!empty emailmsg }">
								<div class="alert alert-danger" role="alert">${emailmsg }</div>
							</c:if>
							<div class="form-group">
								<label for="exampleInputEmail1">邮箱地址</label> <input type="email"
									class="form-control" name="email" value="${TAdmin.email }"
									placeholder="请输入邮箱地址">
								<!-- 								<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： -->
								<!-- 									xxxx@xxxx.com</p> -->
							</div>
							<button type="submit" class="btn btn-success">
								<i class="glyphicon glyphicon-plus"></i> 新增
							</button>
							<button type="reset" class="btn btn-danger">
								<i class="glyphicon glyphicon-refresh"></i> 重置
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<%@include file="/include/common-js.jsp"%>
</body>
</html>
