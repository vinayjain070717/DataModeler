# Data Modeler
> It is a tool which makes you free from writing sql queries

It is a tool from which user can make schematic of tables of database and this tool will generate sql script automatically.
This tool is made up of using lots of DS, to improve speed and made with thinking a lot about usability for doing operations.

## Prerequisite

These things should be installed and configured in your system for running this application properly.
1) Java (1.8 or higher)
2) Apache tomcat 9
3) Mysql 5.7 

## Features

In this application User can do following functionality
1) Register: 
  1.1) In this user can fill its details, in which some details will check, like if email exists or like if password does not match our constraints etc   
  1.2) Also, there is very powerful, own made captcha verification system. In this we made our own captcha with image processing, in which lots of differnt-different color lines & dots noises are there, and also all letters in captcha are rotated in different angles and some more things. So with such a powerful captcha, it is difficult for robot entries in system.   
2) Login  
  2.1) In this user will be authenticated and also captcha verification is also there.  
  2.2) Also, if user is authenticated successfully then, we populate some DS, like how many project user made earlier, and some more our internal DS. This will be maintained for speed up the processes.
3) Make a new project  
  3.1) In this user can make a new project and will be redirected to projectView page.  
4) Adding Tables  
  4.1) In this user can made a table, which is basically diagramatic representation of which type database table user wants.  
  4.2) Also, user can add/update/delete different fields, constraints, data type of fields etc in this table by opening table properties, which can come from double click on that table.  
  4.3) User can also give database architecture engine want to use, while generating script, like innodb etc  
5) Deleting Tables  
  5.1) User can delete unwanted tables  
6) Move   
  6.1) User can move tables and change position of table.  
  6.2) Actually, we made full this thing will canvas programming and math, so it just redrawing according to position of mouse technically.  
7) Save  
  7.1) User can save its progress, all details will be saved in backend database.  
8) Generate Script  
  8.1) After saving the project, machine can generate sql script, which user can just take in sql file and load it in database easily  
9) Open existing project  
  9.1) User can open and modify their previously saved projects  

In this project we have used a lot of canvas programming. We have also used every possible aspect for security purpose, like restricting backdoor entry   etc.Also any person cannot see populated data structures while taking their values in webpage, as we have used JSTL. We just taken DS in session and use JSTL, for showing in webpage, from these other person cannot see them, atleast by just using page source.


## Building and Configuring

1) Download zip file of this application, and unzip it anywhere.
2) Go to tomcat9 -> webapps folder and paste unzipped folder here
3) renme unzipped folder to "tmdmmodel", if you want to rename something else, then you have to change context-name in web.xml to whatever you named this folder.
4) Go to tmdmmodel -> db folder
5) open mysql by this command
```
mysql -uroot -proot
create database tmDmodeldb;
use tmDmodeldb
source tmdbmodeldb.sql
```
Again you can make a database user instead of using from root, and also make database with different name.
6) Go to tmdmmodel -> WEB-INF -> classes folder and open TMDMFramework.xml in notepad
7) change the name of database, database user, database password etc according to what you have taken earlier.
8) Now our project is ready to use, open tomcat server and visit http://localhost:8080/tmdmmodel/memberSignUpForm.html
Now you will see a sign up form, now for using this application we will make a video and put video link here, so that you can use it easily.

## Running

We will put video link here

## Links

- My Portfolio Link : http://vinayjain.herokuapp.com/
- Project Sign Up Page : 
- Repository: 
- In case of sensitive bugs like security vulnerabilities, please contact vinayomjain@gmail.com directly. We value your effort to improve the security and privacy of this project!


