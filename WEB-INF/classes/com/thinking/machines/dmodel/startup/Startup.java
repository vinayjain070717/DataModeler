package com.thinking.machines.dmodel.startup;
import com.thinking.machines.tmws.captcha.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import com.thinking.machines.dmodel.services.pojo.*;
@Path("/startup")
public class Startup implements ApplicationAware
{
private ServletContext servletContext;
public void setServletContext(ServletContext servletContext)
{
this.servletContext=servletContext;
}
@InjectApplication
@OnStart(1)
public void start()
{
try
{
System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
System.out.println("+++++++++++++++Data Structure Loading++++++++++++++++");
System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
List<Engine> engines;
List<DataType> dataTypes;
List<DatabaseArchitecture> databaseArchitectures;
DataType dataType;
Engine engine;
DatabaseArchitecture databaseArchitecture;
engines=new LinkedList<Engine>();
databaseArchitectures=new LinkedList<DatabaseArchitecture>();

List<com.thinking.machines.dmodel.dl.DatabaseEngine> dlEngines;
List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dlDataTypes;
List<com.thinking.machines.dmodel.dl.DatabaseArchitecture> dlDatabaseArchitectures;

DataManager dataManager=new DataManager();
dataManager.begin();
dlEngines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).query();
//dlDataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).query();
dlDatabaseArchitectures=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitecture.class).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseEngine e:dlEngines)
{
engine=new Engine();
engine.setCode(e.getCode());
engine.setName(e.getName());
engines.add(engine);
}
for(com.thinking.machines.dmodel.dl.DatabaseArchitecture a:dlDatabaseArchitectures)
{
databaseArchitecture=new DatabaseArchitecture();
databaseArchitecture.setCode(a.getCode());
databaseArchitecture.setName(a.getName());
databaseArchitecture.setMaxWidthOfColumnName(a.getMaxWidthOfColumnName());
databaseArchitecture.setMaxWidthOfTableName(a.getMaxWidthOfTableName());
databaseArchitecture.setMaxWidthOfRelationshipName(a.getMaxWidthOfRelationshipName());
dataManager.begin();
dlDataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("databaseArchitectureCode").eq(databaseArchitecture.getCode()).query();
dataManager.end();
dataTypes=new LinkedList<DataType>();
for(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType d:dlDataTypes)
{
//System.out.println(d.getDataType());
dataType=new DataType();
dataType.setCode(d.getCode());
dataType.setDataType(d.getDataType());
dataType.setMaxWidth(d.getMaxWidth());
dataType.setDefaultSize(d.getDefaultSize());
dataType.setMaxWidthOfPrecision(d.getMaxWidthOfPrecision());
dataType.setAllowAutoIncrement(d.getAllowAutoIncrement());
dataTypes.add(dataType);
}
databaseArchitecture.setDataType(dataTypes);
dataManager.begin();
dlEngines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("databaseArchitectureCode").eq(databaseArchitecture.getCode()).query();
dataManager.end();
LinkedList<Engine> pojoEngines=new LinkedList<Engine>();
for(com.thinking.machines.dmodel.dl.DatabaseEngine e:dlEngines)
{
engine=new Engine();
engine.setCode(e.getCode());
engine.setName(e.getName());
pojoEngines.add(engine);
}
databaseArchitecture.setEngine(pojoEngines);
databaseArchitectures.add(databaseArchitecture);
}
/*System.out.println("After DS");
for(DatabaseArchitecture d:databaseArchitectures)
{
System.out.println(d.getName());
for(Engine e:d.getEngine())
{
System.out.println(e.getCode());
System.out.println(e.getName());
}
}*/
servletContext.setAttribute("engines",engines);
servletContext.setAttribute("databaseArchitectures",databaseArchitectures);
}catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException);
}
}
}