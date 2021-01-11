<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@taglib uri="/WEB-INF/tlds/mytags.tld" prefix="tm" %>
<tm:MemberLoggedOut>
<jsp:forward page='/memberLogInForm.jsp' />
</tm:MemberLoggedOut>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Charts</title>
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
--!>
    <!-- Bootstrap core CSS-->
    <link href="/tmdmmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="/tmdmmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/tmdmmodel/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/tmdmmodel/css/sb-admin.css" rel="stylesheet">
<script src="/tmdmmodel/vendor/jquery/jquery.min.js"></script>
<script>
function validate()
{
var createProjectModalForm=$("#createProjectModalForm");
var projectName=createProjectModalForm.find("#projectName");
var isFocus;
var errors=0;
if(!projectName.val().trim())
{
console.log("1");
projectName.addClass("is-invalid");
projectName.focus();
isFocus=true;
errors++;
}
console.log("2");
var selectBox=document.getElementById('databaseArchitecture');
if(selectBox.selectedIndex==0)
{
console.log("3");
$("#databaseArchitectureSpan").text("Invalid");
if(!isFocus) selectBox.focus();
errors++;
isFocus=true;
}
var databaseArchitecture=selectBox.value;
console.log("4");
var obj={
"argument-1":projectName.val(),
"argument-2":databaseArchitecture
};
console.log(JSON.stringify(obj));
$.ajax("/tmdmmodel/webservice/projectService/createProjectVerification",{
type:"POST",
contentType:"application/json",
data:JSON.stringify(obj),
success: function(res)
{
if(res.success)
{
if(res.isReturningSomething) console.log(res.result);
else alert("Work Done");
}
else
{
if(res.isException) alert(res.exception);
else alert(res.error);
}
},
error: function(error){
alert("Error is : "+error);
}
});
console.log("5");
if(errors==0)
{
console.log("6");
$('#createProjectModal').modal('hide');
}
}
</script>
  </head>

  <body id="page-top">

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" id="sidebarToggle" href="#">Menu</a>

      <!-- Navbar -->
      <ul class="navbar-nav ml-auto ml-md-10">
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	<i class="fas fa-user-circle fa-fw"></i>
        </a>
</li>
<li class="nav-item dropdown no-arrow">
<h6 class='text-info'>${member.firstName}</h6>
</li>
      </ul>

    </nav>

    <div id="wrapper">

      <!-- Sidebar -->
      <ul class="sidebar navbar-nav">
        <li class="nav-item active">
<button class="btn btn-link btn-lg text-white" data-toggle="modal" data-target="#createProjectModal">
My Subscription
</button>
        </li>
        <li class="nav-item active">
<button class="btn btn-link btn-lg text-white" data-toggle="modal" data-target="#createProjectModal">
Create Project
</button>
        </li>
        <li class="nav-item active">
<button class="btn btn-link btn-lg text-white" data-toggle="modal" data-target="#createProjectModal">
Open Project
</button>
        </li>
        <li class="nav-item active">
<button class="btn btn-link btn-lg text-white" data-toggle="modal" data-target="#createProjectModal">
New Project
</button>
        </li>
        <li class="nav-item active">
<button class="btn btn-link btn-lg text-white" data-toggle="modal" data-target="#createProjectModal">
Edit Profile
</button>
        </li>
        <li class="nav-item active">
<button class="btn btn-link btn-lg text-white" data-toggle="modal" data-target="#myModal">
Logout
</button>
</li>

      </ul>
      
    </div>
  </div>


      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Breadcrumbs-->
        </div>
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright © Vinay Jain 2018</span>
            </div>
          </div>
        </footer>

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->



    <!-- Bootstrap core JavaScript-->
    <script src="/tmdmmodel/vendor/jquery/jquery.min.js"></script>
    <script src="/tmdmmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/tmdmmodel/vendor/jquery-easing/jquery.easing.min.js"></script>

	
    <!-- Custom scripts for all pages-->
    <script src="/tmdmmodel/js/sb-admin.min.js"></script>

<div class="modal fade" id="createProjectModal" role="dialog">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Create Project</h4>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<div class="modal-body">
<form id='createProjectModalForm'>
<div class='form-group'>
<div class='form-label-group'>
<input type='text' id='projectName' placeholder='Name of Project' required='required' class='form-control' value="abcd">
<label for='username'>Name of project</label>
</div>
</div>
<div class="dropdown">
<select id="databaseArchitecture">
<!--option value='-1' class='btn btn-light btn-block'>&lt;Select&gt;</option--!>
<c:forEach items="${databaseArchitectures}" var="da">
<option value='${da.code}' class='btn btn-light btn-block'>${da.name}</option>
</c:forEach>
</select>
<span id='databaseArchitectureSpan' class='text-danger'></span>
</div>
</form>
</div>
<div class="modal-footer">
<input type='submit' class='btn btn-success' onclick='validate()'>
<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
</div>
</div>
</div>
</div>

<div class="modal fade" id="myModal" role="dialog">
<div class="modal-dialog">
<!-- Modal content-->
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Logout</h4>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<div class="modal-body">
<p>Are You Sure ?</p>
</div>
<div class="modal-footer">
<button type="button" class='btn btn-success' onclick="window.location='/tmdmmodel/webservice/projectService/logout';" data-dismiss="modal">Yes</button>
<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
</div>
</div>
</div>
</div>
</body>