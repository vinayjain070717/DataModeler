import java.sql.*;
import com.thinking.machines.dmodel.dl.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmodel.utilities.*;
public class AddSubscription
{
public static void main(String gg[])
{
try{
//Date date=new Date(1998-1900,07-1,21);
//System.out.println(date);
//java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-mm-dd");
//String currentDate=sdf.format(date);
//java.util.Date current=sdf.parse(sdf.format(date));
//java.util.GregorianCalendar calendar=new //java.util.GregorianCalendar();
//calendar.setTime(current);
//System.out.println(calendar.getTime());
}catch(Exception e)
{
System.out.println(e);
}
/*
try
{
int monthlyRate=Integer.parseInt(gg[0]);
int yearlyRate=Integer.parseInt(gg[1]);
int freeProjects=Integer.parseInt(gg[2]);
int freeTables=Integer.parseInt(gg[3]);
DataManager dataManager=new DataManager();
SubscriptionPlan subscriptionPlan=new SubscriptionPlan();
subscriptionPlan.setEffectiveFrom(date);
subscriptionPlan.setMonthlyRate(monthlyRate);
subscriptionPlan.setYearlyRate(yearlyRate);
subscriptionPlan.setFreeProjects(freeProjects);
subscriptionPlan.setFreeTables(freeTables);
dataManager.begin();
dataManager.insert(subscriptionPlan);
dataManager.end();
}catch(ValidatorException validatorException)
{
System.out.println(validatorException);
}
catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException);
}
*/
}
}