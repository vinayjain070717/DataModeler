<jsp:useBean id='errorBean' scope='request' class='com.thinking.machines.dmodel.beans.ErrorBean'/>
<h1>Authentication</h1>
<span class='error'>
<tm:Error name='errorBean' scope='request'>
${error}<br>
</tm:Error>
</span>
<form method='post' action='/${ContextName}/AdministratorAuthenticator.jsp' onsubmit='return validate(this)'>
<tm:FormID/>
<table>
<tr><td>Username</td>
<td><input type='text' id='username' name='username'>
<span id='usernameError' class='error'><tm:Error name='errorBean' scope='request' property='username'>${error}</tm:Error></span>
</td></tr>
<tr><td>Password</td>
<td><input type='password' id='password' name='password'>
<span id='passwordError' class='error'><tm:Error name='errorBean' scope='request' property='password'>${error}</tm:Error></span>
</td></tr>
<tr>
<td colspan='2' align='center'>
<img src='webservice/captcha' id='im' />
</td>
</tr>
<tr>
<td>Captcha code</td>
<td><input type='text' name='captchaCode' id='captchaCode' >
<span id='captchaCodeError' class='error'><tm:Error name='errorBean' scope='request' property='captchaCode'>${error}</tm:Error></span>
</td>
</tr>
<tr>
<td colspan='2' align='center'>
<button type='submit'>Login</button>
</td>
</tr>
</table>
</form>