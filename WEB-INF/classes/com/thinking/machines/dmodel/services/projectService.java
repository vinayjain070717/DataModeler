package com.thinking.machines.dmodel.services;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.thinking.machines.dmodel.utilities.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.dmodel.services.pojo.*;
import org.json.simple.*;
@Path("/projectService")
public class projectService implements RequestAware,SessionAware
{
private ServletContext servletContext;
private HttpSession session;
private HttpServletRequest request;
public void setServletContext(ServletContext servletContext)
{
this.servletContext=servletContext;
}
public void setHttpSession(HttpSession session)
{
this.session=session;
}
public void setHttpRequest(HttpServletRequest request)
{
this.request=request;
}
@InjectApplication
@InjectSession
@InjectRequest
@Post
@Path("createProject")
public Object createProject(String projectName,String databaseArchitectureCode)
{
LinkedList<DataType> dataTypes;
LinkedList<Engine> engines;
List<com.thinking.machines.dmodel.dl.Project> dlProjects;
com.thinking.machines.dmodel.dl.Project dlProject;
DatabaseArchitecture databaseArchitecture=null;
LinkedList<DatabaseArchitecture> databaseArchitectures;
//LinkedList<Project> pojoProjects;
com.thinking.machines.dmodel.dl.Member member;
//Project currentProject;
Project pojoProject;

dataTypes=new LinkedList<DataType>();
engines=new LinkedList<Engine>();
member=(com.thinking.machines.dmodel.dl.Member)session.getAttribute("member");
databaseArchitectures=(LinkedList<DatabaseArchitecture>)servletContext.getAttribute("databaseArchitectures");
if(member==null || databaseArchitectures==null)
{
System.out.println("Session expired");
return new TMForward("/404.html");
}
/*for(DatabaseArchitecture d:pojoDatabaseArchitectures)
{
if(d.getCode()==Integer.parseInt(databaseArchitectureCode))
{
pojoDatabaseArchitecture=d;
}
}*/
java.sql.Date sqlDate=new java.sql.Date(new Date().getTime());
java.sql.Time sqlTime=new java.sql.Time(new Date().getTime());
dlProject=new com.thinking.machines.dmodel.dl.Project();
dlProject.setTitle(projectName);
dlProject.setMemberCode(member.getCode());
dlProject.setDatabaseArchitectureCode(Integer.parseInt(databaseArchitectureCode));
dlProject.setDateOfCreation(sqlDate);
dlProject.setTimeOfCreation(sqlTime);
dlProject.setNumberOfTable(0);
dlProject.setCanvasWidth(580);
dlProject.setCanvasHeight(280);
try
{
DataManager dataManager=new DataManager();
dataManager.begin();
dataManager.insert(dlProject);
//System.out.println(dlProject.getCode());
dlProjects=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("code").eq(dlProject.getCode()).query();
dataManager.end();
//pojoProjects=(LinkedList<Project>)session.getAttribute("project");
//currentProject=new Project();
for(com.thinking.machines.dmodel.dl.Project p:dlProjects)
{
//System.out.println(p.getTitle());
pojoProject=new Project();
pojoProject.setCode(p.getCode());
pojoProject.setTitle(p.getTitle());
pojoProject.setDateOfCreation(p.getDateOfCreation());
pojoProject.setTimeOfCreation(p.getTimeOfCreation());
pojoProject.setCanvasWidth(p.getCanvasWidth());
pojoProject.setCanvasHeight(p.getCanvasHeight());
for(DatabaseArchitecture d:databaseArchitectures)
{
if(d.getCode()==Integer.parseInt(databaseArchitectureCode)) databaseArchitecture=d;
}
pojoProject.setDatabaseArchitecture(databaseArchitecture);
if(pojoProject.getTitle().equals(projectName))
{
session.setAttribute("currentProject",pojoProject);
}
//pojoProjects.add(pojoProject);
}
}catch(DMFrameworkException dmFrameworkException)
{
System.out.println("DMFramework Exception  : "+dmFrameworkException);
return new TMForward("/404.html");
}
catch(ValidatorException validatorException)
{
System.out.println("Validator Exception : "+validatorException);
return new TMForward("/404.html");
}
return new TMForward("/projectView.jsp");
}
@Post
@InjectApplication
@InjectSession
@InjectRequest
@Path("openProject")
public Object openProject(String projectCode)
{
try
{
System.out.println("Open Project Form Invoked");
if(projectCode.length()==0 || projectCode==null) return new TMForward("/404.html");
LinkedList<Project> projects=(LinkedList<Project>)session.getAttribute("project");
List<com.thinking.machines.dmodel.dl.Project> dlProject;
LinkedList<DatabaseArchitecture> pojoDatabaseArchitectures;
pojoDatabaseArchitectures=(LinkedList<DatabaseArchitecture>)servletContext.getAttribute("databaseArchitectures");
DatabaseArchitecture pojoDatabaseArchitecture=new DatabaseArchitecture();
boolean projectExists=false;
for(Project p:projects)
{
if(Integer.parseInt(projectCode)==p.getCode()) projectExists=true;
}
if(projectExists)
{
DataManager dataManager=new DataManager();
dataManager.begin();
dlProject=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("code").eq(Integer.parseInt(projectCode)).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.Project p:dlProject)
{
Project pojoProject=new Project();
pojoProject.setCode(p.getCode());
pojoProject.setTitle(p.getTitle());
pojoProject.setDateOfCreation(p.getDateOfCreation());
pojoProject.setTimeOfCreation(p.getTimeOfCreation());
pojoProject.setCanvasWidth(p.getCanvasWidth());
pojoProject.setCanvasHeight(p.getCanvasHeight());
for(DatabaseArchitecture d:pojoDatabaseArchitectures)
{
if(d.getCode().equals(p.getDatabaseArchitectureCode()))
{
pojoDatabaseArchitecture=d;
break;
}
}
pojoProject.setDatabaseArchitecture(pojoDatabaseArchitecture);
if(pojoProject.getCode()==Integer.parseInt(projectCode))
{
session.setAttribute("currentProject",pojoProject);
break;
}
}
return new TMForward("/projectView.jsp");
}
}catch(DMFrameworkException dmFrameworkException)
{
System.out.println("DMFramework Exception  : "+dmFrameworkException);
return false;
}
return new TMForward("/404.html");
}
@Post
@Path("saveProject")
public Object saveProject(Project project)
{
System.out.println("Save Project Service Invoked");
/*System.out.println(project.getCode());
System.out.println(project.getTitle());
System.out.println(project.getDateOfCreation());
System.out.println(project.getTimeOfCreation());
System.out.println(project.getCanvasWidth());
System.out.println(project.getCanvasHeight());
DatabaseArchitecture databaseArchitecture=project.getDatabaseArchitecture();
*/
try
{
List<com.thinking.machines.dmodel.dl.Project> dlProject2;
com.thinking.machines.dmodel.dl.DatabaseTable dlTable=new com.thinking.machines.dmodel.dl.DatabaseTable();
com.thinking.machines.dmodel.dl.DatabaseTableField dlField=new com.thinking.machines.dmodel.dl.DatabaseTableField();
List<com.thinking.machines.dmodel.dl.DatabaseTableField> dlFields2;
List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dlDataType;
DataManager dataManager=new DataManager();
int numberOfTables=0;
boolean tableExists;
int numberOfFields=0;
int tableCode=0;
LinkedList<Table> databaseTable=project.getTable();
for(Table t:databaseTable) numberOfTables++;
dataManager.begin();
dlProject2=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("code").eq(project.getCode()).query();
dataManager.end();
com.thinking.machines.dmodel.dl.Project dlProject=new com.thinking.machines.dmodel.dl.Project();
dlProject.setCode(dlProject2.get(0).getCode());
dlProject.setTitle(project.getTitle());
dlProject.setDateOfCreation(project.getDateOfCreation());
dlProject.setTimeOfCreation(project.getTimeOfCreation());
dlProject.setNumberOfTable(numberOfTables);
dlProject.setCanvasWidth(project.getCanvasWidth());
dlProject.setCanvasHeight(project.getCanvasHeight());
dlProject.setMemberCode(dlProject2.get(0).getMemberCode());
dlProject.setDatabaseArchitectureCode(dlProject2.get(0).getDatabaseArchitectureCode());
dataManager.begin();
dataManager.update(dlProject);
dataManager.end();
List<com.thinking.machines.dmodel.dl.DatabaseTable> dlTable2;
System.out.println("1");
for(Table t:databaseTable)
{
System.out.println("2");
tableExists=false;
for(Field f:t.getField()) numberOfFields++;
dataManager.begin();
//aadadsdasd
dlTable2=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(dlProject2.get(0).getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseTable d:dlTable2)
{
	System.out.println("3");
	System.out.println("table Name "+t.getName()+" Project Code "+project.getCode());
	System.out.println("database table Name "+d.getName()+" Project Code "+d.getProjectCode());
	if(t.getName().equals(d.getName()) && project.getCode().equals(d.getProjectCode()))
	{
		System.out.println("Update database Table");
		tableExists=true;
		tableCode=d.getCode();
		dlTable.setCode(d.getCode());
		dlTable.setProjectCode(project.getCode());
		dlTable.setName(t.getName());
		dlTable.setDatabaseEngineCode(t.getEngine().getCode());
		dlTable.setNote(t.getNote());
		dlTable.setNumberOfFields(numberOfFields);
		dlTable.setXLocation(t.getXLocation());
		dlTable.setYLocation(t.getYLocation());
		System.out.println(d.getCode()+" "+project.getCode()+" "+t.getName()+" "+t.getEngine().getCode()+" "+t.getNote()+" "+numberOfFields+" "+t.getXLocation()+" "+t.getYLocation());
		dataManager.begin();
		System.out.println("table updating");
		dataManager.update(dlTable);
		System.out.println("table updated");
		dlFields2=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(d.getCode()).query();
		System.out.println("table fields selected");
		for(com.thinking.machines.dmodel.dl.DatabaseTableField f:dlFields2)
		{
			System.out.println("table field deleted with code "+f.getCode());
			dataManager.delete(com.thinking.machines.dmodel.dl.DatabaseTableField.class,f.getCode());
		}
		dataManager.end();
		break;
		//delete fields
		//System.out.println(d.getCode());
		//System.out.println(d.getProjectCode());
		//System.out.println(t.getName());
		//System.out.println(numberOfFields);
		//System.out.println(t.getXLocation());
		//System.out.println(t.getYLocation());
	}//if ends
}//for ends
if(!tableExists)
{
	System.out.println("Insert database Table");
	//dlTable.setCode(1);
	dlTable.setProjectCode(project.getCode());
	dlTable.setName(t.getName());
	//System.out.println("Database Engine Code : "+t.getEngine().getCode());
	dlTable.setDatabaseEngineCode(t.getEngine().getCode());
	//System.out.println(t.getNote());
	dlTable.setNote(t.getNote());
	dlTable.setNumberOfFields(numberOfFields);
	dlTable.setXLocation(t.getXLocation());
	dlTable.setYLocation(t.getYLocation());
	// DataManager dataManager2=new DataManager();
	System.out.println("data manager ke uppar");
	// DataManager dataManager2=new DataManager();
	dataManager.begin();
	System.out.println("data manager ke andar");
	System.out.println(project.getCode()+" "+t.getName()+" "+t.getEngine().getCode()+" "+t.getNote()+" "+numberOfFields+" "+t.getXLocation()+" "+t.getYLocation());
	dataManager.insert(dlTable);
	System.out.println("data manager ke andar");
	dataManager.end();
	System.out.println("data manager ke niche");
	t.setCode(dlTable.getCode());
	tableCode=t.getCode();
}//if ends
for(Field f:t.getField())
{
	System.out.println("Insert Field");
	dataManager.begin();
	dlDataType=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("dataType").eq(f.getDataType().getDataType()).query();
	dataManager.end();
	dlField.setTableCode(tableCode);
	dlField.setName(f.getName());
	dlField.setDatabaseArchitectureDataTypeCode(dlDataType.get(0).getCode());
	dlField.setWidth(f.getWidth());
	dlField.setNumberOfDecimalPlaces(f.getNumberOfDecimalPlaces());
	dlField.setIsPrimaryKey(f.getIsPrimaryKey());
	dlField.setIsAutoIncrement(f.getIsAutoIncrement());
	dlField.setIsUnique(f.getIsUnique());
	dlField.setIsNotNull(f.getIsNotNull());
	dlField.setDefaultValue(f.getDefaultValue());
	dlField.setCheckConstraint(" abcd");
	dlField.setNote(f.getNote());
	System.out.println("7");
	dataManager.begin();
	dataManager.insert(dlField);
	dataManager.end();
}
}
}catch(ValidatorException validatorException)
{
System.out.println("Validator Exception : "+validatorException);
System.out.println(validatorException.toString());
return validatorException;
}
// catch(DMFrameworkException dmFrameworkException)
// {
// System.out.println("DM Framework Exception : "+dmFrameworkException.getMessage());
// //return new Exception(dmFrameworkException);
// return dmFrameworkException;
// }
catch(Exception exception)
{
	System.out.println("Exception : "+exception);
	return exception;
}
return "Saved";
}
@InjectSession
@Path("exitProject")
public Object exitProject()
{
System.out.println("Exit Project Service Invoked");
session.removeAttribute("currentProject");
return new TMForward("/memberHomePage.jsp");
}
@Path("loadProjectDS")
public Object LoadProjectDS()
{
JSONObject json=new JSONObject();
try
{
Project project=(Project)session.getAttribute("currentProject");
if(project==null)
{
return "session not found";
}
List<com.thinking.machines.dmodel.dl.Project> dlProjects;
List<com.thinking.machines.dmodel.dl.DatabaseTable> dlTables;
List<com.thinking.machines.dmodel.dl.DatabaseTableField> dlTableFields;
List<com.thinking.machines.dmodel.dl.DatabaseEngine> dlEngines;
List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dlDataTypes;
//LinkedList<Project> pojoProjects=(LinkedList<Project>)session.getAttribute("project");
LinkedList<Project> pojoProjects=new LinkedList<Project>();
LinkedList<Table> pojoTables;
LinkedList<Field> pojoTableFields;
//Project currentProject=new Project();
Project pojoProject;
Table pojoTable;
Engine engine;
Field pojoTableField;
DataType dataType;
DataManager dataManager=new DataManager();
dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("code").eq(project.getCode()).query();
dataManager.end();

for(com.thinking.machines.dmodel.dl.Project p:dlProjects)
{
pojoProject=new Project();
pojoProject.setCode(p.getCode());
pojoProject.setTitle(p.getTitle());
pojoProject.setDateOfCreation(p.getDateOfCreation());
pojoProject.setTimeOfCreation(p.getTimeOfCreation());
pojoProject.setDatabaseArchitecture(project.getDatabaseArchitecture());
pojoProject.setCanvasHeight(p.getCanvasHeight());
pojoProject.setCanvasWidth(p.getCanvasWidth());
dataManager.begin();
dlTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(p.getCode()).query();
dataManager.end();
pojoTables=new LinkedList<Table>();
for(com.thinking.machines.dmodel.dl.DatabaseTable d:dlTables)
{
System.out.println("pojo table chala code"+d.getCode());
pojoTable=new Table();
pojoTable.setCode(d.getCode());
pojoTable.setName(d.getName());
pojoTable.setNote(d.getNote());
//setting engine
dataManager.begin();
dlEngines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("code").eq(d.getDatabaseEngineCode()).query();
dataManager.end();
engine=new Engine();
engine.setCode(dlEngines.get(0).getCode());
engine.setName(dlEngines.get(0).getName());
pojoTable.setEngine(engine);
pojoTable.setXLocation(d.getXLocation());
pojoTable.setYLocation(d.getYLocation());
dataManager.begin();
dlTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(d.getCode()).query();
dataManager.end();
pojoTableFields=new LinkedList<Field>();
for(com.thinking.machines.dmodel.dl.DatabaseTableField f:dlTableFields)
{
System.out.println("pojo field chala table code "+d.getCode());
pojoTableField=new Field();
pojoTableField.setCode(f.getCode());
pojoTableField.setName(f.getName());
pojoTableField.setWidth(f.getWidth());
pojoTableField.setNumberOfDecimalPlaces(f.getNumberOfDecimalPlaces());
pojoTableField.setIsPrimaryKey(f.getIsPrimaryKey());
pojoTableField.setIsAutoIncrement(f.getIsAutoIncrement());
pojoTableField.setIsUnique(f.getIsUnique());
pojoTableField.setIsNotNull(f.getIsNotNull());
pojoTableField.setDefaultValue(f.getDefaultValue());
pojoTableField.setCheckConstraint(f.getCheckConstraint());
pojoTableField.setNote(f.getNote());
//pojoTableField.setDatabaseArchitectureDataType(f.getDatabaseArchitecture().getDataType().get(0));
dataManager.begin();
dlDataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("code").eq(f.getDatabaseArchitectureDataTypeCode()).query();
dataManager.end();
dataType=new DataType();
dataType.setCode(dlDataTypes.get(0).getCode());
dataType.setDataType(dlDataTypes.get(0).getDataType());
dataType.setMaxWidth(dlDataTypes.get(0).getMaxWidth());
dataType.setDefaultSize(dlDataTypes.get(0).getDefaultSize());
dataType.setMaxWidthOfPrecision(dlDataTypes.get(0).getMaxWidthOfPrecision());
dataType.setAllowAutoIncrement(dlDataTypes.get(0).getAllowAutoIncrement());
pojoTableField.setDataType(dataType);
pojoTableFields.add(pojoTableField);
}//field for loop ends
pojoTable.setField(pojoTableFields);
pojoTables.add(pojoTable);
}//table for loop ends
pojoProject.setTable(pojoTables);
if(pojoProject.getTitle().equals(project.getTitle()))
{
json.put("project",pojoProject);
}
pojoProjects.add(pojoProject);
}//project for loop ends
}catch(DMFrameworkException dmFrameworkException)
{
System.out.println("DMFramework Exception  : "+dmFrameworkException);
return new TMForward("/404.html");
}
System.out.println("Json is  : "+json.toString());
return json;
}
}