<#include "parts/security.ftl">
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
                <div class="card-header">
                    <#if message.car??>
                        <h5>Rent: ${message.car.carname}</h5>
                    <#else>
                        <h5>Rent: <i>unknown</i></h5>
                    </#if>
                </div>

                <div class="card-body m-2">
                    <div>
                        <#if message.car.filename??>
                            <img class="card-img-top" src="/img/${message.car.filename}" alt="Card image cap">
                        </#if>
                    </div>

                    <div class="mt-2">
                        <b>Client: </b>
                        <#if message.author??>
                            ${message.authorName}
                        <#else>
                            <i>unknown</i>
                        </#if>
                    </div>

                    <div class="mt-2">
                        <b>Date:</b>
                        <#if message.datestart??>
                            ${message.datestart}
                        <#else>
                            <i>unknown</i>
                        </#if>
                    </div>

                    <div class="mt-2">
                        <b>Duration: </b>
                        <#if message.duration??>
                            ${message.duration} day
                        <#else>
                            <i>unknown</i>
                        </#if>
                    </div>

                    <div class="mt-2">
                        <b>Order cost: </b>
                        <#if message.car??>
                            $${message.car.cost} per day
                        <#else>
                            <i>is negotiable</i>
                        </#if>
                    </div>

                    <div class="mt-2">
                        <#if message.text??>
                            <b>Comment: </b>
                            ${message.text}
                        </#if>
                    </div>

                    <div class="mt-2">
                        <b>Order status: </b>
                        <#if message.tag??>
                            <#if message.tag == "canceled">
                                <span style="color: dimgray">${message.tag}</span>
                            <#elseIf message.tag == "approve">
                                <span style="color: green">${message.tag}</span>
                            <#elseIf message.tag == "considered">
                                <span style="color: blue">${message.tag}</span>
                            <#elseIf message.tag == "rejected">
                                <span style="color: red">${message.tag}</span>
                            <#else>
                                <span>${message.tag}</span>
                            </#if>
                        <#else>
                            <i>unknown</i>
                        </#if>
                    </div>
                </div>

                <div class="card-footer text-muted">
                    <div>
                        <#if message.tag != "canceled" && isAdmin>
                            <a href="/approve/${message.id}" class="btn btn-secondary">Approve</a>
                            <a href="/reject/${message.id}" class="btn btn-secondary">Reject</a>
                        </#if>
                        <#if message.tag != "canceled" && user?? && user.id == message.getAuthor().id>
                            <a href="/cancel/${message.id}" class="btn btn-secondary">Cancel</a>
                        </#if>
                        <#if user?? && user.id == message.getAuthor().id>
                            <a href="/delete/${message.id}" class="btn btn-secondary">Delete</a>
                        </#if>

                    </div>
                </div>
            </div>
        <#else>
            No message
        </#list>
    </div>
</@c.page>