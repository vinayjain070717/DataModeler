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
public class AddDatabaseTable
{
public static void main(String gg[])
{
try
{
com.thinking.machines.dmodel.dl.DatabaseTable dlTable=new com.thinking.machines.dmodel.dl.DatabaseTable();
dlTable.setProjectCode(76);
dlTable.setName("abcd");
dlTable.setDatabaseEngineCode(4);
dlTable.setNote(" ");
dlTable.setNumberOfFields(0);
dlTable.setXLocation(513);
dlTable.setYLocation(43);
DataManager dataManager=new DataManager();
dataManager.begin();
dataManager.insert(dlTable);
dataManager.end();
}catch(DMFrameworkException dmFrameworkException)
{
System.out.println("DMFramework Exception  : "+dmFrameworkException);
}
catch(ValidatorException validatorException)
{
System.out.println("Validator Exception : "+validatorException);
}
}
}