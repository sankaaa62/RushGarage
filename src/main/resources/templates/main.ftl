<#import "parts/common.ftl" as c>

<@c.page>
    <div class="form-row">
        <div class="form-group col-md-6">
            <form method="get" action="/main" class="form-inline">
                <input type="text" name="filter" class="form-control" value="${filter?ifExists}" placeholder="Search by tag">
                <button type="submit" class="btn btn-primary ml-2">Search</button>
            </form>
        </div>
    </div>

    <div class="card-columns">
        <#list messages as message>
            <div class="card my-3">
                <div class="card-body m-2">
                    <div>
                        <#if message.filename??>
                            <img class="card-img-top" src="/img/${message.filename}" alt="Card image cap">
                        </#if>
                    </div>
                    <span>${message.text}</span>
                    <div class="mt-2">
                        <i>$${message.car.cost} per day</i>
                    </div>
                    <div class="mt-2">
                        <i>Order status: ${message.tag}</i>
                    </div>
                    <div class="mt-2">
                        <b>Сar model:
                            <#if message.car??>
                                ${message.car.carname}
                            </#if>
                        </b>

                    </div>
                </div>
                <div class="card-footer text-muted">
                    ${message.authorName}
                </div>
            </div>
        <#else>
            No message
        </#list>
    </div>
</@c.page>