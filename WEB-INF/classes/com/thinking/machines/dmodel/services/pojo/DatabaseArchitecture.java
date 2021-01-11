package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
public class DatabaseArchitecture
{
private Integer code;
private String name;
private List<DataType> databaseArchitectureDataType;
private List<Engine> databaseEngine;
private Integer maxWidthOfColumnName;
private Integer maxWidthOfTableName;
private Integer maxWidthOfRelationshipName;
public DatabaseArchitecture()
{
this.code=null;
this.name=null;
this.maxWidthOfColumnName=null;
this.maxWidthOfTableName=null;
this.maxWidthOfRelationshipName=null;
this.databaseArchitectureDataType=null;
this.databaseEngine=null;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setName(String name)
{
this.name=name;
}
public String getName()
{
return this.name;
}
public void setMaxWidthOfColumnName(Integer maxWidthOfColumnName)
{
this.maxWidthOfColumnName=maxWidthOfColumnName;
}
public Integer getMaxWidthOfColumnName()
{
return this.maxWidthOfColumnName;
}
public void setMaxWidthOfTableName(Integer maxWidthOfTableName)
{
this.maxWidthOfTableName=maxWidthOfTableName;
}
public Integer getMaxWidthOfTableName()
{
return this.maxWidthOfTableName;
}
public void setMaxWidthOfRelationshipName(Integer maxWidthOfRelationshipName)
{
this.maxWidthOfRelationshipName=maxWidthOfRelationshipName;
}
public Integer getMaxWidthOfRelationshipName()
{
return this.maxWidthOfRelationshipName;
}
public void setDataType(List<DataType> databaseArchitectureDataType)
{
this.databaseArchitectureDataType=databaseArchitectureDataType;
}
public List<DataType> getDataType()
{
return this.databaseArchitectureDataType;
}
public void setEngine(List<Engine> databaseEngine)
{
this.databaseEngine=databaseEngine;
}
public List<Engine> getEngine()
{
return this.databaseEngine;
}
}
