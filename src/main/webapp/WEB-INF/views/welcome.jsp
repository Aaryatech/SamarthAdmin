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

#menuTable tr:hover:nth-child(odd)
{
    background: orange;
}

#menuTable tr:hover:nth-child(even)
{
    background: yellow;
}


</style>
</head>

<body class="sidebar-xs">
	<c:url value="/getTablesByCatId" var="getTablesByCatId"></c:url>
	<c:url value="/getAllMenuItems" var="getAllMenuItems"></c:url>
	<c:url value="/getItemByCode" var="getItemByCode"></c:url>
    <c:url value="/getOrderDataByTableId" var="getOrderDataByTableId"></c:url>
	
	
	
	
	<c:url value="/getOrderItemList" var="getOrderItemList"></c:url>
	<c:url value="/saveBill" var="saveBill"></c:url>

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
												class="list-icons-item" data-action="reload" onclick="getTablesByCat()"></a>
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

										tab_btn += '<p><button type="button" class="btn btn-success btn-md"  onclick="addMenu('+data.freeTables[j].tableNo+','+data.freeTables[j].tableId+',\''+data.freeTables[j].tableName+'\')">'
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
												+ '<a href="#" onclick="addMenu('+data.busyTables[i].tableNo+','+data.busyTables[i].tableId+',\''+data.busyTables[i].tableName+'\')"  class="btn btn-outline bg-white text-white border-white border-2 btn-icon rounded-round" data-popup="lightbox" rel="group">'
												+ ' <i class="icon-plus3"></i> </a>'
												+ '<a href="#" onclick="genBill('+data.busyTables[i].tableNo+',\''+data.busyTables[i].tableName+'\')" class="btn btn-outline bg-white text-white border-white border-2 btn-icon rounded-round ml-2"> <i class="icon-link"></i></a>'
												+ '</div></div></div></div>';
									}
									$('#busy_table').html(busy_tab);
								});

			}//end of if

		}
		

		
	var tabNo;
function genBill(tableNo, tableName){
	//alert("Bill Table----"+tableNo+":"+tableName);
	tabNo = tableNo;
	$
	.getJSON(
			'${getOrderItemList}',
			{		
				tableNo : tableNo,
				ajax : 'true',
			},
			function(data) {
//				alert("data "+JSON.stringify(data[0]));
				$("#billTable tbody").empty();				
			var tot=0;
			 	 for (var i = 0; i < data.length; i++) {				 	
					tot=tot+data[i].orderTotal;
			 		for (var j = 0; j < data[i].orderDetailsList.length; j++) {				 		
			 			//alert(data[i].orderDetailsList[j].total+"-"+data[i].orderDetailsList[j].rate)
			 			
			 			 $("#billTable tbody").append("<tr><td>" + data[i].orderDetailsList[j].itemName + "</td><td>" + data[i].orderDetailsList[j].quantity + "</td>"+
			 					 "<td>" + parseFloat(data[i].orderDetailsList[j].rate) + "</td><td>" + parseFloat(data[i].orderDetailsList[j].total) + "</td></tr>");
			 		
			 	  }
			 		
			 		
				}	
			 	document.getElementById("order_date").innerHTML = data[0].orderDate;
		 		document.getElementById("order_amt").innerHTML =tot;// parseFloat(data[i].orderTotal);
									
		      }); 
	document.getElementById("tab_no").innerHTML = tableName;
	$("#bill_modal_scrollable").modal('show'); 
}

function saveOrder(){
	/* loader Start */	
	$("#card").block({
        message: '<i class="icon-spinner9 spinner"></i>',
        overlayCSS: {
            backgroundColor: '#1B2024',
            opacity: 0.85,
            cursor: 'wait'
        },
        css: {
            border: 0,
            padding: 0,
            backgroundColor: 'none',
            color: '#fff'
        }
    });		
    /* loader End */
    
	var discount = $("#discount").val();
	//alert(discount+" "+tabNo);
	document.getElementById("myBtn").disabled = true;
	$("#loader").show();
	$
	.getJSON(
			'${saveBill}',
			{		
				tabNo:tabNo,
				discount : discount,
				ajax : 'true',
			},
			function(data) {
				//alert(data)
					if(data==1){						
						
						$("#bill_modal_scrollable").modal('hide');
						$("#card").unblock();
						document.getElementById("myBtn").disabled = false;
						getTablesByCat();
						window.open("${pageContext.request.contextPath}/printBill");
						
						
					}else{
						$("#bill_modal_scrollable").modal('hide');
						getTablesByCat();
					}
		      }); 
}
	</script>

	<!-- Menu modal -->
	<div id="modal_scrollable" class="modal fade" tabindex="-1">
	<form id="placeOrderForm" >
	<input type="hidden" id="placeOrderTableId" name="placeOrderTableId" value="0">
		<input type="hidden" id="placeOrderTableNo" name="placeOrderTableNo" value="0">
	
	
	
	
		<div class="modal-dialog modal-full">
			<div class="modal-content">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
				<!-- <div class="modal-header pb-3">
					<h5 class="modal-title">Order Order</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div> -->

				<div class="modal-body py-0">
					<div class="row">
						<div class="col-md-6">
							<!-- Basic layout-->
							<div class="card">
							
								<div class="card-header header-elements-inline">
									<h6 class="card-title" id="table_Ord_no"></h6>
								</div>

								<div class="card-body">
									<div class="row">
										<div class="col-md-2">
											<!-- 	<label for="itemCode">Item Code :</label> -->
											<input list="itemList" type="text" name="itemCode" id="itemCode" required
												class="form-control" maxlength="4" onchange="trim(this)"
												placeholder="Item Code"  tabindex="1">
												
												<datalist id="itemList" style="background-color: white">
												
												</datalist>
												
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
												placeholder="Qty"  tabindex="2">
										</div>

										<div class="col-md-4">
											<!-- 	<label for="catId">Select Remark :</label> -->
											<select id="itemRemark" name="itemRemark" required
												class="form-control form-control-lg select"
												data-container-css-class="select-lg" data-fouc="orderTable"  tabindex="3">

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
												<button type="button"  tabindex="4" onclick="getItenNameByCode()"><i class="icon-add"></i></button>
										</div>
									</div>

									<!-- Table -->
									<table class="table datatable-basic1" id="menuTable">
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
								<!-- <div class="card-header header-elements-inline">
									<h6 class="card-title">Ordered Items</h6>
								</div> -->
								<div class="card-body">
									<!-- Table orderTable -->
									<table class="table datatable-basic1" id="orderTable">
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
									<button type="button" class="btn btn-primary" id="placeOrderButton" onclick="placeOrder()">Place Order</button>
									
								</div>
							</div>
							
							
							<div class="card">
								<!-- <div class="card-header header-elements-inline">
									<h6 class="card-title">Ordered Items</h6>
								</div> -->
								<div class="card-body">
									<!-- Table prevOrderTable -->
									<table class="table datatable-basic1" id="prevOrderTable">
										<!-- <thead>
											<tr>
												<th>Item Name</th>
												<th>Qty</th>
													<th>Rate</th>
														<th>Total</th>
											
												<th class="text-center">Actions</th>
											</tr>
										</thead> -->
										<tbody>

										</tbody>
									</table>
										<!-- Table prevOrderTable -->
								
									
								</div>
							</div>

						</div>
					</div>


				</div>

				<div class="modal-footer pt-3">
				</div>
			</div>
		</div>
		</form>
	</div>
	<!-- /Menu modal -->
	
	<!-- Bill modal -->
				<div id="bill_modal_scrollable" class="modal fade" tabindex="-1">
					<div class="modal-dialog modal-dialog-scrollable">
						<div class="modal-content">
							<div class="modal-header pb-3">
								<h6 class="modal-title col-md-4">Date: <span id="order_date"></span></h6>
								<h5 class="modal-title col-md-4">Table No. <span id="tab_no"></span></h5>
								<h5 class="modal-title col-md-3"><i class="fas fa-rupee-sign">&nbsp;:&nbsp; <span id="order_amt"></span></i></h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body py-0" id="card">
								
							<!-- Table -->
							<table class="table datatable-basic" id="billTable">
						<thead>
							<tr>								
								<th>Item Name</th>
								<th>Qty</th>
								<th>Price</th>
								<th>Total</th>
								<!-- <th class="text-center">Actions</th> -->
							</tr>
						</thead>
						<tbody>					
							
						</tbody>
					</table>
							<!-- Table -->
							</div>

							<div class="modal-footer pt-3">
							<label class="col-form-label">Discount</label>									
								<input type="text" id="discount" name="discount" value="${disc}"><!-- class="form-control"  -->	
								<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
								<button type="button" class="btn bg-primary" onclick="saveOrder()" id="myBtn">Generate Bill</button>
							</div>
						</div>
					</div>
				</div>
				<!-- bill modal -->

</body>
<script type="text/javascript">
$('#itemQty').on('input', function() {
	 this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
	});
	
	function placeOrder(){
		
		var rowCount = $('#orderTable tr').length;
		if(rowCount>1){
		document.getElementById("placeOrderButton").disabled = true;
		$.ajax({
		       type: "POST",
		            url: "${pageContext.request.contextPath}/placeOrder",
		            data: $("#placeOrderForm").serialize(),
		            dataType: 'json',
		    success: function(data){
		    	//alert(data);

		    }
		    }).done(function() {
		    	var tableNo=document.getElementById("placeOrderTableNo").value;
		    	//alert("tableNo " +tableNo)
		    		showPrevOrdersByTableNo(tableNo);
		    		$("#orderTable tbody").empty();
		    		document.getElementById("placeOrderButton").disabled = false;
		    		document.getElementById("itemCode").value=null;
		    		document.getElementById("itemQty").value=null;
		    		//getTablesByCat();
		    		
		            });
		}//end of if
		else{
			alert("Please add Item First")
    		document.getElementById("placeOrderButton").disabled = false;

		}
	}
function getItenNameByCode(){
	//$("itemCode").focus();
	var itemCode=document.getElementById("itemCode").value;
	var itemQty=document.getElementById("itemQty").value;
	var itemRemark=document.getElementById("itemRemark").value;
	var placeOrderTableId =document.getElementById("placeOrderTableId").value;
	valid=true;
	if(itemCode==null || itemCode==""){
		alert("Please Enter Item Code");
		valid=false;
	}
	if(itemQty==null || itemQty<1){
		alert("Please Enter Item Quatity");
		valid=false;
	}
if(valid==true)
	$.getJSON('${getItemByCode}', {
		itemCode: itemCode,
		itemQty : itemQty,
		itemRemark : itemRemark,
		placeOrderTableId : placeOrderTableId,
		ajax : 'true',
	}, function(data) {
		//alert(JSON.stringify(data));
		if(data[0].itemId==0){
			alert("Item Not Found");
		}else{
			
			document.getElementById("itemCode").value=null;
    		document.getElementById("itemQty").value=null;
    		
			 $("#orderTable tbody").empty();
				//alert("data "+JSON.stringify(data));

				var len = data.length;

			 	for (var i = 0; i < len; i++) {
					var tr_data = '<tr> <td>' + (i + 1) + '</td>' + '<td>'
							+ data[i].itemName +' ['+data[i].remark+ ']</td>'+'<td>' + data[i].quantity + '</td>'+ '<td><a href="#" title="delete" onclick="call('+i+')">'
							+ '<i class="fa fa-trash"></i>'+ '</a></td></tr>';
					$('#orderTable' + ' tbody').append(tr_data);
				} 
		}
	
	} );
	
}
function call(vale) {
	//alert("hi In delete To be done"+vale);
	var placeOrderTableId =document.getElementById("placeOrderTableId").value;
	getOrderDataByTableId(placeOrderTableId,vale);
}

function addMenu(tableNo,tableId,tableName){
	//table_Ord_no
	document.getElementById("table_Ord_no").innerHTML=tableName + " Add Items For Order";
	$
			.getJSON(
					'${getAllMenuItems}',
					{									
						ajax : 'true',
					},
					function(data) {
						$("#menuTable tbody").empty();
						//alert("data "+JSON.stringify(data));	
						 var html="";

						 var len = data.length;		
						
					 	 for (var i = 0; i < len; i++) {
							var tr_data = '<tr> <td>'+(i+1)+'</td>'+
							'<td>'+data[i].itemName+ ' ['+data[i].itemDesc+']</td>'+
							'<td><a href="#">'+data[i].mrpRegular+'</a></td></tr>';
							$('#menuTable' + ' tbody').append(tr_data);
							                    

	                        html += '<option value="' + data[i].itemDesc + '">';

	                    }
					 	// alert(html);
						
		                    $('#itemList').html(html);
		                   // $("#itemList").trigger("chosen:updated");

				      }); 
	$("#modal_scrollable").modal('show'); 
	
	document.getElementById("placeOrderTableId").value=tableId;
	document.getElementById("placeOrderTableNo").value=tableNo;
	//alert("tableNo " +tableNo)
		showPrevOrdersByTableNo(tableNo);

	getOrderDataByTableId(tableId,-1);
	// $("#orderTable tbody").empty();
	//getOrderdetail of this table Id 9-11-2019 Sachin
}

function getOrderDataByTableId(tableId,key){
	//alert(key);
	 $("#orderTable tbody").empty();
	$.getJSON('${getOrderDataByTableId}', {
		placeOrderTableId : tableId,
		key : key,
		ajax : 'true',
	}, function(data) {
		//alert(JSON.stringify(data));
		if(data[0].itemId==0){
			alert("Item Not Found");
		}else{
			
			 $("#orderTable tbody").empty();
			
				var len = data.length;

			 	for (var i = 0; i < len; i++) {
					var tr_data = '<tr> <td>' + (i + 1) + '</td>' + '<td>'
							+ data[i].itemName +' ['+data[i].remark+ ']</td>'+'<td>' + data[i].quantity + '</td>'+ '<td><a href="#" title="delete" onclick="call('+i+')">'
							+ '<i class="fa fa-trash"></i>'+ '</a></td></tr>';
					$('#orderTable' + ' tbody').append(tr_data);
				} 
		}
	
	} );
	
}
	function showPrevOrdersByTableNo(tableNo){
	//	alert(tableNo)
		$
		.getJSON(
				'${getOrderItemList}',
				{		
					tableNo : tableNo,
					ajax : 'true',
				},
				function(data) {
				//alert("data "+JSON.stringify(data[0]));
					$("#prevOrderTable tbody").empty();				
				
				 	 for (var i = 0; i < data.length; i++) {
				 		 
				 		 //alert(data[i].orderTotal);
				 		 
	$("#prevOrderTable tbody").append("<tr><th>Item Name [KOT No "+data[i].orderId+"]</th><th>Qty</th><th>Rate</th><th>Total [Total Items "+data[i].orderDetailsList.length+"]</th></tr>");		
					
				 		
				 		for (var j = 0; j < data[i].orderDetailsList.length; j++) {				 		
				 			//alert(data[i].orderDetailsList[j].total+"-"+data[i].orderDetailsList[j].rate)
				 			
				 			 $("#prevOrderTable tbody").append("<tr><td>" + data[i].orderDetailsList[j].itemName + "</td><td>" + data[i].orderDetailsList[j].quantity + "</td>"+
				 					 "<td>" + parseFloat(data[i].orderDetailsList[j].rate) + "</td><td>" + parseFloat(data[i].orderDetailsList[j].total) + "</td></tr>");
				 		
				 	  }
				 	
					}							 
										
			      }); 
	}
	

</script>


</html>


