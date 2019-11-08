<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<style type="text/css">
div.card-title {
	text-transform: uppercase;
	font-size: medium;
}

.table-no {
	text-align: center;
}

/* .card-card-head{
	padding-left: 20px !important;
	height: 10px !important;
} */
</style>
</head>

<body>
	<c:url value="/getTablesByCatId" var="getTablesByCatId"></c:url>
	<c:url value="/getAllMenuItems" var="getAllMenuItems"></c:url>
	<c:url value="/getItemByCode" var="getItemByCode"></c:url>
	

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
								<span class="input-group-prepend"> <span
									class="input-group-text"> <i class="icon-calendar22">&nbsp;&nbsp;</i>${currdate}</span>
								</span>
							</div>

							<div class="col-md-6">

								<select class="form-control form-control-lg select"
									data-container-css-class="select-lg" data-fouc name="table_cat"
									id="table_cat" onchange="getTablesByCat()">
									<option value="0">All Tables</option>
									<c:forEach items="${tableCatList}" var="tableCatList">
										<option value="${tableCatList.tableCatId}">${tableCatList.tableCatName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-11">
							<div class="card">
								<div class="card-header header-elements-inline">
									<h5 class="card-title">Busy Tables</h5>
									<div class="header-elements">
										<div class="list-icons">
											<a class="list-icons-item" data-action="collapse"></a> <a
												class="list-icons-item" data-action="reload"></a>
											<!-- <a
												class="list-icons-item" data-action="remove"></a> -->
										</div>
									</div>
								</div>



								<!-- Single icon -->
								<div class="card-body">

									<div class="row" id="busy_table">
										<%-- <c:forEach items="${busyTableList}" var="tableList">
										<div class="col-sm-6 col-lg-2">
											<div class="card border-1 border-primary">
												<div class="card-img-actions m-1">
														<h3 class="table-no">${tableList.tableName} - <i class="fas fa-rupee-sign">&nbsp; ${tableList.totalAmt}</i></h3>		
												<div class="card-img-actions-overlay card-img">
															<a href="#"  onclick="addMenu()"
																class="btn btn-outline bg-white text-white border-white border-2 btn-icon rounded-round"
																data-popup="lightbox" rel="group"> <i
																class="icon-plus3"></i>
															</a> <a href="#"
																class="btn btn-outline bg-white text-white border-white border-2 btn-icon rounded-round ml-2">
																<i class="icon-link"></i>
															</a>
														</div>
												</div>
											</div>
										</div>
									</c:forEach>	 --%>
									</div>
								</div>
							</div>
						</div>

						<div class="col-md-1" id="free_table">

							<%-- <c:forEach items="${tableList}" var="tableList">

								
								<p><button type="button" class="btn btn-success btn-md">${tableList.tableName}</button></p>
							</c:forEach>  --%>
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
		function getTablesByCat() {
			var tableCat = document.getElementById("table_cat").value;
			//	alert(tableCat);
			var tab_btn = "";
			var busy_tab = "";
			if (tableCat != null) {

				$
						.getJSON(
								'${getTablesByCatId}',
								{
									tableCat : tableCat,
									ajax : 'true',
								},

								function(data) {

									//alert("Busy Tabl List:"+JSON.stringify(data.busyTables));

									//var len = data.freeTables.length;	

									for (var j = 0; j < data.freeTables.length; j++) {

										tab_btn += '<p><button type="button" class="btn btn-success btn-md"  onclick="addMenu()">'
												+ data.freeTables[j].tableName
												+ '</button></p>';

									}
									$('#free_table').html(tab_btn);
									// $("#free_table").trigger("chosen:updated");

									for (var i = 0; i < data.busyTables.length; i++) {
										busy_tab += '<div class="col-sm-6 col-lg-2">'
												+ '<div class="card border-1 border-primary">'
												+ '<div class="card-img-actions m-1">'
												+ '<h3 class="table-no">'
												+ data.busyTables[i].tableName
												+ '-<i class="fas fa-rupee-sign">&nbsp;'
												+ data.busyTables[i].totalAmt
												+ '</i></h3>'
												+ '<div class="card-img-actions-overlay card-img">'
												+ '<a href="#"  onclick="addMenu()"class="btn btn-outline bg-white text-white border-white border-2 btn-icon rounded-round" data-popup="lightbox" rel="group">'
												+ ' <i class="icon-plus3"></i> </a>'
												+ '<a href="#" class="btn btn-outline bg-white text-white border-white border-2 btn-icon rounded-round ml-2"> <i class="icon-link"></i></a>'
												+ '</div></div></div></div>';
									}
									$('#busy_table').html(busy_tab);
								});

			}//end of if

		}
		

		function addMenu() {

			$.getJSON('${getAllMenuItems}', {
				ajax : 'true',
			}, function(data) {
				$("#menuTable tbody").empty();
				//alert("data "+JSON.stringify(data));

				var len = data.length;

				for (var i = 0; i < len; i++) {
					var tr_data = '<tr> <td>' + (i + 1) + '</td>' + '<td>'
							+ data[i].itemName + '</td>'
							+ '<td><a href="#" onclick="call()">'
							+ data[i].mrpRegular + '</a></td></tr>';
					$('#menuTable' + ' tbody').append(tr_data);
				}

			});
			$("#modal_scrollable").modal('show');
		}
	</script>

	<!-- Menu modal -->
	<div id="modal_scrollable" class="modal fade" tabindex="-1">
		<div class="modal-dialog modal-full">
			<div class="modal-content">
				<div class="modal-header pb-3">
					<h5 class="modal-title">Order Order</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<div class="row">
						<div class="col-md-6">
							<!-- Basic layout-->
							<div class="card">
								<div class="card-header header-elements-inline">
									<h6 class="card-title">Add Items</h6>
								</div>

								<div class="card-body">
									<div class="row">
										<div class="col-md-2">
											<!-- 	<label for="itemCode">Item Code :</label> -->
											<input type="text" name="itemCode" id="itemCode" required
												class="form-control" maxlength="4" onchange="trim(this)"
												placeholder="Item Code">
										</div>
										<!-- <div class="col-md-3">
											<label for="itemName">Item Name :</label> 
											<input type="text" name="itemName" readonly id="itemName"
												required class="form-control" maxlength="25"
												onchange="trim(this)" placeholder="Item Name">
										</div> -->
										<div class="col-md-1">
											<!-- <label for="itemQty">Qty :</label> -->
											<input type="text" name="itemQty" id="itemQty" required
												class="form-control" maxlength="4" onchange="trim(this)"
												placeholder="Qty">
										</div>

										<div class="col-md-4">
											<!-- 	<label for="catId">Select Remark :</label> -->
											<select id="itemRemark" name="itemRemark" required
												class="form-control form-control-lg select"
												data-container-css-class="select-lg" data-fouc="orderTable">

												<option>with Ice cream</option>
												<option>without Ice cream</option>
												<option>plain</option>
												<option>without sugar</option>
												<option>without ice</option>
												<option>parcel</option>
												<option>1/2</option>
												<option>2/4</option>
												<option>no tuti fruity</option>
											</select>
										</div>
										<div class="col-md-1">
											
												<i class="icon-add" onclick="getItenNameByCode()"></i>
											
										</div>
									</div>

									<!-- Table -->
									<table class="table datatable-basic" id="menuTable">
										<thead>
											<tr>
												<th>Sr No.</th>
												<th>Item Name</th>
												<th>Price</th>
											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>
								</div>
							</div>
							<!-- Table -->
						</div>

						<div class="col-md-6">
							<div class="card">
								<div class="card-header header-elements-inline">
									<h6 class="card-title">Ordered Items</h6>
								</div>
								<div class="card-body">
									<!-- Table orderTable -->
									<table class="table datatable-basic" id="orderTable">
										<thead>
											<tr>
												<th>Sr No.</th>
												<th>Item Name</th>
												<th>Qty</th>
												<th>Action</th>

												<!-- <th class="text-center">Actions</th> -->
											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>
									<!-- Table orderTable -->
									<button type="button" class="btn btn-primary" onclick="placeOrder()">Place Order</button>
									
								</div>
							</div>

						</div>
					</div>


				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
					<button type="button" class="btn bg-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /Menu modal -->

</body>
<script type="text/javascript">
$('#itemQty').on('input', function() {
	 this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
	});
	
	function placeOrder(){
		$.ajax({
		       type: "POST",
		            url: "${pageContext.request.contextPath}/placeOrder",
		            data: $("#modalfrm").serialize(),
		            dataType: 'json',
		    success: function(data){
		    	
		    }
		    })

		
	}
function getItenNameByCode(){
	
	var itemCode=document.getElementById("itemCode").value;
	var itemQty=document.getElementById("itemQty").value;
	var itemRemark=document.getElementById("itemRemark").value;
	
	$.getJSON('${getItemByCode}', {
		itemCode: itemCode,
		itemQty : itemQty,
		itemRemark : itemRemark,
		ajax : 'true',
	}, function(data) {
		alert(JSON.stringify(data));
		if(data[0].itemId==0){
			alert("Item Not Found");
		}else{
			
			 $("#orderTable tbody").empty();
				//alert("data "+JSON.stringify(data));

				var len = data.length;

			 	for (var i = 0; i < len; i++) {
					var tr_data = '<tr> <td>' + (i + 1) + '</td>' + '<td>'
							+ data[i].itemName +'-'+data[i].remark+ '</td>'+'<td>' + data[i].quantity + '</td>'+ '<td><a href="#" title="delete" onclick="call('+i+')">'
							+ '<i class="fa fa-trash"></i>'+ '</a></td></tr>';
					$('#orderTable' + ' tbody').append(tr_data);
				} 
		}
	
	} );
	
}
function call(vale) {
	alert("hi"+vale);
}
</script>

</html>

<!-- function addMenu(){
			
				$
						.getJSON(
								'${getAllMenuItems}',
								{									
									ajax : 'true',
								},
								function(data) {
									$("#menuTable tbody").empty();
									alert("data "+JSON.stringify(data));
									
									 /*  var dataTable = $('#menuTable')
									.DataTable();
									dataTable.clear().draw();  */ 
									 var len = data.length;
									alert(data.length);
									
									 for (var i = 0; i < len; i++) {
										var tr_data += '<tr> <td>'+(i+1)+'</td>'+
										'<td>'+data[i].itemName+'</td>'+
										'<td><a href="#">'+data[i].mrpRegular+'</a></td></tr>';
										$('#menuTable' + ' tbody').append(tr_data);
									} 
								/*  $.each(data,function(i, v) {
										dataTable.row
										.add(
										[i + 1,
										v.itemName,
										v.mrpRegular
										]).draw();
									});   */
									
							      }); 
				$("#modal_scrollable").modal('show'); 
		} -->
