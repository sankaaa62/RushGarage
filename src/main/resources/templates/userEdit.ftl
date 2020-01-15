<#import "parts/common.ftl" as c>

<@c.page>
    <div class="form-group">
        <h3> User editor</h3>
    </div>
    <form action="/user" method="post">
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <div class="form-group">
            <input type="text" class="form-control" value="${user.username}" name="username">
        </div>
        <div class="form-group">
            <#list roles as role>
                <label>
                    <input type="checkbox"
                           class="form-control"
                           name="${role}"
                           ${user.roles?seq_contains(role)?string("checked", "")}>
                    ${role}
                </label>
            </#list>
        </div>
            <button type="submit" class="btn btn-primary">Save</button>
    </form>
</@c.page>