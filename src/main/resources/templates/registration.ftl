<#import "parts/common.ftl" as c>
<#import "parts/loginForm.ftl" as l>

<@c.page>
    <div class="mb-1"><h3>Add new user</h3></div>
    ${message?if_exists}
    <@l.login "/registration" true/>
</@c.page>