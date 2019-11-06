<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<style type="text/css">
div.card-title{
	text-transform:uppercase;
	font-size: medium;
}

.bill-btn{
text-align: center !important;
font-size: 15px !important;
color: white !important;
}

/* .card-card-head{
	padding-left: 20px !important;
	height: 10px !important;
} */
</style>
</head>

<body >
<%-- <c:url value="/getTablesByCatId" var="getTablesByCatId"></c:url>  --%>
	<!-- Main navbar -->
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<!-- /main navbar -->


	<!-- Page content -->
	<div class="page-content">

		<!-- Main sidebar -->
		<jsp:include page="/WEB-INF/views/include/left.jsp"></jsp:include>
		<!-- /main sidebar -->


		<!-- Main content -->
		<div class="content-wrapper">

			<!-- Page header -->
			<div class="page-header page-header-light">
				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">

				</div>
			</div>
			<!-- /page header -->
			<!-- Content area -->
			<div class="content">
				<!-- Form validation -->
				
					<div class="col-md-12">	
						
						<div class="mb-3 pt-2">
							<div class="row">
								<div class="col-md-6">
									<!-- <label>Date:</label> -->									
										<span class="input-group-prepend">
											<span class="input-group-text">
												<i class="icon-calendar22">&nbsp;&nbsp;</i>${currdate}</span>
										</span>		
								</div>
								
								<div class="col-md-6">
									<label>Select Table</label>
									<select class="form-control form-control-lg select" data-container-css-class="select-lg" data-fouc
									name="table_cat" id="table_cat" onchange="getTablesByCat()">
										<option value="0">All Tables</option>
										<c:forEach items="${tableCatList}" var="tableCatList">
											<option value="${tableCatList.tableCatId}">${tableCatList.tableCatName}</option>
										</c:forEach>										
									</select>
								</div>
							</div>
				</div>

				<div class="row">
					<div class="col-md-10">
						<div class="card">
							<div class="card-header header-elements-inline">
								<h5 class="card-title">Busy Tables</h5>
								<div class="header-elements">
									<div class="list-icons">
				                		<a class="list-icons-item" data-action="collapse"></a>
				                		<a class="list-icons-item" data-action="reload"></a>
				                		<a class="list-icons-item" data-action="remove"></a>
				                	</div>
			                	</div>
							</div>
							
							<!-- Single icon -->
					<div class="row">
					<div class="col-md-3">
						<div class="card">
							<div class="card-header bg-blue header-elements-inline" onclick="call()">
								  <span class="bill-btn">S1</span>
                                  <span class="bill-btn"><i class="fas fa-rupee-sign mr-3 fa-1x">&nbsp; 200</i></span>
                                  <span class="bill-btn">Bill</span>
							</div>
						</div>
					</div>
						
						<div class="col-md-3">
						<div class="card">
							<div class="card-header bg-blue header-elements-inline" onclick="call()">
								<span class="bill-btn">F1</span>
                                <span class="bill-btn"><i class="fas fa-rupee-sign mr-3 fa-1x">&nbsp; 150</i></span>
                                 <span class="bill-btn">Bill</span>
							</div>
						</div>
						</div>
						
						<div class="col-md-3">
						<div class="card">
							<div class="card-header bg-blue header-elements-inline" onclick="call()">
								<span class="bill-btn">2</span>
                                <span class="bill-btn"><i class="fas fa-rupee-sign mr-3 fa-1x">&nbsp; 300</i></span>
                                <span class="bill-btn">Bill</span>
							</div>
						</div>
						</div>
						
						<div class="col-md-3">
						<div class="card">
							<div class="card-header bg-blue header-elements-inline" onclick="call()">
								<span class="bill-btn">2</span>
                                <span class="bill-btn"><i class="fas fa-rupee-sign mr-3 fa-1x">&nbsp; 300</i></span>
                                <span class="bill-btn">Bill</span>
							</div>
						</div>
						</div>
						
						<div class="col-md-3">
						<div class="card">
							<div class="card-header bg-blue header-elements-inline" onclick="call()">
								<span class="bill-btn">2</span>
                                <span class="bill-btn"><i class="fas fa-rupee-sign mr-3 fa-1x">&nbsp; 300</i></span>
                                <span class="bill-btn">Bill</span>
							</div>
						</div>
						</div>
						
						<div class="col-md-3">
						<div class="card">
							<div class="card-header bg-blue header-elements-inline" onclick="call()">
								<span class="bill-btn">2</span>
                                <span class="bill-btn"><i class="fas fa-rupee-sign mr-3 fa-1x">&nbsp; 300</i></span>
                                <span class="bill-btn">Bill</span>
							</div>
						</div>
						</div>
					</div>
						
						
						
						</div>
					</div>

					<div class="col-md-2">
					<c:forEach items="${tableList}" var="tableList">
						<div class="card card-body">
							<div class="media">
								<div class="mr-3 align-self-center">
										<i class="fas fa-utensils mr-3 fa-2x"></i>
								</div>
								
								<div class="media-body text-right">
									<h3 class="font-weight-semibold">${tableList.tableName}</h3>
										<span class="text-uppercase font-size-sm text-muted"></span>
								</div>
							</div>
						</div>										
					</c:forEach>		
					</div>
				</div>
				<!-- /select2 sizing -->	
					</div>
				
		</div>
			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
<script type="text/javascript">
function getTablesByCat(){	
	var tableCat = document.getElementById("table_cat").value;
	//alert(tableCat);
	
	if (tableCat != null) {

		$
				.getJSON(
						'${getTablesByCatId}',
						{
							tableCat : tableCat,
							ajax : 'true',
						},

						function(data) {
							//alert("TableList:"+JSON.stringify(data))

						});

	}//end of if
	
} 
function call() {
	alert("hi");
}
</script>

</body>
</html>