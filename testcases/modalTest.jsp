<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link href="/tmdmmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/tmdmmodel/vendor/jquery/jquery.min.js"></script>
<link href="/tmdmmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/tmdmmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="/tmdmmodel/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
<link href="/tmdmmodel/css/sb-admin.css" rel="stylesheet">
<script src="/tmdmmodel/vendor/jquery/jquery.min.js"></script>
<script src="/tmdmmodel/vendor/jquery/jquery.min.js"></script>
<script src="/tmdmmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/tmdmmodel/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/tmdmmodel/js/sb-admin.min.js"></script>
</head>
<body>
<button class="btn btn-lg" data-toggle="modal" data-target="#attributeModal">
<i class='fas fa-plus'></i>
</button>
<div class='modal fade' id='attributeModal' role='dialog'>
<div class="modal-dialog modal-lg" style='width:1250px;'>
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Attribute Modal</h4>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<div class="modal-body">
Table Name &nbsp;&nbsp;&nbsp;&nbsp;<input type='text' id='tableNameTextField' name='tableNameTextField'>
<br>
<table class="table table-hover table-bordered">
<thead>
<tr>
<th>S.No.</th>
<th>Fields</th>
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
<button type='button' class='btn btn-info' data-toggle='modal' data-target='#addAttributeModal'>Add Attribute</button>
</div>
<div class="modal-footer">
<button type="button" class='btn btn-success'  data-dismiss="modal">Ok</button>
<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
</div>
</div>
</div>
</div>
<div class='modal fade' id='addAttributeModal' role='dialog'>
<div class="modal-dialog modal-lg" style='width:1250px;'>
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Add Attribute Modal</h4>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
<div class="modal-body">
Attribute Name&nbsp;&nbsp;&nbsp;<input type='text'>
<h4>data type</h4>
<select name='argument-2' id="databaseArchitecture">
<option value='-1' class='btn btn-light btn-block'>&lt;Select&gt;</option>
<c:forEach items="${databaseArchitectures}" var="da">
<option value='${da.code}' class='btn btn-light btn-block'>${da.name}</option>
</c:forEach>
</select>
</div>
<div class="modal-footer">
<button type="button" class='btn btn-success'  data-dismiss="modal">Ok</button>
<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
</div>
</div>
</div>
</div>

</body>