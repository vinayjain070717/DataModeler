package com.thinking.machines.dmodel.beans;
import java.util.*;
public class ErrorBean implements java.io.Serializable
{
private LinkedList<String> errors=new LinkedList<String>();
private HashMap<String,String> map=new HashMap<String,String>();
public void addErrors(String property,String error)
{
map.put(property,error);
}
public void addErrors(String error)
{
errors.add(error);
}
public String getErrors(String property)
{
String error=map.get(property);
if(errors==null) error="";
return error;
}
public LinkedList<String> getGenericError()
{
return this.errors;
}
public boolean hasErrors()
{
return this.errors.size()>0 || this.map.size()>0;
}
}