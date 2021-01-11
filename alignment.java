import java.io.*;
public class alignment
{
public static void main(String gg[])
{
try
{
String oldFilename=gg[0];
String newFilename=gg[1];
String line,line2;
File oldFile=new File(oldFilename);
File newFile=new File(newFilename);
RandomAccessFile randomAccessFile=new RandomAccessFile(oldFile,"rw");
RandomAccessFile raf=new RandomAccessFile(newFile,"rw");
while(randomAccessFile.getFilePointer()<randomAccessFile.length())
{
line=randomAccessFile.readLine();
line2=line.trim();
raf.writeBytes(line2);
raf.writeBytes("\r\n");
}
raf.close();
randomAccessFile.close();
}catch(Exception e)
{
System.out.println(e.getMessage());
}
}
}