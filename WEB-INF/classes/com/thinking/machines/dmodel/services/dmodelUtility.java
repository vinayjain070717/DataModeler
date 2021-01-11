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
@Path("/dmodelUtility")
public class dmodelUtility
{
	@Post
	@Path("generateScript")
	public String generateScript(String projectCode)
	{
		System.out.println("generate script invoked "+projectCode);
		StringBuilder sb=new StringBuilder();
		List<com.thinking.machines.dmodel.dl.DatabaseTable> dbTables;
		List<com.thinking.machines.dmodel.dl.DatabaseArchitecture> dbArchitectures;
		List<com.thinking.machines.dmodel.dl.DatabaseTableField> dbFields;
		List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dataTypes;
		List<com.thinking.machines.dmodel.dl.DatabaseEngine> engines;
		List<String> uniqueKeyFields;
		List<String> primaryKeyFields;
		DataManager dataManager=new DataManager();
		String databaseEngineCode;
		
		try
		{
			dataManager.begin();
			dbTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(Integer.parseInt(projectCode)).query();
			System.out.println(dbTables.size());
			dataManager.end();
			for(com.thinking.machines.dmodel.dl.DatabaseTable d:dbTables)
			{
			uniqueKeyFields=new LinkedList<>();
			primaryKeyFields=new LinkedList<>();
			databaseEngineCode=String.valueOf(d.getDatabaseEngineCode());
			sb.append("Create table ");
			sb.append(d.getName());
			sb.append(" ");
			sb.append("(");
			sb.append("\n");
			dataManager.begin();
			dbFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(d.getCode()).query();
			dataManager.end();
			for(com.thinking.machines.dmodel.dl.DatabaseTableField f:dbFields)
			{
			sb.append("\t\t");
			sb.append(f.getName());
			sb.append(" ");
			int databaseArchitectureCode=f.getDatabaseArchitectureDataTypeCode();
			dataManager.begin();
			dataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("code").eq(databaseArchitectureCode).query();
			dataManager.end();
			sb.append(dataTypes.get(0).getDataType());
			// sb.append(f.getDatabaseArchitectureDataTypeCode());
			sb.append("(");
			sb.append(f.getWidth());
			sb.append(")");
			sb.append(" ");
			if(f.getIsNotNull())
			{
			sb.append("NOT NULL");
			sb.append(" ");
			}
			if(f.getIsAutoIncrement())
			{
			sb.append("AUTO_INCREMENT");
			sb.append(" ");
			}
			if(f.getIsPrimaryKey()) primaryKeyFields.add(f.getName());
			if(f.getIsUnique()) uniqueKeyFields.add(f.getName());
			sb.append(",");
			sb.append("\n");
			}//database table field loop ends
			for(String a:uniqueKeyFields)
			{
			sb.append("UNIQUE");
			sb.append(" ");
			sb.append("(");
			sb.append(a);
			sb.append(")");
			sb.append(",");
			sb.append("\n");
			}
			for(String b:primaryKeyFields)
			{
			sb.append("PRIMARY KEY");
			sb.append(" ");
			sb.append("(");
			sb.append(b);
			sb.append(")");
			sb.append(",");
			}
			sb.append("\n");
			sb.append(")");
			sb.append(" ");
			sb.append("ENGINE");
			sb.append(" ");
			// /sb.append(databaseEngineCode);
			dataManager.begin();
			engines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("code").eq(Integer.parseInt(databaseEngineCode)).query();
			dataManager.end();
			sb.append(engines.get(0).getName());
			sb.append(";");
			sb.append("\n");
			}//database table loop ends
		}catch(DMFrameworkException dmFrameworkException)
		{
		System.out.println(dmFrameworkException);
		return dmFrameworkException.toString();
		}
		
		System.out.println(sb.toString());
		return sb.toString();
	}
@Path("generateAllScript")
public Object generateAllScript()
{
StringBuilder sb=new StringBuilder();
try
{
List<com.thinking.machines.dmodel.dl.DatabaseTable> dbTables;
List<com.thinking.machines.dmodel.dl.DatabaseArchitecture> dbArchitectures;
List<com.thinking.machines.dmodel.dl.DatabaseTableField> dbFields;
List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dataTypes;
List<com.thinking.machines.dmodel.dl.DatabaseEngine> engines;
List<String> uniqueKeyFields;
List<String> primaryKeyFields;
DataManager dataManager=new DataManager();
String databaseEngineCode;
/*Project currentProject=session.getAttribute("currentProject");
if(currentProject==null)
{
return "session not found";
}
System.out.println(currentProject.getDatabaseArchitectureCode());
dataManager.begin();
dbArchitectures=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitecture.class).where("code").eq(currentProject.getDatabaseArchitectureCode()).query();
dataManager.end();
System.out.println(dbArchitectures.get(0).getName());
if(dbArchitectures.get(0).getName().equals("mysql"))
*/
if(true)
{
dataManager.begin();
//dbTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(project.getCode()).query();
dbTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseTable d:dbTables)
{
uniqueKeyFields=new LinkedList<>();
primaryKeyFields=new LinkedList<>();
databaseEngineCode=String.valueOf(d.getDatabaseEngineCode());
sb.append("Create table ");
sb.append(d.getName());
sb.append(" ");
sb.append("(");
sb.append("\n");
dataManager.begin();
dbFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(d.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseTableField f:dbFields)
{
sb.append("\t\t");
sb.append(f.getName());
sb.append(" ");
int databaseArchitectureCode=f.getDatabaseArchitectureDataTypeCode();
dataManager.begin();
dataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("code").eq(databaseArchitectureCode).query();
dataManager.end();
sb.append(dataTypes.get(0).getDataType());
// sb.append(f.getDatabaseArchitectureDataTypeCode());
sb.append("(");
sb.append(f.getWidth());
sb.append(")");
sb.append(" ");
if(f.getIsNotNull())
{
sb.append("NOT NULL");
sb.append(" ");
}
if(f.getIsAutoIncrement())
{
sb.append("AUTO_INCREMENT");
sb.append(" ");
}
if(f.getIsPrimaryKey()) primaryKeyFields.add(f.getName());
if(f.getIsUnique()) uniqueKeyFields.add(f.getName());
sb.append(",");
sb.append("\n");
}//database table field loop ends
for(String a:uniqueKeyFields)
{
sb.append("UNIQUE");
sb.append(" ");
sb.append("(");
sb.append(a);
sb.append(")");
sb.append(",");
sb.append("\n");
}
for(String b:primaryKeyFields)
{
sb.append("PRIMARY KEY");
sb.append(" ");
sb.append("(");
sb.append(b);
sb.append(")");
sb.append(",");
}
sb.append("\n");
sb.append(")");
sb.append(" ");
sb.append("ENGINE");
sb.append(" ");
// /sb.append(databaseEngineCode);
dataManager.begin();
engines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("code").eq(Integer.parseInt(databaseEngineCode)).query();
dataManager.end();
sb.append(engines.get(0).getName());
sb.append(";");
sb.append("\n");
}//database table loop ends

}//mysql if condition ends
}catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException);
return dmFrameworkException;
}
System.out.println(sb);
return sb;
}//generate script method ends
}//class ends
