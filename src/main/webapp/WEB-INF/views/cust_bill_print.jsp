<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Bill</title>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>
    </title>
    </head>
<style type="text/css">
<!--
.style2 {font-size: 12px}
.style5 {font-size: 10px}
.style6 {font-size: 9px}
.style7 {
	font-size: 11px;
	font-weight: normal;
}
.style8 {
	font-size: 11px;
	font-weight: normal;
}
-->
</style>
</head>

</head>
<body onload="directPrint()" >
	 
				  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:0px; font-family:verdana; font-size:11px; border:1px solid #E7E7E7;">

  <tbody> 
 <!-- <tr>
  <td align="right" style="padding:3px; padding-bottom:4px;  font-size: 7px;">EX</td>  </tr> --><tr >
      <td colspan="2" align="center" style=" border-bottom:0px solid #E7E7E7;">
        Samarth Juice Center   </td>  
    </tr>
    <tr>
      <td colspan="2" align="left" style="padding:0px; border-bottom:0px solid #E7E7E7;">
      <span style="font-size: 10px; font-family: Arial;">Date :- ${curDtTime}</span>
          <%--   <span style="font-size: 10px;"> GSTIN:<strong>${sessionScope.frDetails.frGstNo}</strong></span><br/> --%>
       </td>
    </tr>
    <tr>
      <td colspan="2" align="left" style="padding:1px;font-family: Arial; border-bottom:0px solid #E7E7E7; font-size:10px;"><span style="font-size:10px;">
              
          Invoice No :- <strong class="style8">${billNo.message}</strong>
          </span>
        
       
    </tr>
    <tr>
      <td colspan="2">
      <table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tbody>
    <tr>
      <td align="left" style="font-size:10px">Table No:${tableName} </td>
     <!--  <td align="left" style="font-size:10px">55 </td> -->
    <%--   <td style="font-size:10px">${date} </td> --%>
    </tr >
  
    <tr>
      <td colspan="4"><table width="100%" border="0" cellspacing="0" cellpadding="2" class="tbl-inner">
        <tbody>
          <tr >
            <th style="border-bottom:1px dotted; font-weight: normal;" width="43%" align="left" bgcolor="#ECECEC">Item</th>
            <th style="border-bottom:1px dotted;font-weight: normal;" width="8%" bgcolor="#ECECEC">Qty</th>
            <th style="border-bottom:1px dotted;font-weight: normal;" width="20%" bgcolor="#ECECEC">Rate</th>
            <th style="border-bottom:1px dotted;font-weight: normal;" width="22%" align="right" bgcolor="#ECECEC">Amt</th>
          </tr>
        <c:set var="tot" value="0"></c:set>
          <c:forEach items="${billDetail}" var="billDetailList" varStatus="count"> 
                  <c:set var="tot" value="${tot+billDetailList.total}"></c:set>
          
          <tr>
            <td><span style="font-size:10px">${billDetailList.itemName}</span><br><%-- <span style="font-size:7px">
			<br>HSN-${exBill.remark}</span> --%></td>
            <td align="center"><span style="font-size:10px">${billDetailList.quantity}</span></td>
            <td align="center"><span style="font-size:10px">${billDetailList.rate}</span></td>
            <td align="right"><span style="font-size:10px">${billDetailList.total}</span></td>
          </tr>
          </c:forEach>
          <%--  <tr>
            <td><span style="font-size:10px">Item 1</span><br><span style="font-size:7px">
			<br>HSN-${exBill.remark}</span></td>
            <td align="center"><span style="font-size:10px">2</span></td>
            <td align="center"><span style="font-size:10px">34</span></td>
            <td align="right"><span style="font-size:10px">68</span></td>
          </tr>
           <tr>
            <td><span style="font-size:10px">Item 1</span><br><span style="font-size:7px">
			<br>HSN-${exBill.remark}</span></td>
            <td align="center"><span style="font-size:10px">2</span></td>
            <td align="center"><span style="font-size:10px">34</span></td>
            <td align="right"><span style="font-size:10px">68</span></td>
          </tr> --%>
        <%--   </c:forEach> --%>
          <tr>
            <td style="border-top:1px dotted;"  rowspan="3">&nbsp;</td>
            <td style="border-top:1px dotted;" colspan="2" align="right"><span class="style5">Total : </span></td>
            <td style="border-top:1px dotted;"  align="right"><span class="style5"><fmt:formatNumber type="number" maxFractionDigits="1" minFractionDigits="1"  value="${tot}"/></span></td>
          </tr>
           <tr>
            <td colspan="2" align="right"><span class="style7">Discount % :</span></td>
            <td align="right"><span class="style7"> <fmt:formatNumber type="number" maxFractionDigits="1" minFractionDigits="1"  value="00"/></span></td>
          </tr>
          <tr>
          
            <td   colspan="2" align="right"><span class="style7">Grand Total : </span></td>
            <td    align="right"><span class="style7"> <fmt:formatNumber type="number" maxFractionDigits="1" minFractionDigits="1"  value="${tot}"/></span></td>
          </tr>
        </tbody>
      </table></td>
      </tr>
  </tbody>
</table>      </td>
    </tr>
     <%--  <c:choose>
      <c:when test="${frGstType==10000000 }">
    		<tr>
				<td colspan="2"><table width="100%" border="0" cellspacing="0"
						cellpadding="2">
						<tr>
							<th width="17%" align="left" bgcolor="#ECECEC" rowspan="2">Taxable<br />
								Value
							</th>
							<th bgcolor="#ECECEC" colspan="2">CGST</th>
							<th bgcolor="#ECECEC" colspan="2">SGST</th>
							<th width="25%" align="center" bgcolor="#ECECEC">Total</th>
						</tr>

						<tr>
							<th width="14%" bgcolor="#ECECEC">%</th>
							<th width="15%" bgcolor="#ECECEC">Amt</th>
							<th width="16%" bgcolor="#ECECEC">%</th>
							<th width="13%" bgcolor="#ECECEC">Amt</th>
							<th width="25%" align="center" bgcolor="#ECECEC">GST</th>
						</tr>
						<c:set var="taxAmount" value="${0}" />
						<c:set var="totaltax" value="${0 }" />
						<c:set var="cgst" value="${0 }" />
						<c:set var="sgst" value="${0 }" />
						<c:forEach items="${custBilltax}" var="custBilltax"
							varStatus="count">
							<tr>
								<td>${custBilltax.taxableAmt}</td>
								<c:set var="taxAmount"
									value="${taxAmount + custBilltax.taxableAmt}" />
								<td>${custBilltax.cgstPer}</td>
								<td>${custBilltax.cgstRs}</td>
								<c:set var="cgst" value="${cgst+custBilltax.cgstRs }" />
								<td>${custBilltax.sgstPer}</td>
								<td>${custBilltax.sgstRs}</td>
								<c:set var="sgst" value="${sgst+custBilltax.sgstRs }" />
								
								<td align="center"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"  value="${custBilltax.cgstRs+custBilltax.sgstRs}" /></td>
								<c:set var="totaltax"
									value="${totaltax+custBilltax.sgstRs+custBilltax.cgstRs }" />
							</tr>
						</c:forEach>
						
						<tr>
							<td bgcolor="#ECECEC"><b><fmt:formatNumber type="number"
										maxFractionDigits="2" minFractionDigits="2"  value="${taxAmount}" /></b></td>

							<td bgcolor="#ECECEC"></td>
							<td bgcolor="#ECECEC"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"  value="${cgst}" /></td>
							<td bgcolor="#ECECEC"></td>
							<td bgcolor="#ECECEC"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"  value="${sgst}" /></td>
							<td align="center" bgcolor="#ECECEC"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"  value="${totaltax}" /></td>
						</tr>
						
					</table></td>
			</tr>
			</c:when>
			</c:choose> --%>
 <%-- <tr>
							<td align="center"
								style="border-top: 1px solid #E7E7E7; padding: 2px;"
								colspan="6"><span class="style6"> Customer Care:7352244444
									</span></td>
						</tr>
						<tr>
							<td style="border-top: 1px solid #E7E7E7; padding: 2px; font-size: 9px;"
								colspan="6">Kindly consume all Fresh Cream Product within 1 hour unless refrigerated<br />This is not a GST Invoice. Dealer prepares a consolidated Tax Invoice as per GST laws applicable.<br/>For GST bill kindly demand a "Customer Bill" from seller.<br/>Seller Registered under Composition Scheme not allowed to collect taxes. <span style="font-size: 10px">
								</span>
							</td>
						</tr>
    <tr>
      <td width="200" align="center" style="border-top:1px solid #E7E7E7; padding:2px;"><strong>${sessionScope.frDetails.frName}</strong></td>
    </tr> --%>
  </tbody>
</table>
			</body>	
	<script>
	 function directPrint()
	{
		 
		window.print();
		//window.close();
	} 
	
	</script>

</html>