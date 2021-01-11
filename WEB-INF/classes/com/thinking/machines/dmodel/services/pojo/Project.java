package com.thinking.machines.dmodel.services.pojo;
import java.sql.*;
import java.util.LinkedList;
public class Project
{
private Integer code;
private String title;
private Date dateOfCreation;
private Time timeOfCreation;
private DatabaseArchitecture databaseArchitecture;
private LinkedList<Table> databaseTable;
private Integer canvasWidth;
private Integer canvasHeight;
public Project()
{
this.code=null;
this.title=null;
this.dateOfCreation=null;
this.timeOfCreation=null;
this.databaseArchitecture=null;
this.databaseTable=null;
this.canvasWidth=null;
this.canvasHeight=null;
}
public void setCanvasWidth(Integer canvasWidth)
{
this.canvasWidth=canvasWidth;
}
public Integer getCanvasWidth()
{
return this.canvasWidth;
}
public void setCanvasHeight(Integer canvasHeight)
{
this.canvasHeight=canvasHeight;
}
public Integer getCanvasHeight()
{
return this.canvasHeight;
}
public void setCode(Integer code)
{
this.code=code;
}
public Integer getCode()
{
return this.code;
}
public void setTitle(String title)
{
this.title=title;
}
public String getTitle()
{
return this.title;
}
public void setDateOfCreation(Date dateOfCreation)
{
this.dateOfCreation=dateOfCreation;
}
public Date getDateOfCreation()
{
return this.dateOfCreation;
}
public void setTimeOfCreation(Time timeOfCreation)
{
this.timeOfCreation=timeOfCreation;
}
public Time getTimeOfCreation()
{
return this.timeOfCreation;
}
public void setDatabaseArchitecture(DatabaseArchitecture databaseArchitecture)
{
this.databaseArchitecture=databaseArchitecture;
}
public DatabaseArchitecture getDatabaseArchitecture()
{
return this.databaseArchitecture;
}
public void setTable(LinkedList<Table> databaseTable)
{
this.databaseTable=databaseTable;
}
public LinkedList<Table> getTable()
{
return this.databaseTable;
}
}
