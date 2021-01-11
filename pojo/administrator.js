function Administrator()
{
var username,password,firstName,lastName,mobileNumber,emailId;
this.setUsername=function(username)
{
this.username=username;
}
this.setPassword=function(password)
{
this.password=password;
}
this.setFirstName=function(firstName)
{
this.firstName=firstName;
}
this.setLastName=function(lastName)
{
this.lastName=lastName;
}
this.setMobileNumber=function(mobileNumber)
{
this.mobileNumber=mobileNumber;
}
this.setEmailID=function(emailId)
{
this.emailId=emailId;
}
this.getFirstName=function()
{
return this.firstName;
}
this.getLastName=function()
{
return this.lastName;
}
this.getMobileNumber=function()
{
return this.mobileNumber;
}
this.getEmailID=function()
{
return this.emailId;
}
this.getUsername=function()
{
return this.username;
}
this.getPassword=function()
{
return this.password;
}
}
