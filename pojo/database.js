function Database()
{
var databaseServer,portNumber,databaseUsername,databasePassword,databaseName;
this.setDatabaseServer=function(databaseServer)
{
this.databaseServer=databaseServer;
}
this.setPortNumber=function(portNumber)
{
this.portNumber=portNumber;
}
this.setDatabaseUsername=function(databaseUsername)
{
this.databaseUsername=databaseUsername;
}
this.setDatabasePassword=function(databasePassword)
{
this.databasePassword=databasePassword;
}
this.setDatabaseName=function(databaseName)
{
this.databaseName=databaseName;
}
this.getDatabaseServer=function()
{
return this.databaseServer;
}
this.getPortNumber=function()
{
return this.portNumber;
}
this.getDatabaseUsername=function()
{
return this.databaseUsername;
}
this.getDatabasePassword=function()
{
return this.databasePassword;
}
this.getDatabaseName=function()
{
return this.databaseName;
}
}
