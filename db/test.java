import java.sql.*;
import com.thinking.machines.dmodel.dl.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmodel.utilities.*;
public class test
{
public static void main(String gg[])
{
Date sqlDate=new Date(new java.util.Date().getTime());
System.out.println(sqlDate);
Time time=new Time(new java.util.Date().getTime());
System.out.println(time);
}
}