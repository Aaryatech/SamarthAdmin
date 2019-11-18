<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P onclick="buildMessage()">  The time on the server is ${serverTime}. </P>
			<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>


</body>

	
<!-- 	 <script type="text/javascript">
	
	//var canvas = document.getElementById('canvas');
	var printer = null;
	var ePosDev = new epson.ePOSDevice();
	ePosDev.connect('192.168.2.207',9100, cbConnect);
	function cbConnect(data) {
		alert("1"+JSON.stringify(data));
	//	if(data == 'OK') {
			ePosDev.createDevice('local_printer', ePosDev.DEVICE_TYPE_PRINTER, {'crypto' : false, 'buffer' : false}, cbCreateDevice_printer);
		//} else {
			//alert("In else data")
			//alert(data);
		//}
	}
	function cbCreateDevice_printer(devobj, retcode) {
		if( retcode == 'OK' ) {
			printer = devobj;
			executeAddedCode();
		} else {
			alert(retcode);
		}
	}
	function executeAddedCode() {
alert("Laass")
	printer.addText('Hello,222!');
	printer.addText('HHHHHHhasc s');
	printer.send();
	}

	
	</script> --> 
	<!-- <script type="text/javascript">
	
	var printer = null;
	var ePosDev = null;

	function InitMyPrinter() {
		alert("Hi")
	    console.log("Init Printer");

	    var printerPort = 9100;
	    var printerAddress = '192.168.2.207';
	 
	    alert("Hi" +printerPort)
	    ePosDev = new epson.ePOSDevice();
	    ePosDev.connect(printerAddress, printerPort, cbConnect);
	}

	//Printing
	function cbConnect(data) {
		alert("OKdata"+data);
	    if (data == 'OK' || data == 'SSL_CONNECT_OK') {
	    	alert("OK")
	        ePosDev.createDevice('local_printer', ePosDev.DEVICE_TYPE_PRINTER,
	            {'crypto': false, 'buffer': false}, cbCreateDevice_printer);
	    } else {
	    	alert("Go")
	        console.log(data);
	    }
	}

	function cbCreateDevice_printer(devobj, retcode) {
		alert("in cbCreateDevice_printer" +retcode)
	    if (retcode == 'OK') {
	    	alert("in retcode == 'OK'" +devobj)
	        printer = devobj;
	        printer.timeout = 60000;
	        
	        printer.onreceive = function (res) { //alert(res.success);
	        alert("res " +res)
	            console.log("Printer Object Created");

	        };
	        printer.oncoveropen = function () { //alert('coveropen');
	            console.log("Printer Cover Open");

	        };
	    } else {
	    	alert("in retcode == 'else'")
	        console.log(retcode);
	        isRegPrintConnected = false;
	    }
	}

	function print(salePrintObj) {
	    debugger;
	    if (isRegPrintConnected == false
	        || printer == null) {
	        return;
	    }
	    console.log("Printing Started");


	    printer.addLayout(printer.LAYOUT_RECEIPT, 800, 0, 0, 0, 35, 0);
	    printer.addTextAlign(printer.ALIGN_CENTER);
	    printer.addTextSmooth(true);
	    printer.addText('\n');
	    printer.addText('\n');

	    printer.addTextDouble(true, true);
	    printer.addText('ff' + '\n');

	    printer.addTextDouble(false, false);
	    printer.addText('ch' + '\n');
	    printer.addText('\n');

	    printer.addTextAlign(printer.ALIGN_LEFT);
	    printer.addText('DATE: ' + 'fewf' + '\t\t');

	    printer.addTextAlign(printer.ALIGN_RIGHT);
	    printer.addText('TIME: ' + 'ff' + '\n');

	    printer.addTextAlign(printer.ALIGN_LEFT);

	    printer.addTextAlign(printer.ALIGN_RIGHT);

	    printer.addTextAlign(printer.ALIGN_CENTER);
	    printer.addTextStyle(false, false, true, printer.COLOR_1);
	    printer.addTextStyle(false, false, false, printer.COLOR_1);
	    printer.addTextDouble(false, true);
	    printer.addText('* SALE RECEIPT *\n');
	    printer.addTextDouble(false, false);

	    printer.send();
	}

	</script> -->
<!-- 	<script type="text/javascript">
	//alert("sf")
	var ePosDev = new epson.ePOSDevice();
	//alert(JSON.stringify(ePosDev))
	function connect() {
		alert("Hi")
	var ipAddress = '192.168.2.207';
	var port = '9100';
	ePosDev.connect(ipAddress, port, callback_connect);
	}
	
	function callback_connect(resultConnect){
		alert(resultConnect)
		var deviceId = 'local_printer';
		var options = {'crypto' : false, 'buffer' : false};
		if ((resultConnect == 'OK')|| (resultConnect == 'SSL_CONNECT_OK')) {
		//Retrieves the Printer object
		ePosDev.createDevice(deviceId, ePosDev.DEVICE_TYPE_PRINTER, options,
		callback_createDevice);
		alert("deviceId " +deviceId);
		}
		else {
		//Displays error messages
		}
		}
	var printer = null;
	function callback_createDevice(deviceObj, errorCode){
	if (deviceObj === null) {
	//Displays an error message if the system fails to retrieve the Printer object
	return;
	}
	printer = deviceObj;
	//Registers the print complete event
	alert("printer " +JSON.stringify(printer.onreceive()));
	printer.onreceive = function(response){
		alert("response " +response)
	if (response.success) {
	//Displays the successful print message
	alert("Succ")
	}
	else {
	//Displays error messages
		alert("err")
	}
	};
	}
	 
	
	function createData(){
		printer.addTextAlign(printer.ALIGN_CENTER);
		printer.addText('Hello World_Sachin');
		}
	function send(){
		if (ePosDev.isConnected) {
		printer.send();
		}
		}
	</script> -->
	
	
	
	
	<!-- <script type="text/javascript">
	
	var address = 'http://192.168.2.207/cgi-bin/epos/service.cgi?devid=local_printer&time?out=60000';
		//Create ePOSPrint object
		var epos = new epson.ePOSPrint(address);
		//Create ePOSBuilder object
		var builder = new epson.ePOSBuilder();
		//Register the event
		epos.onreceive = function (res) { alert(res.success); };
		//Create the printing data
		builder.addText('Hello SIR\n');
		//Send the printing data
		epos.send(builder.toString());
		
		
		
		
		var ePosDev = new epson.ePOSDevice();
		var printer = null;
		function connect(){
		//Connect to device
		ePosDev.connect('192.168.2.207', '9100', callback_connect);
		}
		function callback_connect(resultConnect){
		if ((resultConnect == 'OK') || (resultConnect == 'SSL_CONNECT_OK')) {
		//Get the Printer object
		ePosDev.createDevice('local_printer', ePosDev.DEVICE_TYPE_PRINTER, {'crypto' :
		false, 'buffer' : false}, callback_createDevice);
		}
		else {
		//Display the error message
		}
		}
		function callback_createDevice(deviceObj, retcode){
		if( retcode == 'OK' ) {
		printer = deviceobj;
		printer.timeout = 60000;
		//Register the printing complete event
		printer.onreceive = function (res) { alert(res.success); };
		print();
		} else {
		alert(retcode);
		}
		}
		function print(){
		//Create the printing data
		printer.addText('Hellods\n');
		//Send the printing data
		printer.send();
		}
		function disconnect(){
		//Discard the Printer object
		ePosDev.deleteDevice(printer, callback_deleteDevice);
		}
		function callback_deleteDevice(errorCode){
		//Disconnect to device
		ePosDev.disconnect();
		}
		
	</script> -->
	
	<script type="text/javascript">
	
	
	function buildMessage() {
		var builder = new epson.ePOSBuilder();
		builder.addTextLang("en");
		builder.addTextSmooth(true);
		builder.addTextFont(builder.FONT_A);
		builder.addTextSize(1, 1);
		
		var text="\t\tKOT\n"+"Date :- 15/11/2019\n"+"Order No :-123456\t"+"Table No :- C10\n\n"
		+"Item                        "+"    Qty\n"+"---------------------------------------------\n"+"Pineapple Juice             "+"2\n"
		+"--------------------------------------------";
		
		//builder.addText("\t\t\t\tSamarth Juice Center\n");
		builder.addText(text);
		builder.addCut(builder.CUT_FEED);
		var request = builder.toString();
		var address = "http://192.168.2.207/cgi-bin/epos/service.cgi?devid=local_printer&timeout=10000";
		var epos = new epson.ePOSPrint(address);
		epos.send(request);
		
	}
</script>

	

</html>
