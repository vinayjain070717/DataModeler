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
@Path("/administratorService")
public class administratorService
{
@Post
@Path("addAdministrator")
public int addAdministrator(Administrator administrator)
{
System.out.println("Add Administrator Service Invoked");
try
{
String passwordKey="God is great, We are thankful to god";
String password=utility.encrypt(administrator.getPassword(),passwordKey);
com.thinking.machines.dmodel.dl.Administrator dlAdministrator=new com.thinking.machines.dmodel.dl.Administrator();
dlAdministrator.setUsername(administrator.getUsername());
dlAdministrator.setPassword(password);
dlAdministrator.setPasswordKey(passwordKey);
dlAdministrator.setEmailId(administrator.getEmailID());
dlAdministrator.setFirstName(administrator.getFirstName());
dlAdministrator.setLastName(administrator.getLastName());
dlAdministrator.setMobileNumber(administrator.getMobileNumber());
DataManager dataManager=new DataManager();
dataManager.begin();
dataManager.insert(dlAdministrator);
dataManager.end();
}catch(ValidatorException validatorException)
{
System.out.println("Validator Exception");
}
catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException);
}
return 0;
}
}