<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/WEB-INF/tlds/mytags.tld" prefix="tm" %>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Home Page</title>
<script src="/tmdmmodel/jQuery/jquery.min.js"></script>
<script src="/tmdmmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/tmdmmodel/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/tmdmmodel/js/sb-admin.min.js"></script>
<link href="/tmdmmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/tmdmmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="/tmdmmodel/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
<link href="/tmdmmodel/css/sb-admin.css" rel="stylesheet">
<script>
var tableComponents=[];
var canvas;
var canvasContext;
window.onload=function()
{
canvas=document.getElementById('drawingCanvas');
canvasContext=canvas.getContext('2d');
}
function Field(vSerialNumber,vName,vType,vConstraint,vDefaultValue)
{
this.serialNumber="";
this.name="";
this.dataType="";
this.dataTypeSize="";
this.constraint="";
this.defaultValue="";
this.note="";
}
function DatabaseTable(vName)
{
this.name=vName;
this.engine;
this.note="";
this.fields=[];
}
function TableDrawable(vX,vY,vDatabaseTable)
{
this.x=vX;
this.y=vY;
this.width;
this.height=100;
this.databaseTable=vDatabaseTable;
this.scroll=function(text_width)
{
var isScroll=false;
if(canvas.width<this.x+text_width)
{
isScroll=true;
var diff=this.x+text_width-canvas.width;
canvas.width=canvas.width+diff+20;
$("#canvasDivision").scrollLeft(canvas.width);
}
if(canvas.height<this.y+100)
{
isScroll=true;
var diff=this.y+100-canvas.height;
canvas.height=canvas.height+diff+20;
$("#canvasDivision").scrollTop(canvas.height);
}
if(isScroll) draw();
}
this.draw=function()
{
canvasContext.font='20px Sans-Serif';
var titleWidth=(canvasContext.measureText(this.databaseTable.name).width);
this.scroll(titleWidth);
canvasContext.fillStyle='#000000';
var textWidth;
var fieldWidths=[];
fieldWidths.push(titleWidth);
for(i=0;i<this.databaseTable.fields.length;i++)
{
var serialNumber=this.databaseTable.fields[i].serialNumber;
var name=this.databaseTable.fields[i].name;
var dataType=this.databaseTable.fields[i].dataType;
var dataTypeSize=this.databaseTable.fields[i].dataTypeSize;
var constraint=this.databaseTable.fields[i].constraint;
var defaultValue=this.databaseTable.fields[i].defaultValue;
var fieldText=serialNumber+" "+name+" "+dataType+"("+dataTypeSize+") "+constraint+" "+defaultValue;
var fieldWidth=(canvasContext.measureText(fieldText).width);
canvasContext.fillText(fieldText,this.x+10,this.y+(20)*i+50);
fieldWidths.push(fieldWidth);
}
var largest=fieldWidths[0];
for(i=1;i<fieldWidths.length;i++)
{
if(fieldWidths[i]>largest) largest=fieldWidths[i];
}
console.log(largest);
textWidth=largest+20;
this.scroll(textWidth);
this.width=textWidth;
canvasContext.beginPath();
canvasContext.rect(this.x,this.y,textWidth,100);
canvasContext.moveTo(this.x,this.y+30);
canvasContext.lineTo(this.x+textWidth,this.y+30);
canvasContext.stroke();
canvasContext.fillText(this.databaseTable.name,this.x,this.y+20);
}
}//table Drawable function ends
function TableComponent()
{
this.drawableTable=null;
this.tableDrawable=null;
this.draw=function()
{
this.tableDrawable.draw();
}
}
function draw()
{
//code to clear canvas
canvasContext.clearRect(0,0,canvas.width,canvas.height);
for(var i=0;i<tableComponents.length;i++)
{
tableComponents[i].draw();
}
}
function calculateMousePosition(event)
{
var rect=canvas.getBoundingClientRect();
var root=document.documentElement;
var mouseX=event.clientX-rect.left-root.scrollLeft;
var mouseY=event.clientY-rect.top-root.scrollTop;
return {
x:mouseX,
y:mouseY
};
}
function DoubleClickFunction(event)
{
var position=calculateMousePosition(event);
var xCor=position.x;
var yCor=position.y;
for(var i=0;i<tableComponents.length;i++)
{
var tableX=tableComponents[i].tableDrawable.x;
var tableY=tableComponents[i].tableDrawable.y;
var tableWidth=tableComponents[i].tableDrawable.width;
var tableHeight=tableComponents[i].tableDrawable.height;
//console.log("Clicked : "+xCor+" "+yCor);
//console.log("Actual : "+tableX+" "+tableY+" "+tableWidth+" "+tableHeight);
if((xCor>tableX && xCor<tableX+tableWidth) && (yCor>tableY && yCor<tableY+tableHeight))
{
window.databaseTable=tableComponents[i].databaseTable;
showTableData();
$('#attributeModal').modal('show');
}
}
}
function showTableData()
{
var tableEntityBody=document.querySelector("#tableEntityBody");
var attributeEntityBody=document.querySelector("#attributeEntityBody");
$("#tableEntityBody").empty();
$("#attributeEntityBody").empty();
var fieldsLength=databaseTable.fields.length;
console.log("field Length "+fieldsLength);
for(var i=0;i<fieldsLength;i++)
{
var field=databaseTable.fields[i];
var row=tableEntityBody.insertRow(i);
var serialNumberColumn=row.insertCell(0);
var engineColumn=row.insertCell(1);
var noteColumn=row.insertCell(2);
row=attributeEntityBody.insertRow(i);
serialNumberColumn=row.insertCell(0);
var fieldColumn=row.insertCell(1);
var typeColumn=row.insertCell(2);
var constraintColumn=row.insertCell(3);
var defaultColumn=row.insertCell(4);
var attributeNote=row.insertCell(5);
var editDeleteColumn=row.insertCell(6);
serialNumberColumn.innerHTML=field.serialNumber;
}
}//show table data function ends
function DefaultTableName()
{
if(tableComponents.length==0)
{
return "Table 1";
}
for(i=0;i<tableComponents.length;i++)
{
var str=tableComponents[i].databaseTable.name;
str2=str.slice(0,6);
if(str2=="Table ")
{
return str2.concat(tableComponents.length+1);
}
}
}
function CreateTableFunction(event)
{
var position=calculateMousePosition(event);
var xCor=position.x;
var yCor=position.y;
//determine what should be the default table name
var vFields=[]
var defaultTableName=DefaultTableName();
var databaseTable=new DatabaseTable(defaultTableName);
var tableDrawable=new TableDrawable(xCor,yCor,databaseTable);
var tableComponent=new TableComponent();
tableComponent.databaseTable=databaseTable;
tableComponent.tableDrawable=tableDrawable;
//add tableComponent to tableComponents array
tableComponents.push(tableComponent);
draw();
canvas.removeEventListener('click',CreateTableFunction);
canvas.addEventListener('dblclick',DoubleClickFunction);
}
</script>
<script>
function addTableData()
{
}
function addAttributeData()
{
var tableEntityBody=document.querySelector("#tableEntityBody");
var attributeEntityBody=document.querySelector("#attributeEntityBody");
var tableName=$("#tableName").val();

var row=tableEntityBody.insertRow(0);
var serialNumberColumn=row.insertCell(0);
var engineColumn=row.insertCell(1);
var tableNoteColumn=row.insertCell(2);
serialNumberColumn.innerHTML="1";
engineColumn.innerHTML=$('#engine').val();
tableNoteColumn.innerHTML=$("#tableNote").val();

row=attributeEntityBody.insertRow(0);
serialNumberColumn=row.insertCell(0);
var fieldColumn=row.insertCell(1);
var typeColumn=row.insertCell(2);
var constraintColumn=row.insertCell(3);
var defaultColumn=row.insertCell(4);
var attributeNoteColumn=row.insertCell(5);
var editDeleteColumn=row.insertCell(6);
serialNumberColumn.innerHTML="1";
var fieldString=$('#attributeName').val();
if($('#isPrimaryKey:checked').val()==1) fieldString=fieldString+"<i class='fas fa-key'></i>";
if($('#isAutoIncrement:checked').val()==true) fieldString=fieldString+"<i class='fas fa-plus'></i><i class='fas fa-plus'></i>";
fieldColumn.innerHTML=fieldString;
typeString=$('#dataType').val()+"("+$('#dataTypeSize').val()+")";
typeColumn.innerHTML=typeString;
var constraintString="";
if($('#isUnique:checked').val()==1) constraintString=constraintString+"UNN ";
if($('#isNotNull:checked').val()==1) constraintString=constraintString+"NN ";
constraintColumn.innerHTML=constraintString;
defaultColumn.innerHTML=$('#defaultValue').val();
attributeNoteColumn.innerHTML=$("#attributeNote").val();
editDeleteColumn.innerHTML="<i class='fas fa-edit' onclick='editColumn()'></i>&nbsp;&nbsp;<i class='fas fa-trash-alt' onclick='deleteColumn()'></i>";

var field=new Field();
field.serialNumber=1;
field.name=$("#attributeName").val();
field.dataType=$("#dataType").val();
field.dataTypeSize=$("#dataTypeSize").val();
field.constraint=constraintString;
field.defaultValue=$("#defaultValue").val();
field.note=$("#attributeNote").val();
databaseTable.fields.push(field);
databaseTable.engine=$('#engine').val();
databaseTable.note=$("#tableNote").val();
} //retrive data function ends
function editColumn()
{
console.log("edit column function invoked");
}
function deleteColumn()
{
console.log("delete column function invoked");
}
function AddTableFunction()
{
canvas.addEventListener('click',CreateTableFunction);
}
function okFunction()
{
$("#tableEntityBody").empty();
$("#attributeEntityBody").empty();
draw();
$("#tableName").val('');
$('#engine').val('');
$("#attributeNote").val('');
$("#tableNote").val('');
$('#attributeName').val('');
$('#dataType').val('');
$('#dataTypeSize').val('');
$('#defaultValue').val('');
$('#isPrimaryKey').prop('checked',false);
$('#isAutoIncrement').prop('checked',false);
$('#isUnique').prop('checked',false);
$('#isNotNull').prop('checked',false);
}
</script>
</head>
<body id="page-top">

<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
<a class="navbar-brand mr-1" id="sidebarToggle" href="#">Menu</a>
<!-- Navbar -->
<ul class="navbar-nav ml-auto mr-md-3">
<h1 class='navbar-brand mr-0 text-white' aria-haspopup='true' aria-expanded='false'>
<i class="fas fa-user-circle fa-fw"></i>
${member.firstName}
</h1>
</ul>
</nav>

<div id="wrapper">
<ul class="sidebar navbar-nav">
<li class="nav-item">
<button class="btn btn-link btn-lg text-white" data-toggle="modal" data-target="#saveProjectModal">
<i class="far mr-3 fa-save"></i>
<span class="mr-5">Save Project </span>
</button>
</li>
<li class="nav-item">
<button class="btn btn-link btn-lg text-white" data-toggle="modal" data-target="#exitModal">
<i class="fas mr-3 fa-times"></i>
<span class="mr-5">Exit<span>
</button>
</li>
</ul>
<div id="content-wrapper">
<div class="container-fluid">
<h3>${currentProject.title}</h3>
<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
<div class="btn-group mr-2" role="group" aria-label="First group">
<button class="btn btn-lg" onclick='AddTableFunction()'>
<i class='fas fa-plus'></i>
</button>
</div>
</div>
<br>

<div id='canvasDivision' style="max-width: 600px;max-height: 300px; overflow: scroll;">
<canvas id="drawingCanvas" width="580" height="280" style='border:1px solid black;'>
</canvas>
</div>
</div>
<!-- /.container-fluid -->

<!-- Sticky Footer -->
<footer class="sticky-footer">
<div class="container my-auto">
<div class="copyright text-center my-auto">
<span>Copyright © Your Website 2018</span>
</div>
</div>
</footer>

</div>
<!-- /.content-wrapper -->

</div>
<!-- /#wrapper -->

<div class="modal fade" id="saveProjectModal" role="dialog">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Save</h4>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<div class="modal-body">
<p>Save Changes..</p>
</div>
<div class="modal-footer">
<button type="button" class='btn btn-success'  data-dismiss="modal">Yes</button>
<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
</div>
</div>
</div>
</div>
<div class="modal fade" id="exitModal" role="dialog">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Exit</h4>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<div class="modal-body">
<p>
Are You Sure ?
<br>
Changes May not be saved..
</p>
</div>
<div class="modal-footer">
<button type="button" class='btn btn-success'  data-dismiss="modal">Save And Exit</button>
<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="window.location='/tmdmmodel/webservice/projectService/exitProject';">Exit</button>
<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
</div>
</div>
</div>
</div>
<div class='modal' id='myModal'>
<div class="modal-dialog" style="width:1250px;">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Add Attribute Modal</h4>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<div class="modal-body">
Table Name &nbsp;&nbsp;&nbsp;&nbsp;<input type='text' id='tableNameTextField' name='tableNameTextField'>
<table class="table table-hover table-bordered">
<thead>
<tr>
<th style='width:2px;'>S.No.</th>
<th style='width:2px;'>Fields</th>
<th>Type</th>
<th>Constraint</th>
<th>Default</th>
<th>Edit/Delete</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>
</div>
<div class="modal-footer">
<button type="button" class='btn btn-success'  data-dismiss="modal">Ok</button>
<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
</div>
</div>
</div>
</div>





<div class='modal fade' id='attributeModal' role='dialog' data-backdrop='static'>
<div class="modal-dialog modal-lg" style='overflow-y: initial;overflow-x: initial'>
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Attribute Modal</h4>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<div class="modal-body" style='height:400px;width=1000px;overflow-x: auto;overflow-y: auto;'>
<div class='form-label-group'>
<input type='text' id='tableName' name="tableName" required='required' class='form-control' placeholder='Table Name'>
<label for='tableName'>Table Name</label>
</div>
<br>
<ul class='nav nav-tabs'>
<li class='nav-item'>
<a class='nav-link active text-info' data-toggle='tab' href='#table' role='tab' aria-controls='home' aria-selected='true'>
Table
</a>
</li>
&nbsp;&nbsp;&nbsp;&nbsp;
<li class='nav-item'>
<a class='nav-link text-info' data-toggle='tab' href='#attribute'  role='tab' aria-controls='home' aria-selected='true'>
Attribute
</a>
</li>
</ul>
<div class="tab-content">
<div id="table" class="tab-pane fade show active" >
<table class='table table-hover table-bordered' id='tableEntity'>
<thead>
<tr>
<th>S.No</th>
<th>Engine</th>
<th>Note</th>
</tr>
</thead>
<tbody id='tableEntityBody'>
<tr>
</tr>
</tbody>
</table>

</div>
<div id='attribute' class='tab-pane fade'>
<table id='attributeEntity' class="table table-hover table-bordered">
<thead>
<tr>
<th>S.No.</th>
<th>Fields</th>
<th>Type</th>
<th>Constraint</th>
<th>Default</th>
<th>Note</th>
<th>Edit/Delete</th>
</tr>
</thead>
<tbody id='attributeEntityBody'>
<tr>
</tr>
</tbody>
</table>
</div>
</div>

<div class='card text-center'>
<div class="card-header"> Add Attribute
</div>
<div class='card body'>
<br>
<div class='form-row'>
<div class='col-md-1'>
</div>
<div class='col-md-5'>
<div class='form-label-group'>
<input type='text' id='attributeName' name="attributeName" required='required' class='form-control' placeholder='Attribute Name'>
<label for='attributeName'>Attribute Name</label>
</div>
</div>
<div class='form-label-group col-md-5'>
<input type='text' id='defaultValue' name="defaultValue" required='required' class='form-control' placeholder='Default Value'>
<label for='defaultValue'>Default Value</label>
</div>
<div class='col-md-1'>
</div>
</div>
<br>
<div class='form-row'>
<div class='col-md-1'>
</div>
<h5>Data type
<select name='dataType' id="dataType">
<option value='-1' class='btn btn-light btn-block'>&lt;Select&gt;</option>
<c:set var='currentDatabaseArchitecture' value='${currentProject.databaseArchitecture}' />
<c:forEach items='${databaseArchitectures}' var='da'>
<c:set var='databaseArchitectureName' value='${da.name}' />
<c:set var='currentDatabaseArchitectureName' value='${currentDatabaseArchitecture.name}' />
<c:if test="${databaseArchitectureName==currentDatabaseArchitectureName}">
<c:forEach items='${da.dataType}' var='en'>
<option value='${en.dataType}' class='btn btn-light btn-block'>${en.dataType}</option>
</c:forEach>
</c:if>
</c:forEach>
</select>
</h5>
<div class='col-md-1'>
</div>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='dataTypeSize' name="dataTypeSize" required='required' class='form-control' placeholder='Data Type Size'>
<label for='dataTypeSize'>Data Type Size</label>
</div>
</div>
<div class='col-md-1'>
</div>
</div>
<br>
<div class='form-row'>
<div class='col-md-1'>
</div>
<table border='0'>
<tr>
<td>Primary Key</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='isPrimaryKey' id='isPrimaryKey' value='1'></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>Allow Auto Increment</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='isAutoIncrement' id='isAutoIncrement' value='1'></td>
</tr>
<tr>
<td>&nbsp;&nbsp;</td>
</tr>
<tr>
<td>Unique Key</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='isUnique' id='isUnique' value='1'></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>Not Null</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='isNotNull' id='isNotNull' value='1'></td>
</tr>
</table>
&nbsp;&nbsp;
<div class="form-group">
<textarea class="note" id="attributeNote" rows="3" cols='200' placeholder='Note' style='width:300px;'></textarea>
<label for="attributeNote"></label>
</div>
<div class='col-md-1'>
</div>
</div>
<br>
<div class='form-row'>
<div class='col-md-3'>
</div>
<button type='button' class='btn btn-info col-md-6' onclick='addAttributeData()'>Add Attribute</button>
</div>
<br>
</div><!-- Card body ends-->
</div><!-- Card ends-->
<div class='card text-center'>
<div class="card-header"> Add Table 
</div>
<div class='card body'>
<br>
<div class='form-row'>
<div class='col-md-1'>
</div>
<h5>Engine&nbsp;&nbsp;
<select name='engine' id="engine">
<option value='-1' class='btn btn-light btn-block'>&lt;Select&gt;</option>
<c:set var='currentDatabaseArchitecture' value='${currentProject.databaseArchitecture}' />
<c:forEach items='${databaseArchitectures}' var='da'>
<c:set var='databaseArchitectureName' value='${da.name}' />
<c:set var='currentDatabaseArchitectureName' value='${currentDatabaseArchitecture.name}' />
<c:if test="${databaseArchitectureName==currentDatabaseArchitectureName}">
<c:forEach items='${da.engine}' var='en'>
<option value='${en.name}' class='btn btn-light btn-block'>${en.name}</option>
</c:forEach>
</c:if>
</c:forEach>
</select>
</h5>
<div class='col-md-1'>
</div>
<div class="form-group">
<textarea class="note" id="tableNote" rows="3" cols='200' placeholder='Note' style='width:300px;'></textarea>
<label for="tableNote"></label>
</div>
</div>
<div class='form-row'>
<div class='col-md-3'>
</div>
<button type='button' class='btn btn-info col-md-6' onclick='addTableData()'>Add Table Data</button>
</div>
<br>
</div></!--card body ends-->
</div><!--card ends-->
</div><!-- modal body tag-->
<div class="modal-footer">
<button type="button" class='btn btn-success'  data-dismiss="modal" onclick="okFunction()">Ok</button>
<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
</div>
</div>
</div>
</div>


</body>
</html>