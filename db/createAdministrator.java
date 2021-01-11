import com.thinking.machines.dmodel.services.pojo.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmodel.utilities.*;
public class createAdministrator
{
public static void main(String gg[])
{
try
{
Administrator administrator=new Administrator();
String username="vinay jain";
String password="vinayjain";
String passwordKey="Ujjain";
String encryptedPassword=utility.encrypt(password,passwordKey);
administrator.setUsername(username);
administrator.setPassword(encryptedPassword);
administrator.setPasswordKey(passwordKey);
administrator.setEmailId("vinay@dmodel.com");
administrator.setFirstName("vinay");
administrator.setLastName("jain");
administrator.setMobileNumber("433243424");

DataManager dataManager=new DataManager();
dataManager.begin();
dataManager.insert(administrator);
dataManager.end();
}catch(ValidatorException validatorException)
{
System.out.println("Validator Exception");
}
catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException);
}
}
}