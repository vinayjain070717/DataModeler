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
public class test implements ApplicationAware
{
private ServletContext servletContext;
public void setServletContext(ServletContext servletContext)
{
System.out.println("Sessio is being injected");
this.servletContext=servletContext;
}
@InjectApplication
@Path("test")
public void test()
{
List<Engine> engines;
List<DatabaseArchitecture> databaseArchitectures;
engines=(LinkedList<Engine>)servletContext.getAttribute("engines");
databaseArchitectures=(LinkedList<DatabaseArchitecture>)servletContext.getAttribute("databaseArchitectures");
System.out.println("DATABASE ARCHITECTURE");
for(DatabaseArchitecture d:databaseArchitectures)
{
System.out.println(d.getName());
}
System.out.println("ENGINES");
for(Engine e:engines)
{
System.out.println(e.getCode()+"   "+e.getName());
}
}
}