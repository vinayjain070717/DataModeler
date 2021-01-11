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
import com.thinking.machines.dmodel.beans.*;
import com.thinking.machines.tmws.captcha.*;
@Path("/memberService")
public class memberService implements RequestAware,SessionAware,ApplicationAware
{
@Post
@Path("signUpService")
public Object signUpService(Member member)
{
com.thinking.machines.dmodel.dl.Member dlMember=new com.thinking.machines.dmodel.dl.Member();
try
{
String firstName,lastName,mobileNumber,emailId,password;
List<com.thinking.machines.dmodel.dl.Member> dbMember;
String passwordKey=UUID.randomUUID().toString();
String status="A";
int numberOfProjects=0;
firstName=member.getFirstName();
lastName=member.getLastName();
mobileNumber=member.getMobileNumber();
emailId=member.getEmailId();
password=member.getPassword();
int errors=0;
LinkedList<String> error=new LinkedList<>();
if(firstName.length()==0)
{
errors++;
error.add("first name required");
}
if(lastName.length()==0)
{
errors++;
error.add("last name required");
}
if(mobileNumber.length()==0)
{
errors++;
error.add("mobile Number required");
}
if(emailId.length()==0)
{
errors++;
error.add("Email Id required");
}
if(password.length()==0)
{
errors++;
error.add("password required");
}
if(errors!=0)
{
return error;
}
String encryptedPassword=utility.encrypt(member.getPassword(),passwordKey);
dlMember.setFirstName(member.getFirstName());
dlMember.setLastName(member.getLastName());
dlMember.setMobileNumber(member.getMobileNumber());
dlMember.setEmailId(member.getEmailId());
dlMember.setPassword(encryptedPassword);
dlMember.setStatus(status);
dlMember.setNumberOfProjects(numberOfProjects);
dlMember.setPasswordKey(passwordKey);
DataManager dataManager=new DataManager();
dataManager.begin();
dbMember=dataManager.select(com.thinking.machines.dmodel.dl.Member.class).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.Member m:dbMember)
{
//System.out.println("database : "+m.getEmailId());
//System.out.println("HTML : "+member.getEmailId());
if(m.getEmailId().equals(member.getEmailId()))
{
System.out.println("Username Exists !!");
return "Username Exists !!";
}
}
dataManager.begin();
dataManager.insert(dlMember);
dataManager.end();
}catch(ValidatorException validatorException)
{
System.out.println("Validator Exception : "+validatorException);
return validatorException;
}
catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException);
return dmFrameworkException;
}
return dlMember;
}
private HttpServletRequest request;
private HttpSession session;
private ServletContext servletContext;
public void setHttpRequest(HttpServletRequest request)
{
this.request=request;
}
public void setHttpSession(HttpSession session)
{
this.session=session;
}
public void setServletContext(ServletContext servletContext)
{
this.servletContext=servletContext;
}
@InjectApplication
@InjectSession
@InjectRequest
@Post
@Path("loginService")
public Object logInService(String emailId,String password,String captchaCode)
{
try
{
List<com.thinking.machines.dmodel.dl.Member> dbMember;
boolean isCredentialsVerified=false;
ErrorBean errorBean=new ErrorBean();
if(emailId==null || emailId.length()==0) errorBean.addErrors("emailId","required");
if(password==null || password.length()==0) errorBean.addErrors("password","required");
if(captchaCode==null || captchaCode.length()==0) errorBean.addErrors("captchaCode","required");
if(errorBean.hasErrors())
{
request.setAttribute("emailId",emailId);
request.setAttribute("password",password);
request.setAttribute("captchaCode",captchaCode);
request.setAttribute("errorBean",errorBean);
return new TMForward("/memberLogInForm.jsp");
}
Captcha captcha=(Captcha)session.getAttribute(Captcha.CAPTCHA_NAME);
if(!captcha.isValid(captchaCode)) errorBean.addErrors("captchaCode","Invalid Captcha");
DataManager dataManager=new DataManager();
dataManager.begin();
dbMember=dataManager.select(com.thinking.machines.dmodel.dl.Member.class).query();
String decryptedPassword;
for(com.thinking.machines.dmodel.dl.Member m:dbMember)
{
decryptedPassword=utility.decrypt(m.getPassword(),m.getPasswordKey());
if(m.getEmailId().equals(emailId) && decryptedPassword.equals(password))
{
session.setAttribute("member",m);
isCredentialsVerified=true;
break;
}
}
if(!isCredentialsVerified)
{
errorBean.addErrors("emailId","Invalid");
errorBean.addErrors("password","Invalid");
}
if(errorBean.hasErrors())
{
request.setAttribute("emailId",emailId);
request.setAttribute("password",password);
request.setAttribute("captchaCode",captchaCode);
request.setAttribute("errorBean",errorBean);
return new TMForward("/memberLogInForm.jsp");
}

com.thinking.machines.dmodel.dl.Member member=(com.thinking.machines.dmodel.dl.Member)session.getAttribute("member");
List<Field> fields;
LinkedList<Table> tables;
List<Project> projects;
fields=new LinkedList<Field>();
tables=new LinkedList<Table>();
projects=new LinkedList<Project>();
Field field;
Table table;
Project project;
Engine engine;
DataType dataType;
DatabaseArchitecture databaseArchitecture;
List<com.thinking.machines.dmodel.dl.Project> dlProjects;
List<com.thinking.machines.dmodel.dl.DatabaseTableField> dlFields;
List<com.thinking.machines.dmodel.dl.DatabaseTable> dlTables;
List<com.thinking.machines.dmodel.dl.DatabaseEngine> dlEngines;
List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dlDataTypes;
List<com.thinking.machines.dmodel.dl.DatabaseArchitecture> dlDatabaseArchitecture;

LinkedList<DatabaseArchitecture> databaseArchitectures;
databaseArchitectures=(LinkedList<DatabaseArchitecture>)servletContext.getAttribute("databaseArchitectures");
List<Engine> engines;
engines=(LinkedList<Engine>)servletContext.getAttribute("engines");
//System.out.println("Engines are : "+engines);
//LinkedList<DataType> dataTypes;
//dataTypes=(LinkedList<DataType>)servletContext.getAttribute("dataTypes");
//System.out.println("Data Types are : "+dataTypes);
dataManager=new DataManager();
dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("memberCode").eq(member.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.Project p:dlProjects)
{
project=new Project();
project.setCode(p.getCode());
project.setTitle(p.getTitle());
project.setDateOfCreation(p.getDateOfCreation());
project.setTimeOfCreation(p.getTimeOfCreation());
project.setCanvasWidth(p.getCanvasWidth());
project.setCanvasHeight(p.getCanvasHeight());
for(DatabaseArchitecture d:databaseArchitectures)
{
if(p.getDatabaseArchitectureCode()==d.getCode()) 
{
databaseArchitecture=d;
//System.out.println(databaseArchitecture);
project.setDatabaseArchitecture(databaseArchitecture);
break;
}
}
dataManager.begin();
dlTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(project.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseTable t:dlTables)
{
table=new Table();
table.setCode(t.getCode());
table.setName(t.getName());
table.setNote(t.getNote());
table.setXLocation(t.getXLocation());
table.setYLocation(t.getYLocation());
//table.setEngine(engines);
//table.setEngine(engines.get(0));
dataManager.begin();
dlEngines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("code").eq(t.getDatabaseEngineCode()).query();
dataManager.end();
//System.out.println(dlEngines.get(0));
engine=new Engine();
engine.setCode(dlEngines.get(0).getCode());
engine.setName(dlEngines.get(0).getName());
table.setEngine(engine);
dataManager.begin();
dlFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(table.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseTableField f:dlFields)
{
field=new Field();
field.setCode(f.getCode());
field.setName(f.getName());
field.setWidth(f.getWidth());
field.setNumberOfDecimalPlaces(f.getNumberOfDecimalPlaces());
field.setIsPrimaryKey(f.getIsPrimaryKey());
field.setIsAutoIncrement(f.getIsAutoIncrement());
field.setIsUnique(f.getIsUnique());
field.setIsNotNull(f.getIsNotNull());
field.setDefaultValue(f.getDefaultValue());
field.setCheckConstraint(f.getCheckConstraint());
field.setNote(f.getNote());
//dlDataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("databaseArchitectureCode").eq(f.getDatabaseArchitectureCode()).query();
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
field.setDataType(dataType);
//field.setDataType(project.getDatabaseArchitecture().getDataType().get(0));
//field.setDataType(dataTypes);
fields.add(field);
}
table.setField(fields);
tables.add(table);
}
project.setTable(tables);
projects.add(project);
}
session.setAttribute("project",projects);
return new TMForward("/memberHomePage.jsp");
}catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException);
return dmFrameworkException;
}
catch(Exception e)
{
System.out.println("Exception : "+e);
return e;
}
}
@InjectSession
@InjectRequest
@Path("logout")
public Object logout()
{
System.out.println("Logged Out Service Invoked");
session.removeAttribute("member");
return new TMForward("/memberLogInForm.jsp");
}
}