function Member()
{
var firstName,lastName,mobileNumber,emailId,password;
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
this.setEmailId=function(emailId)
{
this.emailId=emailId;
}
this.setPassword=function(password)
{
this.password=password;
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
this.getEmailId=function()
{
return this.emailId;
}
this.getPassword=function()
{
return this.password;
}
}
