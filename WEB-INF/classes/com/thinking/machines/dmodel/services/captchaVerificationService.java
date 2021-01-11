package com.thinking.machines.dmodel.services;
import com.thinking.machines.tmws.captcha.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import javax.servlet.*;
import javax.servlet.http.*;
@Path("/Captcha")
public class captchaVerificationService implements SessionAware
{
private HttpSession session;
public void setHttpSession(HttpSession session)
{
System.out.println("Session is being injected");
this.session=session;
}
@InjectSession
@Post
@Path("verify")
public Object verifyCaptcha(String captchaCode)
{
Captcha captcha=(Captcha)session.getAttribute(Captcha.CAPTCHA_NAME);
if(!captcha.isValid(captchaCode)) return -1;
else
{
session.removeAttribute(Captcha.CAPTCHA_NAME);
return 1;
}
}
}