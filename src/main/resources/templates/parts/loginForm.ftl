<#include "security.ftl">
<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <div class="form-group">
            <label for="exampleInputEmail1">User name</label>
            <input type="text" name="username" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter username">
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1">Password</label>
            <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
        </div>
        <#if !isRegisterForm>
            <a href="\registration"> Add new user</a>
        </#if>
        <button type="submit" class="btn btn-primary">
            <#if isRegisterForm> Create
            <#else> Sign In
            </#if>
        </button>
    </form>
</#macro>

<#macro logout>
        <form action=/logout method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-primary" type="submit">
                <#if name != "unknown">
                    Sign Out
                <#else>
                    Sign In
                </#if>
            </button>
        </form>
</#macro>