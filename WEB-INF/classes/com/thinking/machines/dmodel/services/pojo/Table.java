package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
public class Table
{
private Integer code;
private String name;
private String note;
private Engine databaseEngine;
private List<Field> databaseTableField;
private Integer xLocation;
private Integer yLocation;
public Table()
{
this.code=null;
this.name=null;
this.note=null;
this.databaseEngine=null;
this.databaseTableField=null;
this.xLocation=null;
this.yLocation=null;
}
public void setXLocation(Integer xLocation)
{
this.xLocation=xLocation;
}
public Integer getXLocation()
{
return this.xLocation;
}
public void setYLocation(Integer yLocation)
{
this.yLocation=yLocation;
}
public Integer getYLocation()
{
return this.yLocation;
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
public void setNote(String note)
{
this.note=note;
}
public String getNote()
{
return this.note;
}
public void setEngine(Engine databaseEngine)
{
this.databaseEngine=databaseEngine;
}
public Engine getEngine()
{
return this.databaseEngine;
}
public void setField(List<Field> databaseTableField)
{
this.databaseTableField=databaseTableField;
}
public List<Field> getField()
{
return this.databaseTableField;
}
}
