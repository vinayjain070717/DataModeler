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
<style>
 .row-highlight
        {
            background-color: Yellow;
        }
</style>
<script>
var tableComponents=[];
var canvas;
var canvasContext;
var databaseTable;
var selectedTableName=null;
var defaultTableName=0;
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
this.note;
this.fields=[];
}
function TableDrawable(vX,vY,vDatabaseTable)
{
this.x=vX;
this.y=vY;
this.width=100;
this.height=100;
this.databaseTable=vDatabaseTable;
this.scroll=function(text_width,text_height)
{
var isScroll=false;
if(canvas.width<this.x+text_width)
{
isScroll=true;
var diff=this.x+text_width-canvas.width;
canvas.width=canvas.width+diff+20;
$("#canvasDivision").scrollLeft(canvas.width);
}
if(canvas.height<this.y+text_height)
{
isScroll=true;
var diff=this.y+text_height-canvas.height;
canvas.height=canvas.height+diff+20;
$("#canvasDivision").scrollTop(canvas.height);
}
if(isScroll) draw();
}
this.draw=function()
{
var fontHeight=20;
var tableHeaderHeight=fontHeight+10;
var lineSpacingHeight=5;
canvasContext.font=fontHeight+'px Sans-Serif';
var titleWidth=(canvasContext.measureText(this.databaseTable.name).width);
canvasContext.fillStyle='#000000';
var textHeight=canvasContext.measureText('W').width;
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
canvasContext.fillText(fieldText,this.x+10,this.y+(textHeight+lineSpacingHeight)*(i+1)+tableHeaderHeight);
fieldWidths.push(fieldWidth);
}
var largest=fieldWidths[0];
for(i=1;i<fieldWidths.length;i++)
{
if(fieldWidths[i]>largest) largest=fieldWidths[i];
}
textWidth=largest+20;
this.width=textWidth;
var tableHeight=(textHeight+lineSpacingHeight)*(this.databaseTable.fields.length+1)+tableHeaderHeight;
if(tableHeight<this.height) tableHeight=this.height;
else this.height=tableHeight;
this.scroll(textWidth,tableHeight);
var tableSelected=false;
if(selectedTableName && this.databaseTable && selectedTableName==this.databaseTable.name)
{
tableSelected=true;
canvasContext.fillStyle='#33CEFF';
canvasContext.fillRect(this.x-5,this.y-5,5,5);
canvasContext.fillRect(this.x-5,this.y+this.height,5,5);
canvasContext.fillRect(this.x+this.width,this.y-5,5,5);
canvasContext.fillRect(this.x+this.width,this.y+this.height,5,5);
canvasContext.fillStyle='black';
canvasContext.fillRect(this.x,this.y,textWidth,tableHeaderHeight);
}
canvasContext.beginPath();
canvasContext.rect(this.x,this.y,textWidth,tableHeight);
canvasContext.moveTo(this.x,this.y+tableHeaderHeight);
canvasContext.lineTo(this.x+textWidth,this.y+30);
canvasContext.stroke();
if(tableSelected) canvasContext.fillStyle='white';
else canvasContext.fillStyle='#000000';
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
function closeButtonFunction()
{
if($("#tableName").val().length>0) databaseTable.name=$("#tableName").val();
if($("#engine").val().length>0) databaseTable.engine=$("#engine").val();
if($("#tableNote").val().length>0) databaseTable.note=$("#note").val();
draw();
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
console.log("double click function invoked");
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
databaseTable=tableComponents[i].databaseTable;
putTableData();
$('#attributeModal').modal('show');
}
}
}
function putTableData()
{
var tableEntityBody=document.querySelector("#tableEntityBody");
var attributeEntityBody=document.querySelector("#attributeEntityBody");
$("#tableEntityBody").empty();
$("#attributeEntityBody").empty();
var fieldsLength=databaseTable.fields.length;
window.selectedRowIndex=null;
for(var i=0;i<fieldsLength;i++)
{
var field=databaseTable.fields[i];
row=attributeEntityBody.insertRow(i);
var attributeSerialNumberColumn=row.insertCell(0);
var fieldColumn=row.insertCell(1);
var typeColumn=row.insertCell(2);
var constraintColumn=row.insertCell(3);
var defaultColumn=row.insertCell(4);
var attributeNoteColumn=row.insertCell(5);
var editDeleteColumn=row.insertCell(6);

var fieldString=field.name;
var constraintString=""
if(field.constraint.search("PK")!=-1) fieldString=fieldString+"<i class='fas fa-key'></i>";
if(field.constraint.search("NN")!=-1) constraintString+="NN ";
if(field.constraint.search("UN")!=-1) constraintString+="UN ";
if(field.constraint.search("AI")!=-1) fieldString=fieldString+"<i class='fas fa-plus'></i><i class='fas fa-plus'></i>";

attributeSerialNumberColumn.innerHTML=field.serialNumber;
fieldColumn.innerHTML=fieldString;
typeColumn.innerHTML=field.dataType+" ("+field.dataTypeSize+")";
constraintColumn.innerHTML=constraintString;
defaultColumn.innerHTML=field.defaultValue;
attributeNoteColumn.innerHTML=field.note;
var rowCount=$("#attributeEntityBody tr").length;
editDeleteColumn.innerHTML='<i class="fas fa-edit" onclick="editColumn(\''+rowCount+'\')"></i>&nbsp;&nbsp;<i class="fas fa-trash-alt" onclick="deleteColumn(\''+rowCount+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-up" onclick="upColumn(\''+rowCount+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-down" onclick="downColumn(\''+rowCount+'\')"></i>';
//editDeleteColumn.innerHTML='<i class="fas fa-edit" onclick="editColumn(\''+rowCount+'\')"></i>&nbsp;&nbsp;<i class="fas fa-trash-alt" onclick="deleteColumn(\''+rowCount+'\')"></i>';
//var rowCount=$("#attributeEntityBody tr").length;
//var currentRow=$("#attributeEntity tr");
//console.log(rowCount);
//console.log(currentRow[rowCount]);
//currentRow[rowCount].addEventListener('click',tableRowClickFunction(event));
}
if(databaseTable.engine || databaseTable.note)
{
var row=tableEntityBody.insertRow(0);
var tableSerialNumberColumn=row.insertCell(0);
var engineColumn=row.insertCell(1);
var noteColumn=row.insertCell(2);
tableSerialNumberColumn.innerHTML="1";
engineColumn.innerHTML=databaseTable.engine;
noteColumn.innerHTML=databaseTable.note;
}
}//show table data function ends
function DefaultTableName()
{
var str="Table ";
//return str.concat(tableComponents.length+1);
window.defaultTableName+=1;
return str.concat(defaultTableName);
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
$("#tableEntityBody").empty();
var tableEntityBody=document.querySelector("#tableEntityBody");
var row=tableEntityBody.insertRow(0);
var serialNumberColumn=row.insertCell(0);
var engineColumn=row.insertCell(1);
var tableNoteColumn=row.insertCell(2);
serialNumberColumn.innerHTML="1";

engineColumn.innerHTML=$('#engine').val();
tableNoteColumn.innerHTML=$("#tableNote").val();
databaseTable.engine=$('#engine').val();
databaseTable.note=$("#tableNote").val();
$("#engine").val('-1');
$("#tableNote").val('');
}
function addAttributeData()
{
var attributeEntityBody=document.querySelector("#attributeEntityBody");
var rowCount=$("#attributeEntityBody tr").length;
var row=attributeEntityBody.insertRow(rowCount);
var serialNumberColumn=row.insertCell(0);
var fieldColumn=row.insertCell(1);
var typeColumn=row.insertCell(2);
var constraintColumn=row.insertCell(3);
var defaultColumn=row.insertCell(4);
var attributeNoteColumn=row.insertCell(5);
var editDeleteColumn=row.insertCell(6);
serialNumberColumn.innerHTML=rowCount+1;
var fieldString=$('#attributeName').val();
var fieldConstraintString="";
if($('#isPrimaryKey:checked').val()==1)
{
fieldConstraintString=fieldConstraintString+"PK"+" ";
fieldString=fieldString+"<i class='fas fa-key'></i>";
}
if($('#isAutoIncrement:checked').val()==true)
{
fieldConstraintString=fieldConstraintString+"AI"+" ";
fieldString=fieldString+"<i class='fas fa-plus'></i><i class='fas fa-plus'></i>";
}
fieldColumn.innerHTML=fieldString;
typeString=$('#dataType').val()+"("+$('#dataTypeSize').val()+")";
typeColumn.innerHTML=typeString;
var constraintString="";
if($('#isUnique:checked').val()==1) constraintString=constraintString+"UN ";
if($('#isNotNull:checked').val()==1) constraintString=constraintString+"NN ";
constraintColumn.innerHTML=constraintString;
defaultColumn.innerHTML=$('#defaultValue').val();
attributeNoteColumn.innerHTML=$("#attributeNote").val();

window.selectedRowIndex=null;
var currentRow=$("#attributeEntity tr");
var rowCount2=rowCount+1;
if(rowCount2==1) editDeleteColumn.innerHTML='<i class="fas fa-edit" onclick="editColumn(\''+rowCount2+'\')"></i>&nbsp;&nbsp;<i class="fas fa-trash-alt" onclick="deleteColumn(\''+rowCount2+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-up" onclick="upColumn(\''+rowCount2+'\')" disabled></i>&nbsp;&nbsp;<i class="fas fa-angle-down" onclick="downColumn(\''+rowCount2+'\')"></i>';
else editDeleteColumn.innerHTML='<i class="fas fa-edit" onclick="editColumn(\''+rowCount2+'\')"></i>&nbsp;&nbsp;<i class="fas fa-trash-alt" onclick="deleteColumn(\''+rowCount2+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-up" onclick="upColumn(\''+rowCount2+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-down" onclick="downColumn(\''+rowCount2+'\')"></i>';
var field=new Field();
field.serialNumber=rowCount+1;
field.name=$("#attributeName").val();
field.dataType=$("#dataType").val();
field.dataTypeSize=$("#dataTypeSize").val();
field.constraint=fieldConstraintString+constraintString;
field.defaultValue=$("#defaultValue").val();
field.note=$("#attributeNote").val();
databaseTable.fields.push(field);
okFunction();
} //add table data function ends
function editColumn(SelectedRowIndex)
{
if(SelectedRowIndex)
{
window.selectedRowIndex=SelectedRowIndex;
$("#addAttributeCard").css("display","none");
$("#updateAttributeCard").css("display","block");
$("#deleteAttributeCard").css("display","none");
var field=databaseTable.fields[SelectedRowIndex-1];
$("#updateAttributeName").val(field.name);
$("#updateDataType").val(field.dataType);
$("#updateDataTypeSize").val(field.dataTypeSize);
$("#updateDefaultValue").val(field.defaultValue);
$("#updateAttributeNote").val(field.note);
if(field.constraint.search("PK")!=-1) $("#updateIsPrimaryKey").prop("checked",true);
if(field.constraint.search("NN")!=-1) $("#updateIsNotNull").prop("checked",true);
if(field.constraint.search("UN")!=-1) $("#updateIsUniqueKey").prop("checked",true);
if(field.constraint.search("AI")!=-1) $("#updateIsAutoIncrement").prop("checked",true);
}
}
function updateAttributeData()
{
var table=document.getElementById("attributeEntity");
var rowCount=table.rows.length;
var row=table.rows[selectedRowIndex];
var fieldString=$('#updateAttributeName').val();
var fieldConstraintString="";
if($('#updateIsPrimaryKey:checked').val()==1)
{
fieldConstraintString=fieldConstraintString+"PK"+" ";
fieldString=fieldString+"<i class='fas fa-key'></i>";
}
if($('#updateIsAutoIncrement:checked').val()==true)
{
fieldConstraintString=fieldConstraintString+"AI"+" ";
fieldString=fieldString+"<i class='fas fa-plus'></i><i class='fas fa-plus'></i>";
}
typeString=$('#updateDataType').val()+"("+$('#updateDataTypeSize').val()+")";
var constraintString="";
if($('#updateIsUniqueKey:checked').val()==1) constraintString=constraintString+"UN ";
if($('#updateIsNotNull:checked').val()==1) constraintString=constraintString+"NN ";

row.cells[0].innerHTML=selectedRowIndex;
row.cells[1].innerHTML=fieldString;
row.cells[2].innerHTML=typeString;
row.cells[3].innerHTML=constraintString;
row.cells[4].innerHTML=$("#updateDefaultValue").val();
row.cells[5].innerHTML=$("#updateAttributeNote").val();
rowCount2=selectedRowIndex;
row.cells[6].innerHTML='<i class="fas fa-edit" onclick="editColumn(\''+rowCount2+'\')"></i>&nbsp;&nbsp;<i class="fas fa-trash-alt" onclick="deleteColumn(\''+rowCount2+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-up" onclick="upColumn(\''+rowCount2+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-down" onclick="downColumn(\''+rowCount2+'\')"></i>';
var field=new Field();
field.serialNumber=selectedRowIndex;
field.name=$("#updateAttributeName").val();
field.dataType=$("#updateDataType").val();
field.dataTypeSize=$("#updateDataTypeSize").val();
field.constraint=fieldConstraintString+constraintString;
field.defaultValue=$("#updateDefaultValue").val();
field.note=$("#updateAttributeNote").val();
databaseTable.fields.splice(selectedRowIndex-1,1,field);
cancelUpdate();
}
function cancelUpdate()
{
$("#addAttributeCard").css("display","block");
$("#updateAttributeCard").css("display","none");
$("#deleteAttributeCard").css("display","none");
$("#updateAttributeName").val('');
$("#updateDataType").val('-1');
$("#updateDataTypeSize").val('');
$("#updateDefaultValue").val('');
$("#updateAttributeNote").val('');
$("#updateIsPrimaryKey").prop("checked",false);
$("#updateIsNotNull").prop("checked",false);
$("#updateIsUniqueKey").prop("checked",false);
$("#updateIsAutoIncrement").prop("checked",false);
}
function deleteColumn(SelectedRowIndex)
{
if(SelectedRowIndex)
{
window.selectedRowIndex=SelectedRowIndex;
$("#addAttributeCard").css("display","none");
$("#updateAttributeCard").css("display","none");
$("#deleteAttributeCard").css("display","block");
var field=databaseTable.fields[SelectedRowIndex-1];
console.log(databaseTable.fields[SelectedRowIndex-1]);
console.log(field);
$("#deleteAttributeName").text(field.name);
$("#deleteDataType").text(field.dataType);
$("#deleteDataTypeSize").text(field.dataTypeSize);
$("#deleteDefaultValue").text(field.defaultValue);
$("#deleteAttributeNote").text(field.note);
if(field.constraint.search("PK")!=-1) $("#deleteIsPrimaryKey").prop("checked",true);
if(field.constraint.search("NN")!=-1) $("#deleteIsNotNull").prop("checked",true);
if(field.constraint.search("UN")!=-1) $("#deleteIsUniqueKey").prop("checked",true);
if(field.constraint.search("AI")!=-1) $("#deleteIsAutoIncrement").prop("checked",true);
}
}
function refreshTable()
{
$("#attributeEntityBody").empty();
console.log(databaseTable.fields.length);
for(var i=0;i<databaseTable.fields.length;i++)
{
var field=databaseTable.fields[i];
row=attributeEntityBody.insertRow(i);
var attributeSerialNumberColumn=row.insertCell(0);
var fieldColumn=row.insertCell(1);
var typeColumn=row.insertCell(2);
var constraintColumn=row.insertCell(3);
var defaultColumn=row.insertCell(4);
var attributeNoteColumn=row.insertCell(5);
var editDeleteColumn=row.insertCell(6);

var fieldString=field.name;
var constraintString=""
if(field.constraint.search("PK")!=-1) fieldString=fieldString+"<i class='fas fa-key'></i>";
if(field.constraint.search("NN")!=-1) constraintString+="NN ";
if(field.constraint.search("UN")!=-1) constraintString+="UN ";
if(field.constraint.search("AI")!=-1) fieldString=fieldString+"<i class='fas fa-plus'></i><i class='fas fa-plus'></i>";

attributeSerialNumberColumn.innerHTML=field.serialNumber;
fieldColumn.innerHTML=fieldString;
typeColumn.innerHTML=field.dataType+" ("+field.dataTypeSize+")";
constraintColumn.innerHTML=constraintString;
defaultColumn.innerHTML=field.defaultValue;
attributeNoteColumn.innerHTML=field.note;
var rowCount=$("#attributeEntityBody tr").length;
editDeleteColumn.innerHTML='<i class="fas fa-edit" onclick="editColumn(\''+rowCount+'\')"></i>&nbsp;&nbsp;<i class="fas fa-trash-alt" onclick="deleteColumn(\''+rowCount+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-up" onclick="upColumn(\''+rowCount+'\')"></i>&nbsp;&nbsp;<i class="fas fa-angle-down" onclick="downColumn(\''+rowCount+'\')"></i>';
}
}
function deleteAttributeData()
{
var table=document.getElementById("attributeEntity");
var rowCount=table.rows.length;
$("#attributeEntity").find("tr").eq(selectedRowIndex).remove();
databaseTable.fields.splice(selectedRowIndex-1,1);
for(var i=0;i<databaseTable.fields.length;i++)
{
databaseTable.fields[i].serialNumber=i+1;
}
refreshTable();
cancelDelete();
}
function upColumn(index)
{
console.log(databaseTable.fields.length);
console.log(index);
if(index==1) return;
a=databaseTable.fields[index-2]
databaseTable.fields[index-2]=databaseTable.fields[index-1];
databaseTable.fields[index-1]=a;
for(var i=0;i<databaseTable.fields.length;i++)
{
databaseTable.fields[i].serialNumber=i+1;
}
refreshTable();
}
function downColumn(index)
{
console.log(databaseTable.fields.length);
console.log(index);
if(index==databaseTable.fields.length) return;
a=databaseTable.fields[index-1];
databaseTable.fields[index-1]=databaseTable.fields[index];
databaseTable.fields[index]=a;
for(var i=0;i<databaseTable.fields.length;i++)
{
databaseTable.fields[i].serialNumber=i+1;
}
refreshTable();
}
function cancelDelete()
{
$("#addAttributeCard").css("display","block");
$("#deleteAttributeCard").css("display","none");
$("#deleteAttributeCard").css("display","none");
$("#deleteAttributeName").text('');
$("#deleteDataType").text('-1');
$("#deleteDataTypeSize").text('');
$("#deleteDefaultValue").text('');
$("#deleteAttributeNote").text('');
$("#deleteIsPrimaryKey").prop("checked",false);
$("#deleteIsNotNull").prop("checked",false);
$("#deleteIsUniqueKey").prop("checked",false);
$("#deleteIsAutoIncrement").prop("checked",false);
}
function AddTableFunction()
{
canvas.addEventListener('click',CreateTableFunction);
}
function okFunction()
{
$('#engine').val('-1');
$("#attributeNote").val('');
$("#tableNote").val('');
$('#attributeName').val('');
$('#dataType').val('-1');
$('#dataTypeSize').val('');
$('#defaultValue').val('');
$('#isPrimaryKey').prop('checked',false);
$('#isAutoIncrement').prop('checked',false);
$('#isUnique').prop('checked',false);
$('#isNotNull').prop('checked',false);
}
function selectFunction(event)
{
window.selectedTableName=null;
var position=calculateMousePosition(event);
var xCor=position.x;
var yCor=position.y;
for(var i=0;i<tableComponents.length;i++)
{
var tableX=tableComponents[i].tableDrawable.x;
var tableY=tableComponents[i].tableDrawable.y;
var tableWidth=tableComponents[i].tableDrawable.width;
var tableHeight=tableComponents[i].tableDrawable.height;
if((xCor>tableX && xCor<tableX+tableWidth) && (yCor>tableY && yCor<tableY+tableHeight))
{
window.selectedTableName=tableComponents[i].databaseTable.name;
}
}
draw();
}
function SelectTableFunction()
{
canvas.addEventListener('click',selectFunction);
}
function DeleteTableFunction()
{
for(var i=0;i<tableComponents.length;i++)
{
if(selectedTableName && tableComponents[i].databaseTable.name==selectedTableName)
{
tableComponents.splice(i,1);
break;
}
}
draw();
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
<div class="btn-group mr-2" role="group" aria-label="First group">
<button class="btn btn-lg" onclick='SelectTableFunction()'>
<i class='fas fa-mouse-pointer'></i>
</button>
</div>
<div class="btn-group mr-2" role="group" aria-label="First group">
<button class="btn btn-lg" onclick='DeleteTableFunction()'>
<i class='fas fa-trash-alt'></i>
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



<div class='modal fade' id='attributeModal' role='dialog' data-backdrop='static'>
<div class="modal-dialog modal-lg" style='overflow-y: initial;overflow-x: initial'>
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Table</h4>
<button type="button" class="close" data-dismiss="modal" onclick='closeButtonFunction()'>&times;</button>
</div>
<div class="modal-body" style='height:490px;width=1000px;overflow-x: auto;overflow-y: auto;'>
<div class='form-label-group'>
<input type='text' id='tableName' name="tableName" required='required' class='form-control' placeholder='Table Name'>
<label for='tableName'>Table Name</label>
</div>
<br style='display:block;content:"";margin-top: 4;'>
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
<div style="overflow:auto;max-height:120px;height:120px;display:block;border:1px solid black;">
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
<br>
<div class='card text-left'>
<div class="card-header"> Add Table 
</div>
<div class='card body'>
<br>
<div class='form-row'>
<div class='col-md-1'>
</div>
<h6>Engine&nbsp;&nbsp;
<select name='engine' id="engine">
<option value='-1' class='btn btn-light btn-block' select>&lt;Select&gt;</option>
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
</h6>
<div class='col-md-1'>
</div>
<div class="form-group">
<textarea class="note" id="tableNote" rows="2" cols='200' placeholder='Note' style='width:300px;'></textarea>
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
</div><!-- table Tab ends-->
<div id='attribute' class='tab-pane fade'>
<div style='overflow-y:scroll;height:200px;display:block;border:1px solid black;'>
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
<br>
<div class='card text-center' id='addAttributeCard'>
<div class='card body'>
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
<div class='col-md-4'>
<div class='form-label-group'>
<input type='text' id='attributeName' name="attributeName" required='required' class='form-control' placeholder='Attribute Name'>
<label for='attributeName'>Attribute Name</label>
</div>
</div>
<div class='col-md-3'>
<select name='dataType' id="dataType">
<h3>
<option value='-1' class='btn btn-light btn-block' select>&lt;Data Type&gt;</option>
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
</h3>
</select>
</div>
<div class='col-md-3'>
<div class='form-label-group'>
<input type='text' id='dataTypeSize' name="dataTypeSize" required='required' class='form-control' placeholder='Data Type Size'>
<label for='dataTypeSize'>Data Type Size</label>
</div>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form row ends-->
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
&nbsp;&nbsp;
<table border='0'>
<tr>
<td>Primary Key</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='isPrimaryKey' id='isPrimaryKey' value='1'></td>
<td>&nbsp;&nbsp;</td>
<td>Allow Auto Increment</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='isAutoIncrement' id='isAutoIncrement' value='1'></td>
</tr>
<tr>
<td>Unique Key</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='isUnique' id='isUnique' value='1'></td>
<td>&nbsp;&nbsp;</td>
<td>Not Null</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='isNotNull' id='isNotNull' value='1'></td>
</tr>
</table>
<div class='col-md-1'>
</div>
<div class='form-label-group col-md-4'>
<input type='text' id='defaultValue' name="defaultValue" required='required' class='form-control' placeholder='Default Value'>
<label for='defaultValue'>Default Value</label>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form Row Ends-->
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
<div class='col-md-10'>
<div class="form-group">
<textarea class="note" id="attributeNote" name="attributeNote" rows="2" cols='82' placeholder='Note'></textarea>
<label for="attributeNote"></label>
</div>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form Row Ends-->
<div class='form-row'>
<div class='col-md-3'>
</div>
<button type='button' class='btn btn-info col-md-6' onclick='addAttributeData()'>Add Attribute</button>
</div><!-- Form Row Ends-->
<br style='display:block;content:"";margin-top: 4;'>
</div><!-- Card body ends-->
</div><!-- Card ends-->

<!-- Update Card Start-->
<div class='card text-center' id='updateAttributeCard' style='display:none;'>
<div class='card body'>
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
<div class='col-md-4'>
<div class='form-label-group'>
<input type='text' id='updateAttributeName' name="updateAttributeName" required='required' class='form-control' placeholder='Attribute Name'>
<label for='updateAttributeName'>Attribute Name</label>
</div>
</div>
<div class='col-md-3'>
<select name='updateDataType' id="updateDataType">
<h3>
<option value='-1' class='btn btn-light btn-block' select>&lt;Data Type&gt;</option>
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
</h3>
</select>
</div>
<div class='col-md-3'>
<div class='form-label-group'>
<input type='text' id='updateDataTypeSize' name="updateDataTypeSize" required='required' class='form-control' placeholder='Data Type Size'>
<label for='updateDataTypeSize'>Data Type Size</label>
</div>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form row ends-->
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
&nbsp;&nbsp;
<table border='0'>
<tr>
<td>Primary Key</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='updateIsPrimaryKey' id='updateIsPrimaryKey' value='1'></td>
<td>&nbsp;&nbsp;</td>
<td>Allow Auto Increment</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='updateIsAutoIncrement' id='updateIsAutoIncrement' value='1'></td>
</tr>
<tr>
<td>Unique Key</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='updateIsUniqueKey' id='updateIsUniqueKey' value='1'></td>
<td>&nbsp;&nbsp;</td>
<td>Not Null</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='updateIsNotNull' id='updateIsNotNull' value='1'></td>
</tr>
</table>
<div class='col-md-1'>
</div>
<div class='form-label-group col-md-4'>
<input type='text' id='updateDefaultValue' name="updateDefaultValue" required='required' class='form-control' placeholder='Default Value'>
<label for='updateDefaultValue'>Default Value</label>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form Row Ends-->
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
<div class='col-md-10'>
<div class="form-group">
<textarea class="note" name="updateAttributeNote" id="updateAttributeNote" rows="2" cols='82' placeholder='Note'></textarea>
<label for="updateAttributeNote"></label>
</div>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form Row Ends-->
<div class='form-row'>
<div class='col-md-3'>
</div>
<button type='button' class='btn btn-info col-md-3' onclick='updateAttributeData()'>Update</button>
<button type='button' class='btn btn-danger col-md-3' onclick='cancelUpdate()'>Cancel</button>
</div><!-- Form Row Ends-->
<br style='display:block;content:"";margin-top: 4;'>
</div><!-- Card body ends-->
</div><!-- Update Card ends-->

<!-- Delete Card Start-->
<div class='card text-center' style='display:none;' id='deleteAttributeCard'>
<div class='card body'>
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
<div class='col-md-4'>
<div class='form-label-group'>
Attribute Name : 
<span id='deleteAttributeName'></span>
</div>
</div>
<div class='col-md-3'>
Data Type : 
<span id='deleteDataType'></span>
</div>
<div class='col-md-3'>
<div class='form-label-group'>
Data Type Size : 
<span id='deleteDataTypeSize'></span>
</div>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form row ends-->
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
&nbsp;&nbsp;
<table border='0'>
<tr>
<td>Primary Key</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='deleteIsPrimaryKey' id='deleteIsPrimaryKey' value='1' disabled></td>
<td>&nbsp;&nbsp;</td>
<td>Allow Auto Increment</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='deleteIsAutoIncrement' id='deleteIsAutoIncrement' value='1' disabled></td>
</tr>
<tr>
<td>Unique Key</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='deleteIsUniqueKey' id='deleteIsUniqueKey' value='1' disabled></td>
<td>&nbsp;&nbsp;</td>
<td>Not Null</td>
<td>&nbsp;&nbsp;</td>
<td><input type='checkbox' name='deleteIsNotNull' id='deleteIsNotNull' value='1' disabled></td>
</tr>
</table>
<div class='col-md-1'>
</div>
<div class='form-label-group col-md-4'>
Default Value :
<span id='deleteDefaultValue'></span>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form Row Ends-->
<br style='display:block;content:"";margin-top: 4;'>
<div class='form-row'>
<div class='col-md-1'>
</div>
<div class='col-md-10'>
<div class="form-group">
Note : 
<span id='deleteAttributeNote'></span>
</div>
</div>
<div class='col-md-1'>
</div>
</div><!-- Form Row Ends-->
<div class='form-row'>
<div class='col-md-3'>
</div>
<button type='button' class='btn btn-info col-md-3' onclick='deleteAttributeData()'>Delete</button>
<button type='button' class='btn btn-danger col-md-3' onclick='cancelDelete()'>Cancel</button>
</div><!-- Form Row Ends-->
<br style='display:block;content:"";margin-top: 4;'>
</div><!-- Card body ends-->
</div><!-- Delete Card ends-->


</div><!-- attribute tab ends-->
</div><!-- table tab ends-->

</div><!-- modal body tag-->
</div>
</div>
</div>


</body>
</html>